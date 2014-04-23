//
//  Exchange.h
//  BitcoinArbitrage
//
//  Created by LUCA ALIBERTI on 05/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exchange : NSObject

@property NSString *name;
@property NSString *apiKey;
@property NSString *restURL;
@property double bid;
@property double ask;
@property double last;

@end
