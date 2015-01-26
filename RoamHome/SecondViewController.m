//
//  SecondViewController.m
//  RoamHome
//
//  Created by David Mazza on 1/25/15.
//  Copyright (c) 2015 Peaking Software LLC. All rights reserved.
//

#import "SecondViewController.h"
#import "Trip.h"
#import "UberAPIManager.h"

@interface SecondViewController ()

@property (strong, nonatomic) UberAPIManager *apiManager;

@end

@implementation SecondViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.apiManager = [[UberAPIManager alloc] initWithClientID:kUberClientID
                                                       serverToken:kUberServerToken
                                                            secret:kUberSecret];
        self.trips = [self.apiManager getTripHistory];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CLLocation *home = [self findNearestLocationToCentroid:[self findCentroidInLocations:[self potentialHomeLocations]]];
    CLLocation *work = [self findNearestLocationToCentroid:[self findCentroidInLocations:[self potentialWorkLocations]]];
    
    [self.mapView setRegion:MKCoordinateRegionMake([[self findCentroidInLocations:@[home, work]] coordinate],
                                                   MKCoordinateSpanMake(ABS(home.coordinate.latitude - work.coordinate.latitude) * 2,
                                                                        ABS(home.coordinate.longitude - work.coordinate.longitude) * 2))];
    
    MKPointAnnotation *homeAnnotation = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *workAnnotation = [[MKPointAnnotation alloc] init];
    [homeAnnotation setCoordinate:home.coordinate];
    [homeAnnotation setTitle:@"Home"];
    [homeAnnotation setSubtitle:[self findNearestAddressToLocation:home]];
    [workAnnotation setCoordinate:work.coordinate];
    [workAnnotation setTitle:@"Work"];
    [workAnnotation setSubtitle:[self findNearestAddressToLocation:work]];
    [self.mapView addAnnotation:homeAnnotation];
    [self.mapView addAnnotation:workAnnotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHome:(id)sender {
    CLLocation *home = [self findNearestLocationToCentroid:[self findCentroidInLocations:[self potentialHomeLocations]]];
    NSURL *uberURL = [NSURL URLWithString:[NSString stringWithFormat:@"uber://?client_id=%@&action=setPickup&pickup=my_location&dropoff[latitude]=%f&dropoff[longitude]=%f&dropoff[nickname]=Home", kUberClientID, home.coordinate.latitude, home.coordinate.longitude]];
//     NSURL *uberURL = [NSURL URLWithString:[NSString stringWithFormat:@"uber://?client_id=%@&action=setPickup&pickup=my_location&dropoff[latitude]=%f&dropoff[longitude]=%f&dropoff[nickname]=Home", kUberClientID, home.coordinate.latitude, home.coordinate.longitude]];
//    NSURLRequest *uberRequest = [[NSURLRequest alloc] initWithURL:];
    
    [[UIApplication sharedApplication] openURL:uberURL];
}

- (NSArray *)potentialHomeLocations {
    NSMutableArray *homeLocations = [[NSMutableArray alloc] init];
    
    for (Trip *trip in self.trips) {
        if ([[NSDateFormatter localizedStringFromDate:trip.requestTime dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle] containsString:@"AM"]) {
            [homeLocations addObject:trip.startLocation];
        } else {
            [homeLocations addObject:trip.endLocation];
        }
    }
    
    return [NSArray arrayWithArray:homeLocations];
}
                        
- (NSArray *)potentialWorkLocations {
    NSMutableArray *homeLocations = [[NSMutableArray alloc] init];
    
    for (Trip *trip in self.trips) {
        if ([[NSDateFormatter localizedStringFromDate:trip.requestTime dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle] containsString:@"PM"]) {
            [homeLocations addObject:trip.startLocation];
        } else {
            [homeLocations addObject:trip.endLocation];
        }
    }
    
    return [NSArray arrayWithArray:homeLocations];
}

- (CLLocation *)findCentroidInLocations:(NSArray *)locations {
    CLLocation *centroid;
    CGFloat latitudeSum = 0;
    CGFloat longitudeSum = 0;
    for (CLLocation *location in locations) {
        latitudeSum += location.coordinate.latitude;
        longitudeSum += location.coordinate.longitude;
    }
    centroid = [[CLLocation alloc] initWithLatitude:latitudeSum / locations.count longitude:longitudeSum / locations.count];
    
    return centroid;
}

- (NSString *)findNearestAddressToLocation:(CLLocation *)aLocation {
    NSString *nearestAddress;
    CGFloat shortestDistance = CGFLOAT_MAX;
    for(Trip *trip in self.trips) {
        CLLocation *location = trip.startLocation;
        CLLocation *location2 = trip.endLocation;
        if(ABS([location distanceFromLocation:aLocation]) < shortestDistance) {
            nearestAddress = trip.startAddress;
            shortestDistance = ABS([location distanceFromLocation:aLocation]);
        }
        if(ABS([location2 distanceFromLocation:aLocation]) < shortestDistance) {
            nearestAddress = trip.endAddress;
            shortestDistance = ABS([location2 distanceFromLocation:aLocation]);
        }
    }
    
    return nearestAddress;
}

- (CLLocation *)findNearestLocationToCentroid:(CLLocation *)aLocation {
    CLLocation *nearestLocation;
    CGFloat shortestDistance = CGFLOAT_MAX;
    for(Trip *trip in self.trips) {
        CLLocation *location = trip.startLocation;
        CLLocation *location2 = trip.endLocation;
        if(ABS([location distanceFromLocation:aLocation]) < shortestDistance) {
            nearestLocation = location;
            shortestDistance = ABS([location distanceFromLocation:aLocation]);
        }
        if(ABS([location2 distanceFromLocation:aLocation]) < shortestDistance) {
            nearestLocation = location2;
            shortestDistance = ABS([location2 distanceFromLocation:aLocation]);
        }
    }
    
    return nearestLocation;
}

@end
