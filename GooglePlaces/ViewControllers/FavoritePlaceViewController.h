//
//  FavoritePlaceViewController.h
//  GooglePlaces
//
//  Created by Shripad on 06/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritePlaceViewController : UIViewController

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) NSString *selecetdType;
@property (nonatomic, strong) NSMutableArray *placeList;

@end
