//
//  SecondViewController.h
//  RoamHome
//
//  Created by David Mazza on 1/25/15.
//  Copyright (c) 2015 Peaking Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SecondViewController : UIViewController

@property (strong, nonatomic) NSArray *trips;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

