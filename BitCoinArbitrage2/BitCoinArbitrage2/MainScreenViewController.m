//
//  MainScreenViewController.m
//  BitCoinArbitrage2
//
//  Created by LUCA ALIBERTI on 08/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "MainScreenViewController.h"




@interface MainScreenViewController ()

@property (nonatomic, strong) AFCollectionViewFlowLargeLayout *largeLayout;
@property (nonatomic, strong) AFCollectionViewFlowSmallLayout *smallLayout;

@end

static NSString *ItemIdentifier = @"PriceCollectionCell";
static NSString *ItemIdentifier2 = @"ExchangeCollectionCell";

@implementation MainScreenViewController

#pragma mark - Load methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.exchangeManager = [[ExchangeManager alloc]init];
    
    [self initSegmentedControl];
    
    [self initFetcherManager];
    
    [self initFlowLayout];
    
    [self initCollectionView];
    
    [self periodicExchangesFetch];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.updateDelay target:self selector:@selector(periodicExchangesFetch) userInfo:nil repeats:YES];
}

#pragma mark - Collection view delegate method

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration{
    
    if (UIDeviceOrientationIsPortrait(toInterfaceOrientation)) {
        [self.collectionView setCollectionViewLayout:self.smallLayout];
    } else {
        [self.collectionView setCollectionViewLayout:self.largeLayout];
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
#pragma mark - User Interface Methods

-(void)segmentedControlValueDidChange:(id)sender
{
    self.updateDelay = [[self.delayList objectAtIndex:(self.segmentedControl.selectedSegmentIndex)] doubleValue];
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.updateDelay target:self selector:@selector(periodicExchangesFetch) userInfo:nil repeats:YES];
}


#pragma mark - fetching

-(void)periodicExchangesFetch{
    [self.fetcherManager fetchPricesForExchanges:self.exchangeManager.exchangesDic];
}


#pragma mark - ExchangeFetcherManagerDelegate methods

- (void)fetchingPricesFailedWithError:(NSError *)error;
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void) didReceivedAndStoredAnExchange{
    self.exchangeFetched++;
    if (self.exchangeFetched == [self.exchangeManager.exchangesName count]){
        self.exchangeFetched=0;
        [self didReceivedAndStoredExchangesPrices];
    }
}

- (void)didReceivedAndStoredExchangesPrices{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.exchangeManager.exchangesName count] + 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.exchangeManager.exchangesName count] + 1;
    
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell* collectionCell;
    
    if (indexPath.row == 0 || indexPath.section == 0){
        collectionCell =[collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier2
                                                                  forIndexPath:indexPath];
        [collectionCell setupExchangeLabels];
        [self customizeExchangeCollectionCell:collectionCell At:indexPath];
    }
    else{
        collectionCell =[collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier
                                                                  forIndexPath:indexPath];
        [collectionCell setupPriceLabels];
        [self customizePriceCollectionCell:collectionCell At:indexPath];
    }
    
    return collectionCell;
}


#pragma mark - Utility methods to populate the collection view

-(void) customizeExchangeCollectionCell:(CollectionViewCell*)collectionCell At:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0 && indexPath.section == 0)
        collectionCell.exchangeNameLabel.text = (@"EXCHANGE");
    else
    {
        if (indexPath.row == 0)
            collectionCell.exchangeNameLabel.text = self.exchangeManager.exchangesName[indexPath.section-1];
        else
            collectionCell.exchangeNameLabel.text = self.exchangeManager.exchangesName[indexPath.row-1];
    }
    
    
    [collectionCell.contentView addSubview:collectionCell.exchangeNameLabel];
}


-(void) customizePriceCollectionCell:(CollectionViewCell*)collectionCell At:(NSIndexPath *)indexPath{
    
    [self populatePriceCell:collectionCell LabelsAt:indexPath];
    [self addLabelsToPriceCell:collectionCell];
}

-(void) populatePriceCell: (CollectionViewCell*) collectionCell LabelsAt:(NSIndexPath *)indexPath{
    [self populateDoubleExchangeCell:collectionCell At:indexPath];
}

- (double)extractPriceFrom:(Exchange *)homeExchange andAwayExchange:(Exchange *)awayExchange forCell:(CollectionViewCell *)collectionCell {
    double absDiff =awayExchange.bid-homeExchange.ask;
    double perDiff = (absDiff) / homeExchange.ask * 100;
    NSString * bidPrice = [NSString stringWithFormat:@"Bid %.5g", awayExchange.bid];
    NSString * askPrice = [NSString stringWithFormat:@"Ask %.5g", homeExchange.ask];
    NSString * absDifference = [NSString stringWithFormat:@"| %g |", absDiff];
    NSString * perDifference = [NSString stringWithFormat:@"% .3g %%", perDiff];
    
    
    collectionCell.bidLabel.text = bidPrice;
    collectionCell.percentageDifferenceLabel.text = perDifference;
    collectionCell.absoluteDifferenceLabel.text = absDifference;
    collectionCell.askLabel.text = askPrice;
    return perDiff;
}

- (void)animateCell:(CollectionViewCell *)collectionCell {
    UIColor *previousColor = collectionCell.contentView.backgroundColor;
    collectionCell.percentageDifferenceLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
    collectionCell.absoluteDifferenceLabel.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5f];
    
    [UIView animateWithDuration:self.updateDelay - 1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         //NSLog(@"animation start");
                         [collectionCell.contentView setBackgroundColor:[UIColor colorWithRed: 100.0/255.0 green: 100.0/255.0 blue:100.0/255.0 alpha: 1.0]];
                     }
                     completion:^(BOOL finished){
                         //NSLog(@"animation end");
                         [collectionCell.contentView setBackgroundColor:[UIColor clearColor]];
                         collectionCell.contentView.backgroundColor = previousColor;
                         
                     }
     ];
}

- (void)animateLabelsForCell:(CollectionViewCell *)collectionCell {
    collectionCell.percentageDifferenceLabel.alpha = 0.3;
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        collectionCell.percentageDifferenceLabel.alpha = 1;
    } completion:nil];
}

-(void) populateDoubleExchangeCell:(CollectionViewCell *)collectionCell At:(NSIndexPath *) indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        [collectionCell.percentageDifferenceLabel.layer removeAllAnimations];
        
        NSString* exchangeHomeName = self.exchangeManager.exchangesName[indexPath.section-1];
        NSString* exchangeAwayName = self.exchangeManager.exchangesName[indexPath.row-1];
        Exchange *homeExchange = [self.exchangeManager.exchangesDic valueForKey:exchangeHomeName];
        Exchange *awayExchange = [self.exchangeManager.exchangesDic valueForKey:exchangeAwayName];
        
        double perDiff = [self extractPriceFrom:homeExchange andAwayExchange:awayExchange forCell:collectionCell];
        
        if (perDiff > 0){
            [self animateCell:collectionCell];
            if (perDiff > 1){
                [self animateLabelsForCell:collectionCell];
            }
        }
    });
}


-(void) addLabelsToPriceCell: (CollectionViewCell*) collectionCell {
    [collectionCell.contentView addSubview:collectionCell.percentageDifferenceLabel];
    [collectionCell.contentView addSubview:collectionCell.absoluteDifferenceLabel];
    [collectionCell.contentView addSubview:collectionCell.bidLabel];
    [collectionCell.contentView addSubview:collectionCell.askLabel];
}



#pragma mark - Segmented control setup

-(void) initSegmentedControl {
    [self initDelayList];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.delayList];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    [self.segmentedControl titleForSegmentAtIndex:[self.segmentedControl selectedSegmentIndex]];
    self.updateDelay = [[self.delayList objectAtIndex:(self.segmentedControl.selectedSegmentIndex)] doubleValue];
}

-(void) initDelayList{
    self.delayList = [[NSArray alloc] initWithObjects:@"10",@"20",@"50",@"100",@"300", nil];
}


#pragma mark - Fetcher manager setup

-(void) initFetcherManager {
    self.fetcherManager = [[FetcherManager alloc]init];
    self.fetcherManager.priceFetcher = [[ExchangePriceJSONFetcher alloc]init];
    self.fetcherManager.priceFetcher.delegate = self.fetcherManager;
    self.fetcherManager.delegate = self;
    self.exchangeFetched=0;
}

#pragma mark - Collection view setup

-(void) initFlowLayout{
    self.smallLayout = [[AFCollectionViewFlowSmallLayout alloc] initWithNumberOfItems:self.exchangeManager.exchangesName.count];
    self.largeLayout = [[AFCollectionViewFlowLargeLayout alloc] initWithNumberOfItems:self.exchangeManager.exchangesName.count];
}

-(void) initCollectionView{
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.smallLayout];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:ItemIdentifier];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:ItemIdentifier2];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


#pragma mark - default delegate methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
