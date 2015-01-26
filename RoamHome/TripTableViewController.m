//
//  TripTableViewController.m
//  RoamHome
//
//  Created by David Mazza on 1/25/15.
//  Copyright (c) 2015 Peaking Software LLC. All rights reserved.
//

#import "TripTableViewController.h"
#import "Trip.h"

@interface TripTableViewController ()

@end

@implementation TripTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.trips = [[NSMutableArray alloc] init];
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
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return self.trips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];
    Trip *trip = self.trips[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ > %@", trip.startAddress, trip.endAddress];
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:trip.requestTime dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
