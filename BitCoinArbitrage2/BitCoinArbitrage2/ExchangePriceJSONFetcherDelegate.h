//
//  ExchangeFetcherDelegate.h
//  BidAndAsk
//
//  Created by LUCA ALIBERTI on 11/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ExchangePriceJSONFetcherDelegate
- (void)receivedExchangeJSON:(NSData *)objectNotation forExchange:(NSString*)name toStoreIn:(NSMutableDictionary*)exchanges;
- (void)fetchingExchangePriceFailedWithError:(NSError *)error;
@end

