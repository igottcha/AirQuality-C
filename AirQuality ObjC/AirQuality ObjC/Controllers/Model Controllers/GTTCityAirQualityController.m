//
//  GTTCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "GTTCityAirQualityController.h"
#import "GTTCityAirQuality.h"

static NSString *const baseURLString = @"https://api.airvisual.com/";
static NSString *const versonComponent = @"v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponent = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";
static NSString *const apiKey = @"be597a5a-bfb7-412d-8b98-033a96e0e2cf";

@implementation GTTCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *countriesURL = [[baseURL URLByAppendingPathComponent:versonComponent] URLByAppendingPathComponent:countryComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:countriesURL resolvingAgainstBaseURL:true];
    NSURLQueryItem * key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[key];
    NSURL *finalURl = components.URL;
    NSLog(@"%@", finalURl);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray<NSDictionary *> *secondLevelJSON = topLevelJSON[@"data"];
        NSMutableArray *countries = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in secondLevelJSON)
        {
            NSString *country = currentDictionary[@"country"];
            [countries addObject:country];
        }
        completion(countries);
        
    }] resume];
    
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *statesURL = [[baseURL URLByAppendingPathComponent:versonComponent] URLByAppendingPathComponent:stateComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:statesURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *countryQuery = [NSURLQueryItem queryItemWithName:@"country" value:country];
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[countryQuery, key];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray<NSDictionary *> *secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray *states = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in secondLevelJSON)
        {
            NSString *state = currentDictionary[@"state"];
            [states addObject:state];
        }
        completion(states);
        
    }] resume];
    
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *citiesURL = [[baseURL URLByAppendingPathComponent:versonComponent] URLByAppendingPathComponent:cityComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:citiesURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *stateQuery = [NSURLQueryItem queryItemWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [NSURLQueryItem queryItemWithName:@"country" value:country];
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[stateQuery, countryQuery, key];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray<NSDictionary *> *secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray *states = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in secondLevelJSON)
        {
            NSString *state = currentDictionary[@"state"];
            [states addObject:state];
        }
        completion(states);
        
    }] resume];
}

+ (void)fetchDataforCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(GTTCityAirQuality * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *cityURL = [[baseURL URLByAppendingPathComponent:versonComponent] URLByAppendingPathComponent:cityDetailsComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:cityURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *cityQuery = [NSURLQueryItem queryItemWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [NSURLQueryItem queryItemWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [NSURLQueryItem queryItemWithName:@"country" value:country];
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[cityQuery, stateQuery, countryQuery, key];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *dataDictionary = topLevelJSON[@"data"];
        
        GTTCityAirQuality * cityAQI = [[GTTCityAirQuality alloc] initWithDictionary:dataDictionary];
        completion(cityAQI);
        
    }] resume];
}

@end
