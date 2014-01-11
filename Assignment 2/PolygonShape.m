//
//  PolygonShape.m
//  Calc
//
//  Created by comp41550 on 08/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "PolygonShape.h"

//
//  PolygonShape.m
//  HelloPoly
//
//  Created by CSI COMP41550 on 03/01/2012.
//  Copyright (c) 2012 UCD. All rights reserved.
//



@implementation PolygonShape

#define MAX_SIDES 12
static const int MIN_SIDES = 3;


- (id)init {
    return [self initWithNumberOfSides:5];
}

- (id)initWithNumberOfSides:(int)sides
{
    if (!(self = [super init]))
    {
        return nil;
    }
    self.numberOfSides = sides;
    return self;
}

- (void)setNumberOfSides:(int)numberOfSides
{
    if (numberOfSides > MAX_SIDES) {
        NSLog(@"Invalid number of sides: %d is greater than the maximum of %d allowed", numberOfSides, MAX_SIDES);
        return;
    }
    if(numberOfSides < MIN_SIDES) {
        NSLog(@"Invalid number of sides: %d is smaller than the minimum of %d allowed", numberOfSides, MIN_SIDES);
        return;
    }
    _numberOfSides = numberOfSides;
}

- (NSString *)name
{
    NSArray *names = @[@"Triangle",
                       @"Square",
                       @"Pentagon",
                       @"Hexagon",
                       @"Heptagon",
                       @"Octagon",
                       @"Nonagon",
                       @"Decagon",
                       @"Hendecagon",
                       @"Dodecagon"];
    
    return names[self.numberOfSides-MIN_SIDES];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Hello I am a %d-sided polygon (aka a %@).", self.numberOfSides, self.name];
}

@end