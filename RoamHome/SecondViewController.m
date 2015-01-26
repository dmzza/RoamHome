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
    
    CLLocation *home = [self findCentroidInLocations:[self potentialHomeLocations]];
    self.homeAddressLabel.text = [self findNearestAddressToLocation:home];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
