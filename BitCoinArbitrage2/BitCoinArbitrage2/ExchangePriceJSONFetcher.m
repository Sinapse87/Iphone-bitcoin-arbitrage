//
//  ExchangeFetcher.m
//  BidAndAsk
//
//  Created by LUCA ALIBERTI on 11/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "ExchangePriceJSONFetcher.h"

@protocol ExchangeJSONPriceFetcherDelegate;

@implementation ExchangePriceJSONFetcher

-(void) requestDataForExchanges:(NSMutableDictionary*) exchanges{

    NSArray *exchangesName = [exchanges allKeys];
    for (NSString* name in exchangesName){
        Exchange* anExchange = [exchanges valueForKey:name];
        NSURL *url = [[NSURL alloc] initWithString:anExchange.restURL];

        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (error) {
                [self.delegate fetchingExchangePriceFailedWithError:error];
            } else {
                [self.delegate receivedExchangeJSON:data forExchange:name toStoreIn:exchanges];
            }
        }];
    }
}
@end
