//
//  UberAPIManager.h
//  RoamHome
//
//  Created by David Mazza on 1/25/15.
//  Copyright (c) 2015 Peaking Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kUberClientID = @"7Sa0L5rqKArnQ2-a3N0CxgRNsjJ102-w";
static NSString *const kUberServerToken = @"DK6IqOrewLXrJXorhB2O_wr2J9Ls4t6XeFonlkNM";
static NSString *const kUberSecret = @"45QQeLbuMN_R-KyPPcA9cTZIt3AqVWHgRUddOiBh";

@interface UberAPIManager : NSObject

@property (strong, nonatomic) NSString *accessToken;

- (instancetype)initWithClientID:(NSString *)aClientID serverToken:(NSString *)aToken secret:(NSString *)aSecret;
// TODO: something to authenticate a user
- (NSArray *)getTripHistory;

@end
