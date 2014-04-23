//
//  MainScreenDataCell.m
//  BitcoinArbitrage
//
//  Created by LUCA ALIBERTI on 02/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "CollectionViewCell.h"

#define IMAGEVIEW_BORDER_LENGHT 5

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}


#pragma mark - LABEL SETUP
-(void) setupExchangeLabels{
    [self removeSubviews];
    
    [self setCollectionCellLabel];
    
    [self setCollectionCellImageWithName:@"bitcoinLogo.jpeg" andAlpha:0.4f andBackGroundColor:[[UIColor orangeColor]colorWithAlphaComponent:0.4f] shouldFill:NO];
    
    
}

-(void) setupPriceLabels{
    
    [self removeSubviews];
    
    [self initLabelFrame];
    
    [self setupLabelsAttributes];
    
    [self setCollectionCellImageWithName:@"bitcoin-graph.png" andAlpha:0.4f andBackGroundColor:[UIColor yellowColor] shouldFill:YES];
    
}

-(void) initLabelFrame{
    

    NSInteger cellWidht = self.bounds.size.width;
    NSInteger cellHeight = self.bounds.size.height;
    NSInteger nextCellHeightOffset = 0;
    self.percentageDifferenceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0, cellWidht, (cellHeight / 4) + 10 )];
    nextCellHeightOffset += (cellHeight / 4) + 9 ;
    self.absoluteDifferenceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,nextCellHeightOffset, cellWidht, (cellHeight / 4) + 6 )];
    nextCellHeightOffset +=  (cellHeight / 4) + 5;
    self.bidLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,nextCellHeightOffset, cellWidht, (cellHeight / 4) - 5)];
    nextCellHeightOffset += (cellHeight / 4) - 6;
    self.askLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, nextCellHeightOffset, cellWidht, (cellHeight / 4) - 5 )];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:( UIRectCornerAllCorners) cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame=self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

-(void) setupLabelsAttributes {
    self.percentageDifferenceLabel.adjustsFontSizeToFitWidth = YES;
    self.absoluteDifferenceLabel.adjustsFontSizeToFitWidth = YES;
    self.bidLabel.adjustsFontSizeToFitWidth = YES;
    self.askLabel.adjustsFontSizeToFitWidth = YES;
    
    self.bidLabel.textColor = [UIColor blueColor];
    self.percentageDifferenceLabel.textColor = [UIColor blueColor];
    self.absoluteDifferenceLabel.textColor = [UIColor blueColor];
    self.askLabel.textColor = [UIColor blueColor];
    
    self.percentageDifferenceLabel.backgroundColor = [UIColor clearColor];
    self.absoluteDifferenceLabel.backgroundColor = [UIColor clearColor];
    
    
    self.percentageDifferenceLabel.textAlignment = NSTextAlignmentCenter;
    self.absoluteDifferenceLabel.textAlignment = NSTextAlignmentCenter;
    self.bidLabel.textAlignment = NSTextAlignmentCenter;
    self.askLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.percentageDifferenceLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:14];
    self.absoluteDifferenceLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:14];
    self.bidLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:10];
    self.askLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:10];
    
    
    self.percentageDifferenceLabel.layer.borderColor=[[UIColor blueColor]CGColor];
    self.percentageDifferenceLabel.layer.borderWidth=1;
    self.absoluteDifferenceLabel.layer.borderColor=[[UIColor blueColor]CGColor];
    self.absoluteDifferenceLabel.layer.borderWidth=1;
    
    self.bidLabel.layer.borderColor=[[UIColor blueColor]CGColor];
    self.bidLabel.layer.borderWidth=1;
    self.askLabel.layer.borderColor=[[UIColor blueColor]CGColor];
    self.askLabel.layer.borderWidth=1;
}



-(void) setCollectionCellLabel{
    
    self.contentView.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:0.4f];
    self.exchangeNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
    self.exchangeNameLabel.adjustsFontSizeToFitWidth = YES;
    self.exchangeNameLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:20];
    self.exchangeNameLabel.textAlignment = NSTextAlignmentCenter;
}


#pragma mark - collectionCell setup

-(void) setCollectionCellImageWithName:(NSString *)name andAlpha:(float) alpha andBackGroundColor: (UIColor *) backgroundColor shouldFill:(BOOL) aspect{
    UIImage * bitCoinLogo = [UIImage imageNamed: name];
    UIImageView *imgVW=[[UIImageView alloc] initWithImage:bitCoinLogo];
    if (aspect)
        imgVW.contentMode = UIViewContentModeScaleAspectFill;
    else
        imgVW.contentMode = UIViewContentModeScaleAspectFit;
    [imgVW setAlpha:alpha];
    [imgVW setOpaque:NO];
    [imgVW setFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
    self.contentView.backgroundColor = backgroundColor;
    [self.contentView addSubview:imgVW];
}

-(void) removeSubviews{
    if ([self.contentView subviews]){
        for (UIView *subview in [self.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
