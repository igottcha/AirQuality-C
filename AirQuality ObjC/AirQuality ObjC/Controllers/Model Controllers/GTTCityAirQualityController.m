//
//  GTTCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "GTTCityAirQualityController.h"
#import "GTTCityAirQuality.h"

static NSString const * baseURLString = @"https://api.airvisual.com/";
static NSString const * versonComponent = @"v2";
static NSString const * countryComponent = @"countries";
static NSString const * stateComponent = @"states";
static NSString const * cityComponent = @"cities";
static NSString const * cityDetailsComponent = @"city";
static NSString const * apiKey = @"be597a5a-bfb7-412d-8b98-033a96e0e2cf";

@implementation GTTCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versonComponent];
    NSURL *countryListURL = [versionURL URLByAppendingPathComponent:countryComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:countryListURL resolvingAgainstBaseURL:true];
    NSURLQueryItem * key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[apiKey];
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


@end
