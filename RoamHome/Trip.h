//
//  Trip.h
//  RoamHome
//
//  Created by David Mazza on 1/25/15.
//  Copyright (c) 2015 Peaking Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Trip : NSObject

@property (strong, nonatomic) NSString *uuid;
@property (strong, nonatomic) NSDate *requestTime;
@property (strong, nonatomic) NSString *startAddress;
@property (strong, nonatomic) NSString *endAddress;
@property (strong, nonatomic) CLLocation *startLocation;
@property (strong, nonatomic) CLLocation *endLocation;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
