//
//  LocationModel.m
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

-(NSDictionary *)jsonMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"lat",@"lat",
            @"lng",@"lng",
            
            nil];
}

+(LocationModel *)getLocationModelFromDictionary:(NSDictionary *)dictionary {
    
    LocationModel *locationModel = [[LocationModel alloc] init];
    NSDictionary *mapping = [locationModel jsonMapping];
    for (NSString *attribute in [mapping allKeys]){
        NSString *classProperty = [mapping objectForKey:attribute];
        NSString *attributeValue = [dictionary objectForKey:attribute];
        
        if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
            [locationModel setValue:attributeValue forKeyPath:classProperty];
        }
    }
    
    return locationModel;
}

@end
