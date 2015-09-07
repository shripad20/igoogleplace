//
//  RootViewController.h
//  GooglePlaces
//
//  Created by Shripad on 03/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface RootViewController : UIViewController

@property (nonatomic, strong) UINavigationController *mainNavController;
@property (nonatomic, strong) HomeViewController *homeViewController;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;


+(float)pointsToPixels:(float)points;

@end
