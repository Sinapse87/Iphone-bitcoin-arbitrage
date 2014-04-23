//
//  MainScreenDataCell.h
//  BitcoinArbitrage
//
//  Created by LUCA ALIBERTI on 02/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UILabel *absoluteDifferenceLabel;

@property (nonatomic, retain) IBOutlet UILabel *percentageDifferenceLabel;

@property (nonatomic, retain) IBOutlet UILabel *bidLabel;

@property (nonatomic, retain) IBOutlet UILabel *askLabel;

@property (nonatomic, retain) IBOutlet UILabel *exchangeNameLabel;

-(void) setupPriceLabels;

-(void) setupExchangeLabels;


@end
