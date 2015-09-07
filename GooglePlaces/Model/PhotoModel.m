//
//  PhotoModel.m
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

-(NSDictionary *)jsonMapping {
    
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"photo_reference",@"photo_reference",
            @"width",@"width",
            @"height",@"height",
            
            nil];
}

+(PhotoModel *)getPhotoModelFromDictionary:(NSDictionary *)dictionary {
    
    PhotoModel *photoModel = [[PhotoModel alloc] init];
    NSDictionary *mapping = [photoModel jsonMapping];
    for (NSString *attribute in [mapping allKeys]){
        NSString *classProperty = [mapping objectForKey:attribute];
        NSString *attributeValue = [dictionary objectForKey:attribute];
        
        if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
            [photoModel setValue:attributeValue forKeyPath:classProperty];
        }
    }
    
    return photoModel;
}


@end
