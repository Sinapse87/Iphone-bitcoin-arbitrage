//
//  MainScreenViewController.h
//  BitCoinArbitrage2
//
//  Created by LUCA ALIBERTI on 08/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFCollectionViewFlowLargeLayout.h"
#import "AFCollectionViewFlowSmallLayout.h"
#import "CollectionViewCell.h"
#import "FetcherManager.h"
#import "ExchangeManager.h"

@interface MainScreenViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ExchangeFetcherManagerDelegate>

@property (strong,nonatomic) ExchangeManager *exchangeManager;


@property (strong, nonatomic) FetcherManager *fetcherManager;
@property int exchangeFetched;

@property NSTimeInterval updateDelay;
@property (strong,nonatomic) NSArray* delayList;
@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) UISegmentedControl* segmentedControl;

@end
