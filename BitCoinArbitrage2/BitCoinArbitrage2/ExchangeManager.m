//
//  ExchangeManager.m
//  BitCoinArbitrage2
//
//  Created by LUCA ALIBERTI on 20/04/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "ExchangeManager.h"

@implementation ExchangeManager

-(ExchangeManager*) init{
    
    if (!(self = [super init]))
        return nil;
    [self initExchangesData];
    return self;
    
}

-(void)initExchangesData{
    [self initExchangesName];
    [self initExchangeRestApiURL];
    [self initExchangesDetails];
    self.exchangesDic = [[NSMutableDictionary alloc] initWithObjects:self.exchanges forKeys:self.exchangesName];
}

-(void)initExchangesName{
    self.exchangesName = [[NSMutableArray alloc] initWithObjects:BITSTAMP,BTCE,CBX, nil];
}

-(void) initExchangeRestApiURL {
    self.exchangesRESTApiURL = [[NSMutableArray alloc] initWithObjects:BITSTAMPRESTAPI,BTCERESTAPI,CAMPBXRESTAPI, nil];
}

-(void)initExchangesDetails{
    self.exchanges = [[NSMutableArray alloc] init];
    Exchange *exchange;
    for (int i=0; i<self.exchangesName.count;i++){
        exchange = [[Exchange alloc] init];
        exchange.name=self.exchangesName[i];
        exchange.restURL=self.exchangesRESTApiURL[i];
        [self.exchanges addObject:exchange];
        
    }
}

@end
