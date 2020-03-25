//
//  GTTCityAirQuality.h
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GTTWeather;
@class GTTPollution;

@interface GTTCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) GTTWeather *weather;
@property (nonatomic, copy, readonly) GTTPollution *pollution;

-(instancetype) initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(GTTWeather *)weather pollution:(GTTPollution *)pollution;

@end

@interface GTTCityAirQuality (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
