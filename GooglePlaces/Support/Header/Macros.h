







#import "AppDelegate.h"
#import "RootViewController.h"
#ifndef iOSLibrary_Macros_h
#define iOSLibrary_Macros_h


#pragma mark - Convenience Constants



/**
 Easily access the Projects AppDelegate object from anywhere
 */
#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define ROOT_CONTROLLER APP_DELEGATE.rootViewController



#define HOME_CONTROLLER APP_DELEGATE.rootViewController.homeViewController

#define DEVICE_ORIENTATION  [UIDevice currentDevice].orientation

#define CURRENT_DEVICE_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define PTPX(pt) ([RootViewController pointsToPixels:pt])

#pragma mark - Logging

/**
 If defined this constant enables logging output for//DebugLog Macro
 */
#define PRINT_LOGS

/**
 Used to print debugging output
 */
#ifdef PRINT_LOGS
#   define DebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DebugLog(...)
#endif

/**
 Used to print normal logging output which you want always to be present while execution. This should be used very rarely.
 */
#define NormalLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#pragma mark - Convenience Constants





#pragma mark - Color Utils

/**
 Create UIColor Objects from RGB values where max value of each color compoenent  is 255.
 */
#define ColorWithRGB(r,g,b)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

/**
 Create UIColor Objects from RGBA values where max value of each color compoenent is 255.
 */
#define ColorWithRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f]





#pragma mark - Floating Point Comparision

/**
 Error tolerance for folating point comparision  
 */
#define EPSILON 1.0e-7


/**
 Compare two floating point numbers for equality.
 */
#define FltEquals(a, b) (fabs((a)-(b)) < EPSILON)


#pragma mark - Runtime iOS Version Checking

/**
 Check for if current iOS system version to equal to a particular version, can be used for conditional coding by detecting system version at the the runtime.
 */
#define SystemVersionEqualTo(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

/**
 Check for if current iOS system version to greater than a particular version, can be used for conditional coding by detecting system version at the the runtime.
 */
#define SystemVersionGreaterThan(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

/**
 Check for if current iOS system version to greater than or equal to a particular version, can be used for conditional coding by detecting system version at the the runtime.
 */
#define SystemVersionGreaterThanOrEqualTo(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

/**
 Check for if current iOS system version to less than a particular version, can be used for conditional coding by detecting system version at the the runtime.
 */
#define SystemVersionLessThan(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

/**
 Check for if current iOS system version to less than or equal to a particular version, can be used for conditional coding by detecting system version at the the runtime.
 */
#define SystemVersionLessThanOrEqualTo(v)   ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define DEGREES_TO_RADIANS(degrees) (degrees * M_PI / 180)

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#define MILES_TO_METERS(miles) (miles * 0.000621371192)

#define METERS_TO_MILES(meters) (meters * 1609.344)

#endif //ifndef iOSLibrary_Macros_h


#define IS_IPAD [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define MAIN_NAV_CONTROLLER APP_DELEGATE.rootViewController.mainNavigationController