//
//  UberAPIManager.m
//  RoamHome
//
//  Created by David Mazza on 1/25/15.
//  Copyright (c) 2015 Peaking Software LLC. All rights reserved.
//

#import "UberAPIManager.h"
#import "Trip.h"



@interface UberAPIManager()

@property (strong, nonatomic) NSMutableArray *trips;

@end

@implementation UberAPIManager

- (instancetype)initWithClientID:(NSString *)aClientID serverToken:(NSString *)aToken secret:(NSString *)aSecret {
    self = [super init];
    if (self) {
        self.trips = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}

- (NSArray *)getTripHistory {
    // TODO: Get real trips here
    
    NSArray *jsonTrips = @[
                           @{
                               @"uuid": @"7354db54-cc9b-4961-81f2-0094b8e2d215",
                               @"request_time": @1401884467,
                               @"product_id": @"edf5e5eb-6ae6-44af-bec6-5bdcf1e3ed2c",
                               @"status": @"completed",
                               @"distance": @0.0279562,
                               @"start_time": @1401884646,
                               @"start_location": @{
                                       @"address": @"706 Mission St, San Francisco, CA",
                                       @"latitude": @(37.7860099),
                                       @"longitude": @(-122.4025387)
                                       },
                               @"end_time": @1401884732,
                               @"end_location": @{
                                       @"address": @"1455 Market Street, San Francisco, CA",
                                       @"latitude": @(37.7758179),
                                       @"longitude": @(-122.4180285)
                                       }
                               }
                           ];
    
    
    for (NSDictionary *json in jsonTrips) {
        [self.trips addObject:[[Trip alloc] initWithJSON:json]];
    }
    return [NSArray arrayWithArray:self.trips];
}

@end
