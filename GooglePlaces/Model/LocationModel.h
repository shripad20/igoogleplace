//
//  LocationModel.h
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;

+(LocationModel *)getLocationModelFromDictionary:(NSDictionary *)dictionary;

@end
