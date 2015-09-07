//
//  typeModel.m
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "TypeModel.h"

@implementation TypeModel


-(NSDictionary *)jsonMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"restaurant",@"restaurant",
            @"food",@"food",
            @"point_of_interest",@"point_of_interest",
            @"establishment",@"establishment",
            
            nil];
}

+(TypeModel *)getTypeModelFromDictionary:(NSDictionary *)dictionary {
    
    TypeModel *typeModel = [[TypeModel alloc] init];
    NSDictionary *mapping = [typeModel jsonMapping];
    for (NSString *attribute in [mapping allKeys]){
        NSString *classProperty = [mapping objectForKey:attribute];
        NSString *attributeValue = [dictionary objectForKey:attribute];
        
        if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
            [typeModel setValue:attributeValue forKeyPath:classProperty];
        }
    }
    
    return typeModel;
}

@end
