//
//  GTTPollution.h
//  AirQuality ObjC
//
//  Created by Chris Gottfredson on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTTPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype) initWithAQI:(NSInteger)airQualityIndex;

@end

@interface GTTPollution (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
