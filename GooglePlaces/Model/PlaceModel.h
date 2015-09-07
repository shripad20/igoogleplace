//
//  PlaceModel.h
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"
#import "PhotoModel.h"
#import "TypeModel.h"

@interface PlaceModel : NSObject

@property (nonatomic, strong) LocationModel *location;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *place_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *open_now;
@property (nonatomic, strong) PhotoModel *photos;
@property (nonatomic, assign) double rating;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSString *vicinity;


+(PlaceModel *)getPlaceModelFromDictionary:(NSDictionary *)dictionary;

+ (BOOL)checkIfPlacefavorite:(NSString *)place_id;

+ (BOOL)removePlaceFromFavorite:(NSString *)place_id;

+ (BOOL)insertPlaceAsFavorite:(NSString *)place_id;

@end
