//
//  AFCollectionViewFlowLargeLayout.h
//  UICollectionViewFlowLayoutExample
//
//  Created by Ash Furrow on 2013-02-05.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFCollectionViewFlowLargeLayout : UICollectionViewFlowLayout

@property (nonatomic) CGFloat screenPhoneWidth;
@property (nonatomic) CGFloat screenPhoneHeight;

-(id)initWithNumberOfItems:(NSInteger) numberOfItems;

@end
