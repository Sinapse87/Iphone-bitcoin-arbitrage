//
//  JSONGroupExtractor.h
//  BidAndAsk
//
//  Created by LUCA ALIBERTI on 11/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exchange.h"

@interface JSONPriceExtractor : NSObject

+ (void)exctractPricesFromJSON:(NSData *)objectNotation forExchange:(NSString *)name AndStoreInExchanges:(NSMutableDictionary*) exchanges withError:(NSError **)error;

@end
