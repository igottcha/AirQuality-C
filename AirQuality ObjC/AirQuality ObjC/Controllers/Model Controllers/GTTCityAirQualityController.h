//
//  GTTCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GTTCityAirQuality;

@interface GTTCityAirQualityController : NSObject

+(void)fetchSupportedCountries:(void(^)(NSArray *))completion;
+(void)fetchSupportedStatesInCountry:(NSString *)country completion: (void(^)(NSArray *))completion;
+(void)fetchSupportedCitiesInState:(NSString *)state country: (NSString *)country completion:(void(^)(NSArray *))completion;
+(void)fetchDataforCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void(^)(GTTCityAirQuality *))completion;

@end

NS_ASSUME_NONNULL_END
