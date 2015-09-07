//
//  RootViewController.m
//  GooglePlaces
//
//  Created by Shripad on 03/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "RootViewController.h"
#import "CommonFilesImport.h"
#import <CoreLocation/CoreLocation.h>
#import "FavoriteRepository.h"
#import "UserDefaultUtils.h"

@interface RootViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation RootViewController

#pragma mark - View Life Cycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self startLocationTracking];
    [self showHomeView];
    
    if (![UserDefaultUtils retriveBOOLValueFroKey:IS_FAV_TABLE_CREATED]) {
        
        [self createFavoriteTable];
    }
    
    
}


#pragma mark - Private Methods -

- (void)createFavoriteTable {
    
    FavoriteRepository *favRepository = [[FavoriteRepository alloc]init];
    BOOL status = [favRepository createFavoriteTable];
    
    if (status) {
        
        DebugLog(@"Favorite Brand table created.");
        [UserDefaultUtils saveBOOLValue:YES forKey:IS_FAV_TABLE_CREATED];
    }else {
        
        [UserDefaultUtils saveBOOLValue:NO forKey:IS_FAV_TABLE_CREATED];
    }
}


- (void)startLocationTracking {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    
}

- (void)showHomeView {
    
    self.homeViewController = [[HomeViewController alloc]init];
    self.mainNavController = [[UINavigationController alloc]initWithRootViewController:self.homeViewController];
    [self.view addSubview:self.mainNavController.view];
}

+(float)pointsToPixels:(float)points {
    
    float baseWidth = 320;
    float screenWidth = SCREEN_MIN_LENGTH;
    
    return (points * screenWidth) / baseWidth;
}




#pragma mark - CLLocationManagerDelegate Method -

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    DebugLog(@"lat: %f, long: %f, accuracy: %f", newLocation.coordinate.latitude,
             newLocation.coordinate.longitude, newLocation.horizontalAccuracy);
    
    
    if (FltEquals(newLocation.coordinate.latitude, 0)
        &&
        FltEquals(newLocation.coordinate.longitude, 0)) {
        return;
    }
    
    if ((newLocation.horizontalAccuracy > 0) && (newLocation.horizontalAccuracy < 1000)) {
        
        
        if (newLocation.horizontalAccuracy < 50) {
         
            self.latitude = newLocation.coordinate.latitude;
            self.longitude = newLocation.coordinate.longitude;
            
            [self.locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    
}


@end
