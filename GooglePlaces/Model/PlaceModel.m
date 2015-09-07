//
//  PlaceModel.m
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "PlaceModel.h"
#import "FavoriteRepository.h"

@implementation PlaceModel

-(NSDictionary *)jsonMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"icon",@"icon",
            @"place_id",@"place_id",
            @"name",@"name",
            @"open_now",@"open_now",
            @"rating",@"rating",
            @"reference",@"reference",
            @"scope",@"scope",
            @"types",@"types",
            @"vicinity",@"vicinity",
            @"location",@"location",
            @"photos",@"photos",
            
            nil];
}

+(PlaceModel *)getPlaceModelFromDictionary:(NSDictionary *)dictionary {
    
    PlaceModel *placeModel = [[PlaceModel alloc] init];
    NSDictionary *mapping = [placeModel jsonMapping];
    for (NSString *attribute in [mapping allKeys]){
        NSString *classProperty = [mapping objectForKey:attribute];
        NSString *attributeValue = [dictionary objectForKey:attribute];
        
        
        if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
            
            NSLog(@"attribute: %@", attribute);
            
            if ([attribute isEqualToString:@"photos"]) {
                    
                if ([[dictionary objectForKey:attribute] count] != 0) {
                    
                    NSDictionary *dict = [[dictionary objectForKey:attribute] objectAtIndex:0];
                    placeModel.photos = [PhotoModel getPhotoModelFromDictionary:dict];

                }
                
            }else if([attribute isEqualToString:@"types"]) {
                
                placeModel.types = [dictionary objectForKey:attribute];
            } else {
            
                [placeModel setValue:attributeValue forKeyPath:classProperty];
            }
        }
    }
        
    placeModel.location = [LocationModel getLocationModelFromDictionary:[[dictionary objectForKey:@"geometry"] valueForKey:@"location"]];
    
    NSString *attributeValue = [[dictionary objectForKey:@"opening_hours"] valueForKey:@"open_now"];
    [placeModel setValue:attributeValue forKeyPath:@"open_now"];
    
    return placeModel;
}

+ (BOOL)checkIfPlacefavorite:(NSString *)place_id{
    
    FavoriteRepository *favoriteRepository = [[FavoriteRepository alloc] init];
    return [favoriteRepository checkIfFavoritePlace:place_id];
}

+ (BOOL)removePlaceFromFavorite:(NSString *)place_id {
    
    FavoriteRepository *favoriteRepository = [[FavoriteRepository alloc] init];
    return [favoriteRepository removePlaceFromFavorite:place_id];
    
    return YES;
}

+ (BOOL)insertPlaceAsFavorite:(NSString *)place_id {
    
    FavoriteRepository *favoriteRepository = [[FavoriteRepository alloc] init];
    return [favoriteRepository insertFavoritePlace:place_id];
}

@end
