//
//  GTTCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "GTTCityAirQuality.h"
#import "GTTPollution.h"
#import "GTTWeather.h"

@implementation GTTCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(GTTWeather *)weather pollution:(GTTPollution *)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}

@end

@implementation GTTCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];

    NSDictionary *current = dictionary[@"current"];
    GTTWeather *weather = [[GTTWeather alloc] initWithDictionary:current[@"weather"]];
    GTTPollution *pollution = [[GTTPollution alloc] initWithDictionary:current[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
