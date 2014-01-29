//
//  PolygonShape.h
//  Calc
//
//  Created by comp41550 on 08/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PolygonShape : NSObject

@property (nonatomic) int numberOfSides;
@property (readonly, weak) NSString *shapeName;
- (NSArray *)pointsInRect:(CGRect)rect;
- (id)initWithNumberOfSides:(int)sides;

@end
