//
//  PlacesViewController.h
//  GooglePlaces
//
//  Created by Shripad on 03/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesViewController : UIViewController

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) NSString *selecetdType;
@property (nonatomic, strong) NSString *rangeInMeter;

@end
