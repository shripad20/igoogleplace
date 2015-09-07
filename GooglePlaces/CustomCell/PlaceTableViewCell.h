//
//  PlaceTableViewCell.h
//  GooglePlaces
//
//  Created by Shripad on 05/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"


@interface PlaceTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;


- (void)setCellDetailsValue:(PlaceModel *)place ;
- (void)resetCell;
@end
