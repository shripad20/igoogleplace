//
//  PhotoModel.h
//  GooglePlaces
//
//  Created by Shripad on 04/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject

@property (nonatomic, assign) long height;
@property (nonatomic, assign) long width;
@property (nonatomic, strong) NSString *photo_reference;

+(PhotoModel *)getPhotoModelFromDictionary:(NSDictionary *)dictionary;

@end
