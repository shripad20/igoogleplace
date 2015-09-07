
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"


@interface AbstractRepository : NSObject {
	FMDatabase *db;
}

+(NSString *)databaseFilename;
-(int) lastInsertRowId;
+(NSString *) databasePath;

@end
