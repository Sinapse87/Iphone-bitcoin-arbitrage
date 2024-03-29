//
//  TagsTVC.m
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "TagsTVC.h"
#import "MapVC.h"
#import "PhotosTVC.h"
#import "FlickrFetcher.h"

@interface TagsTVC () <MapVCDelegate>
@property (nonatomic, strong) NSMutableArray *dataModel;
@end

@implementation TagsTVC

- (NSMutableArray *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [NSMutableArray array];
    }
    return _dataModel;
}

- (IBAction)showMapVC:(id)sender
{
    [self performSegueWithIdentifier:@"Show MapVC" sender:self];
}

- (IBAction)clearTVC:(id)sender
{
    self.dataModel = nil;
    [self.tableView reloadData];
}

- (void)flickrFetch:(CLLocationCoordinate2D)location locationName:(NSString *)locationName
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    [FlickrFetcher startFlickrFetch:[FlickrFetcher urlForPlacesFindByLatLon:location] completion:^(NSData *jsonData) {
        if (jsonData)
        {
            NSDictionary *plistDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
            NSArray *places = [plistDict valueForKeyPath:FLICKR_PLACES];
            if (places.count > 0)
            {
                NSString *placeID = places[0][FLICKR_PLACE_ID];
                [FlickrFetcher startFlickrFetch:[FlickrFetcher urlForPlacesTagsForPlace:placeID] completion:^(NSData *jsonData) {
                    NSDictionary *plistDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
                    NSArray *tags = [plistDict valueForKeyPath:FLICKR_TAGS];
                    tags = [tags subarrayWithRange:NSMakeRange(0, MIN(8, tags.count))];
                    [self.dataModel addObject:@{@"section_name": locationName ? locationName : placeID,
                                                @"section_content" : tags,
                                                FLICKR_PLACE_ID: placeID}];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                        [spinner stopAnimating];
                        self.navigationItem.rightBarButtonItem = button;
                    });
                }];
            }
        }
        
    }];
    
}

- (void)mapVCDelegate:(MapVC *)mapVC didSelectLocation:(CLLocationCoordinate2D)location
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CLLocation *coreLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:coreLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSString *locationName = nil;
         if ([placemarks count] > 0 && error == nil)
         {
             NSArray *formattedAddressLines = ((MKPlacemark *) placemarks[0]).addressDictionary[@"FormattedAddressLines"];
             if (formattedAddressLines.count > 2)
             {
                 formattedAddressLines = @[formattedAddressLines[formattedAddressLines.count - 2], formattedAddressLines[formattedAddressLines.count - 1]];
             }
             locationName = [formattedAddressLines  componentsJoinedByString:@", "];
         }
         [self flickrFetch:location locationName:locationName];
         
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataModel.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel[section][@"section_content"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataModel[section][@"section_name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *sectionContent = self.dataModel[indexPath.section][@"section_content"];
    
    // Configure the cell...
    cell.textLabel.text = sectionContent[indexPath.row][FLICKR_PLACE_NAME];
    cell.detailTextLabel.text = sectionContent[indexPath.row][@"count"];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show MapVC"])
    {
        [segue.destinationViewController setDelegate:self];
    }
    else if ([segue.identifier isEqualToString:@"Show PhotosTVC"])
    {
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSString *placeID = self.dataModel[indexPath.section][FLICKR_PLACE_ID];
        [segue.destinationViewController setDataModel:@{FLICKR_PLACE_ID : placeID , FLICKR_PLACE_NAME : cell.textLabel.text}];
    }
}


@end