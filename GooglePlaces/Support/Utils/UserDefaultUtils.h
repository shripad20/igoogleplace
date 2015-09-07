//
//  UserDefaultUtils.h
//  VideoGiftCard
//
//  Created by Mobisoft on 11/8/12.
//


#import <Foundation/Foundation.h>

@interface UserDefaultUtils : NSObject


+ (void)saveBOOLValue:(BOOL)value forKey:(NSString*)key;

+ (BOOL)retriveBOOLValueFroKey:(NSString*)key;

+ (void)saveIntValue:(int)value forKey:(NSString*)key;

+ (int)retriveIntValueFroKey:(NSString*)key;

+ (void)saveObject:(id)obj forKey:(NSString*)key;

+ (id)retriveObjectForKey:(NSString*)key;

+ (void)saveDataObject:(id)obj forKey:(NSString *)key;

+ (id)retriveDataObjectForKey:(NSString*)key;

+ (void)removeSavedObjectForKey:(NSString*)key;

@end
