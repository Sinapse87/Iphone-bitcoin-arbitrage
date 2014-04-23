//
//  JSONGroupExtractor.m
//  BidAndAsk
//
//  Created by LUCA ALIBERTI on 11/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "JSONPriceExtractor.h"
#import "Exchange.h"
#import "ExchangeConfiguration.h"


@implementation JSONPriceExtractor

+ (void)exctractPricesFromJSON:(NSData *)objectNotation forExchange:(NSString *)name AndStoreInExchanges:(NSMutableDictionary *)exchanges withError:(NSError *__autoreleasing *)error{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:error];
    [self populateExchanges:exchanges withExchange:name andExtractedPrices:parsedObject];
    if (localError != nil) {
        *error = localError;
        return;
    }
    return;
}


+(void) populateExchanges:(NSMutableDictionary *) exchanges withExchange:(NSString *) exchangeName andExtractedPrices:(NSDictionary *)parsedObject{
    Exchange *anExchange = [exchanges valueForKey:exchangeName];
    if ([exchangeName  isEqual: BTCE]){
        NSDictionary *internalDic = [[NSDictionary alloc]init];
        internalDic = [parsedObject valueForKey:@"ticker"];
        anExchange.bid = [[internalDic valueForKey:BTCEBID]doubleValue];
        anExchange.ask = [[internalDic valueForKey:BTCEASK]doubleValue];
        anExchange.last = [[internalDic valueForKey:BTCELASTPRICE]doubleValue];
    }else if ([exchangeName  isEqual: BITSTAMP]){
        anExchange.bid = [[parsedObject valueForKey:BITSTAMPBID]doubleValue];
        anExchange.ask = [[parsedObject valueForKey:BITSTAMPASK]doubleValue];
        anExchange.last = [[parsedObject valueForKey:BITSTAMPLASTPRICE]doubleValue];
    }else if ([exchangeName  isEqual: CBX]){
        anExchange.bid = [[parsedObject valueForKey:CBXLBID]doubleValue];
        anExchange.ask = [[parsedObject valueForKey:CBXASK]doubleValue];
        anExchange.last = [[parsedObject valueForKey:CBXLASTPRICE]doubleValue];
    }
    [exchanges setObject:anExchange forKey:exchangeName];
}


@end
