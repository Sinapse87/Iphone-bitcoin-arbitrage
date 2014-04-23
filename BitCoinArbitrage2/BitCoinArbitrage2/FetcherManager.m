//
//  FetcherManager.m
//  BidAndAsk
//
//  Created by LUCA ALIBERTI on 11/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "FetcherManager.h"


#import "JSONPriceExtractor.h"
#import "ExchangePriceJSONFetcher.h"
#import "Exchange.h"

@implementation FetcherManager


- (void)fetchPricesForExchanges:(NSMutableDictionary *)exchanges
{
    [self.priceFetcher requestDataForExchanges:exchanges];
}

#pragma mark - ExchangePriceJSONFetcherDelegate

- (void)receivedExchangeJSON:(NSData *)objectNotation forExchange:(NSString *)name toStoreIn:(NSMutableDictionary *)exchanges
{
    NSError *error = nil;
    [JSONPriceExtractor exctractPricesFromJSON:objectNotation forExchange:name AndStoreInExchanges: exchanges withError:&error];
    if (error != nil) {
        [self.delegate fetchingPricesFailedWithError:error];
        
    } else {
        [self.delegate didReceivedAndStoredAnExchange];
        
    }
}

- (void)fetchingExchangePriceFailedWithError:(NSError *)error
{
    [self.delegate fetchingPricesFailedWithError:error];
}

@end
