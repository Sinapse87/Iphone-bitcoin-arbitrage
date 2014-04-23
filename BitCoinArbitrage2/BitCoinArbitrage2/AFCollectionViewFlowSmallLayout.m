//
//  AFCollectionViewFlowSmallLayout.m
//  UICollectionViewFlowLayoutExample
//
//  Created by Ash Furrow on 2013-02-05.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewFlowSmallLayout.h"

@implementation AFCollectionViewFlowSmallLayout

// IPHONE 3.5 SCREEN 320 - 480
//IPHONE 4.0 SCREEN 320 - 568

-(id)initWithNumberOfItems:(NSInteger) numberOfItems
{
    if (!(self = [super init]))
        return nil;
    
    self.screenPhoneWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenPhoneHeight = [UIScreen mainScreen].bounds.size.height - 64;
    
    self.minimumInteritemSpacing = 1.0f;
    self.minimumLineSpacing = 1.0f;
    
    CGFloat itemWidht = (float)((int)self.screenPhoneWidth / ((int)numberOfItems +1))-self.minimumInteritemSpacing;
    CGFloat itemHeight = (float)((int)self.screenPhoneHeight / ((int)numberOfItems +1));
    self.itemSize = CGSizeMake(itemWidht, itemHeight);
    //self.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    return self;
}

-(CGSize)collectionViewContentSize{
    
    return CGSizeMake(self.screenPhoneWidth, self.screenPhoneHeight);
}

@end
