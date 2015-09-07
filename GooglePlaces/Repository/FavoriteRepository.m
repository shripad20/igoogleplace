

#import "FavoriteRepository.h"
#import "Macros.h"
#import "PlaceModel.h"

@implementation FavoriteRepository


- (void)openDataBaseConnection {
    [db close];
    
    NSString *dbPath = [AbstractRepository databasePath];
    db = [FMDatabase databaseWithPath:dbPath];
    [db setLogsErrors:YES];
    [db open];
}



- (BOOL)insertFavoritePlace:(NSString *)place_id {
    
    [self openDataBaseConnection];
    
    NSString *checkQuery = [NSString stringWithFormat:@"SELECT * FROM FavoritePlaces WHERE place_id = \"%@\"", place_id];
    
    FMResultSet *resultSet = [db executeQuery:checkQuery];
    
    NSString *query;
    if ([resultSet next]) {
        
        query = [NSString stringWithFormat:@"UPDATE FavoritePlaces SET record_status = 1 WHERE place_id = \"%@\"",  place_id];
        
    }else {
    
        
        query = [NSString stringWithFormat:@"insert into FavoritePlaces(place_id, Record_status) values(\"%@\", 1)",place_id];
        
    }
    
    DebugLog(@"query = \n%@", query);
    
    [self openDataBaseConnection];
    
    BOOL result = [db executeUpdate:query];
    
    return result;
}

- (BOOL)removePlaceFromFavorite:(NSString *)place_id {
    
    
    [self openDataBaseConnection];
    
    NSString *checkQuery = [NSString stringWithFormat:@"SELECT * FROM FavoritePlaces WHERE place_id = \"%@\"", place_id];
    
    FMResultSet *resultSet = [db executeQuery:checkQuery];
    
    NSString *query;
    if ([resultSet next]) {
        
        query = [NSString stringWithFormat:@"UPDATE FavoritePlaces SET Record_status = 0 WHERE place_id = \"%@\"", place_id];
        
    }
    DebugLog(@"removed variation : %@", query);
    
    [self openDataBaseConnection];
    BOOL result = [db executeUpdate:query];
    
    if (result) {
        
        DebugLog(@">>>>>>>>>removed record success<<<<<<<<<");
    }
    
    return result;
}



- (BOOL)checkIfFavoritePlace:(NSString *)place_id {
    
    [self openDataBaseConnection];
    
    NSString *checkQuery = [NSString stringWithFormat:@"SELECT * FROM FavoritePlaces WHERE place_id = \"%@\" AND record_status = 1", place_id];
    
    FMResultSet *resultSet = [db executeQuery:checkQuery];
    
    BOOL result = NO;
    if ([resultSet next]) {
        
        result = [resultSet boolForColumn:@"record_status"];
    }
    
    return result;
}


- (BOOL)createFavoriteTable {
    
    [self openDataBaseConnection];
    
    NSString *query = @"CREATE TABLE FavoritePlaces(FavoriteId INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , place_id VARCHAR, Record_status BOOL)";
    
    BOOL result = [db executeUpdate:query];
    
    return result;
}


@end
