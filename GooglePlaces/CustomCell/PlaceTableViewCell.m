//
//  PlaceTableViewCell.m
//  GooglePlaces
//
//  Created by Shripad on 05/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "PlaceTableViewCell.h"
#import "CommonFilesImport.h"

@interface PlaceTableViewCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation PlaceTableViewCell

#pragma mark - Object LifecycleMethods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self configureUI];
    }
    return self;
}

- (void)resetCell {
    
    [self.iconImageView setImage:[UIImage imageNamed:@""]];
    [self.iconImageView removeFromSuperview];
    self.iconImageView = nil;
    [self.titleLabel setText:@""];
    self.didSetupConstraints = NO;
}

#pragma mark - UI Creation

- (void)configureUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iconImageView];
    [self setCellViewConstraints];
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]initForAutoLayout];
        _titleLabel.text = @"-";
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        _titleLabel.font = [UIFont fontWithName:OPEN_SANS size:14];
    }
    return _titleLabel;
    
}

-(UIImageView *) iconImageView{
    
    if(!_iconImageView){
        
        _iconImageView = [[UIImageView alloc]initForAutoLayout];
        [_iconImageView setImage:[UIImage imageNamed:@""]];
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;

    }
    
    return _iconImageView;
}

#pragma mark - public methods -

- (void)setCellDetailsValue:(PlaceModel *)place {
    
    self.titleLabel.text = place.name;
    
}



#pragma mark - Set Constraints -

- (void)setCellViewConstraints {
    
        [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        [self.iconImageView autoSetDimension:ALDimensionWidth toSize:26];
        [self.iconImageView autoSetDimension:ALDimensionHeight toSize:26];
        
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    
}



@end
