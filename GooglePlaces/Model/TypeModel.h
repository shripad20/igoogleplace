//
//  typeModel.h
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeModel : NSObject

@property (nonatomic, strong) NSString *restaurant;
@property (nonatomic, strong) NSString *food;
@property (nonatomic, strong) NSString *point_of_interest;
@property (nonatomic, strong) NSString *establishment;

+(TypeModel *)getTypeModelFromDictionary:(NSDictionary *)dictionary;


@end
