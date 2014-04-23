//
//  ExchangeManager.h
//  BitCoinArbitrage2
//
//  Created by LUCA ALIBERTI on 20/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeConfiguration.h"
#import "Exchange.h"
#import "ExchangeConfiguration.h"

@interface ExchangeManager : NSObject

@property NSMutableDictionary *exchangesDic;
@property NSMutableArray *exchanges;
@property NSMutableArray *exchangesName;
@property NSMutableArray *exchangesRESTApiURL;

@end
