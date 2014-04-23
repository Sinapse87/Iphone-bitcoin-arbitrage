//
//  ExchangeFetcher.h
//  BidAndAsk
//
//  Created by LUCA ALIBERTI on 11/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Exchange.h"
#import "ExchangePriceJSONFetcherDelegate.h"


@protocol ExchangeFetcherDelegate;


@interface ExchangePriceJSONFetcher : NSObject

@property (weak, nonatomic) id<ExchangePriceJSONFetcherDelegate> delegate;

-(void) requestDataForExchanges:(NSMutableDictionary*) exchanges;

@end
