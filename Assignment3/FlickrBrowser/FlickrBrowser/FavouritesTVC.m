//
//  FavouritesTVC.m
//  FlickrBrowser
//
//  Created by LUCA ALIBERTI on 20/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "FavouritesTVC.h"
#import "AppDelegate.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"
#import "PhotoVC.h"


@interface FavouritesTVC ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation FavouritesTVC

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        _context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    }
    return _context;
}

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
}

- (IBAction)refresh:(id)sender
{
    [self.refreshControl beginRefreshing];
    [self fetchFlickrData:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
        });
    }];
}

- (void)fetchFlickrData:(void (^)())completion
{
    NSURL *flickrRequestURL = [FlickrFetcher urlForRecentGeoreferencedPhotos];
    [FlickrFetcher startFlickrFetch:flickrRequestURL completion:^(NSData *data) {
        if (data)
        {
            NSDictionary *plistDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSArray *photos = [plistDict valueForKeyPath:FLICKR_PHOTOS];
            dispatch_async(dispatch_get_main_queue(), ^{
                for (NSDictionary *photo in photos)
                {
                    [Photo photoWithDict:photo inManagedObjectContext:self.context];
                }
                [((AppDelegate *)[UIApplication sharedApplication].delegate) saveContext];
            });
        }
        if (completion) completion();
    }];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Favourites";
    // Do any additional setup after loading the view.
    self.debug = YES;
    [self setupFetchedResultsController];
    //[self fetchFlickrData:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.contentView.frame.size.height, cell.contentView.frame.size.height), NO, 0.0);
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIGraphicsEndImageContext();
    
    NSURL *url = [NSURL URLWithString:photo.imageURL];
    [FlickrFetcher startFlickrFetch:url completion:^(NSData *jsonData) {
        if (jsonData)
        {
            UIImage *thumbnailImage = [UIImage imageWithData:jsonData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = thumbnailImage;
            });
        }
    }];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.context deleteObject:photo];
        NSError *error = nil;
        if (![_context save:&error]){
            NSLog (@"%@error", error);
        }
        if (self.debug){
            NSLog(@"DELETE SUCCESSFULL");
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[PhotoVC class]])
    {
        PhotoVC *imageVC = (PhotoVC *)segue.destinationViewController;
        imageVC.navigationItem.rightBarButtonItem.enabled = false;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        imageVC.photoURL = [NSURL URLWithString:photo.imageURL];
    }
}
@end
