

#import "AbstractRepository.h"
#import "FMDatabaseAdditions.h"
#import "Macros.h"
#import "Constants.h"

@implementation AbstractRepository

+(NSString *) databaseFilename {
    
        return @"GooglePlace.sqlite";
}

+(NSString *) databasePath {
	NSString *filename = [AbstractRepository databaseFilename];

	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString * dbfilePath = [documentsDirectory stringByAppendingPathComponent:filename];
	
	return dbfilePath;
}

-(id)init {
	if (self = [super init]) {
		NSString *dbPath = [AbstractRepository databasePath];
		db = [FMDatabase databaseWithPath:dbPath];
		// [db setTraceExecution:YES];
		[db setLogsErrors:YES];
		[db open];
	}
	
	return self;
}

-(int) lastInsertRowId {
	NSString * query = @"SELECT last_insert_rowid()";
	int rowId = [db intForQuery:query];
	return rowId;
}



@end
