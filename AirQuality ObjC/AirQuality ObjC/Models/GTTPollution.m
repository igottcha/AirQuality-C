//
//  GTTPollution.m
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "GTTPollution.h"

@implementation GTTPollution

- (instancetype)initWithAQI:(NSInteger)airQualityIndex
{
    self = [super init];
    if (self)
    {
        _airQualityIndex = airQualityIndex;
    }
    
    return self;
}

@end

@implementation GTTPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] integerValue];
    
    return [self initWithAQI:aqi];
}

@end

