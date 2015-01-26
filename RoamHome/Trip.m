//
//  Trip.m
//  RoamHome
//
//  Created by David Mazza on 1/25/15.
//  Copyright (c) 2015 Peaking Software LLC. All rights reserved.
//

#import "Trip.h"

@implementation Trip

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.uuid = json[@"uuid"];
        self.requestTime = [NSDate dateWithTimeIntervalSince1970:[json[@"request_time"] doubleValue]];
        self.startAddress = json[@"start_location"][@"address"];
        self.endAddress = json[@"end_location"][@"address"];
        self.startLocation = [[CLLocation alloc] initWithLatitude:[json[@"start_location"][@"latitude"] doubleValue]
                                                        longitude:[json[@"start_location"][@"longitude"] doubleValue]];
        self.endLocation = [[CLLocation alloc] initWithLatitude:[json[@"end_location"][@"latitude"] doubleValue]
                                                      longitude:[json[@"end_location"][@"longitude"] doubleValue]];
    }
    return self;
}

@end
