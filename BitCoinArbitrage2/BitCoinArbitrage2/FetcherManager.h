//
//  FetcherManager.h
//  BidAndAsk
//
//  Created by LUCA ALIBERTI on 11/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangePriceJSONFetcher.h"
#import "ExchangePriceJSONFetcherDelegate.h"

#import "ExchangeFetcherManagerDelegate.h"
#import "Exchange.h"

@class ExchangePriceJSONFetcher;

@interface FetcherManager : NSObject<ExchangePriceJSONFetcherDelegate>

@property (strong, nonatomic) ExchangePriceJSONFetcher *priceFetcher;
@property (weak, nonatomic) id<ExchangeFetcherManagerDelegate> delegate;

- (void)fetchPricesForExchanges:(NSMutableDictionary*)exchanges;


@end
