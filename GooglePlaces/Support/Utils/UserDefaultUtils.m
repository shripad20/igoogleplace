//
//  UserDefaultUtils.m
//  VideoGiftCard
//
//  Created by Mobisoft on 11/8/12.
//
//

#import "UserDefaultUtils.h"

@implementation UserDefaultUtils

+ (void)saveBOOLValue:(BOOL)value forKey:(NSString*)key {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:value] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (BOOL)retriveBOOLValueFroKey:(NSString*)key {
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
    
}

+ (void)saveIntValue:(int)value forKey:(NSString*)key {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:value] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (int)retriveIntValueFroKey:(NSString*)key {
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] intValue];
    
}


+ (void)saveObject:(id)obj forKey:(NSString*)key {
    
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)retriveObjectForKey:(NSString*)key {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}

+ (void)saveDataObject:(id)obj forKey:(NSString *)key {
 
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:obj] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)retriveDataObjectForKey:(NSString*)key {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([data length] > 0) {
        
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
    
    
}


+ (void)removeSavedObjectForKey:(NSString*)key {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
