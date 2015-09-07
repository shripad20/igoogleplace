

#import "AbstractRepository.h"
#import "PlaceModel.h"

@interface FavoriteRepository : AbstractRepository

- (BOOL)insertFavoritePlace:(NSString *)place_id;

- (BOOL)createFavoriteTable;

- (BOOL)checkIfFavoritePlace:(NSString *)place_id;

- (BOOL)removePlaceFromFavorite:(NSString *)place_id;



@end
