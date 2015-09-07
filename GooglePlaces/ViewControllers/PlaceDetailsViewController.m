//
//  PlaceDetailsViewController.m
//  GooglePlaces
//
//  Created by Shripad on 05/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "PlaceDetailsViewController.h"
#import <MapKit/MapKit.h>
#import "CommonFilesImport.h"
#import "UserDefaultUtils.h"

@interface PlaceDetailsViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIImageView *placeImageView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *addressValueLabel;
@property (nonatomic, strong) MKMapView *placeMapView;
@property (nonatomic, strong) UILabel *openingTimeLabel;
@property (nonatomic, strong) UILabel *openingHoursLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *mapContainerView;
@property (nonatomic, strong) UILabel *ratingLabel;
@property (nonatomic, strong) UILabel *ratingValueLabel;
@property (nonatomic, strong) UIButton *starButton;


@end

@implementation PlaceDetailsViewController


#pragma mark - View Life Cycle methods -

- (void)loadView {
    
    self.view = [UIView new];
    [super loadView];
    
    self.title = [self.place.name uppercaseString];
    [ROOT_CONTROLLER.mainNavController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(20)],
      NSFontAttributeName, nil]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.placeImageView];
    [self.scrollView addSubview:self.starButton];
    [self.scrollView addSubview:self.addressLabel];
    [self.scrollView addSubview:self.addressValueLabel];
    [self.scrollView addSubview:self.mapContainerView];
    [self.scrollView addSubview:self.openingHoursLabel];
    [self.scrollView addSubview:self.openingTimeLabel];
    [self.scrollView addSubview:self.ratingLabel];
    [self.scrollView addSubview:self.ratingValueLabel];
    

    [self zoomIn:nil];
    
    if ([UserDefaultUtils retriveObjectForKey:self.place.reference] != nil) {
        
        self.placeImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.placeImageView.image = [UIImage imageWithData:[UserDefaultUtils retriveObjectForKey:self.place.reference]];
    }else {
    
        NSString *URLStr = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=AIzaSyA3Wcw4H90yScT8Upnv5k4jpVUF1BAqDTc", self.place.photos.photo_reference];
        [self downloadImageWithURL:[NSURL URLWithString:URLStr] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                self.placeImageView.contentMode = UIViewContentModeScaleAspectFit;
                if (image == nil) {
                    
                    [self downloadImageWithURL:[NSURL URLWithString:self.place.icon] completionBlock:^(BOOL succeeded, UIImage *image) {
                        if (succeeded) {
                            // change the image in the cell
                            self.placeImageView.contentMode = UIViewContentModeScaleAspectFit;
                            self.placeImageView.image = image;
                            
                            [UserDefaultUtils saveObject:UIImagePNGRepresentation(image) forKey:self.place.reference];
                        }
                    }];
                }
                self.placeImageView.image = image;
                
                [UserDefaultUtils saveObject:UIImagePNGRepresentation(image) forKey:self.place.reference];
            }
        }];
    }

    [self.view setNeedsUpdateConstraints];
}


#pragma mark - Set View Constraints -

- (void)updateViewConstraints {
    
    if (!self.didSetupConstraints) {
        
        [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:PTPX(0)];
        [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        
        [self.placeImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:PTPX(1)];
        [self.placeImageView autoSetDimension:ALDimensionWidth toSize:PTPX(320)];
        [self.placeImageView autoSetDimension:ALDimensionHeight toSize:PTPX(228)];
        
        [self.starButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.placeImageView withOffset:PTPX(5)];
        [self.starButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(270)];
        [self.starButton autoSetDimension:ALDimensionWidth toSize:PTPX(25)];
        [self.starButton autoSetDimension:ALDimensionHeight toSize:PTPX(25)];

        [self.addressLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(20)];
        [self.addressLabel autoSetDimension:ALDimensionWidth toSize:PTPX(250)];
        [self.addressLabel autoSetDimension:ALDimensionHeight toSize:PTPX(25)];
        [self.addressLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.placeImageView withOffset:PTPX(5)];
        
        [self.addressValueLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.addressLabel withOffset:PTPX(0)];
        [self.addressValueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(20)];
        [self.addressValueLabel autoSetDimension:ALDimensionWidth toSize:PTPX(280)];
        [self.addressValueLabel autoSetDimension:ALDimensionHeight toSize:PTPX(45)];
        
        [self.mapContainerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.addressValueLabel withOffset:PTPX(5)];
        [self.mapContainerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(20)];
        [self.mapContainerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:PTPX(20)];
        [self.mapContainerView autoSetDimension:ALDimensionHeight toSize:PTPX(0)];
        

        [self.openingHoursLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapContainerView withOffset:PTPX(110)];
        [self.openingHoursLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(20)];
        [self.openingHoursLabel autoSetDimension:ALDimensionWidth toSize:PTPX(70)];
        [self.openingHoursLabel autoSetDimension:ALDimensionHeight toSize:PTPX(25)];
        
        [self.openingTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapContainerView withOffset:PTPX(110)];
        [self.openingTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(75)];
        [self.openingTimeLabel autoSetDimension:ALDimensionWidth toSize:PTPX(50)];
        [self.openingTimeLabel autoSetDimension:ALDimensionHeight toSize:PTPX(25)];
        
        [self.openingHoursLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapContainerView withOffset:PTPX(110)];
        [self.openingHoursLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(20)];
        [self.openingHoursLabel autoSetDimension:ALDimensionWidth toSize:PTPX(70)];
        [self.openingHoursLabel autoSetDimension:ALDimensionHeight toSize:PTPX(25)];
        
        [self.openingTimeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapContainerView withOffset:PTPX(110)];
        [self.openingTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(75)];
        [self.openingTimeLabel autoSetDimension:ALDimensionWidth toSize:PTPX(50)];
        [self.openingTimeLabel autoSetDimension:ALDimensionHeight toSize:PTPX(25)];
        
        [self.ratingLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapContainerView withOffset:PTPX(110)];
        [self.ratingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:PTPX(180)];
        [self.ratingLabel autoSetDimension:ALDimensionWidth toSize:PTPX(60)];
        [self.ratingLabel autoSetDimension:ALDimensionHeight toSize:PTPX(25)];
        
        [self.ratingValueLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mapContainerView withOffset:PTPX(110)];
        [self.ratingValueLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.ratingLabel withOffset:PTPX(0)];
        [self.ratingValueLabel autoSetDimension:ALDimensionHeight toSize:PTPX(25)];
        [self.ratingValueLabel autoSetDimension:ALDimensionWidth toSize:PTPX(50)];
        
        [self.ratingValueLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:PTPX(10)];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
    
}


#pragma mark - getter methods -

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initForAutoLayout];
        _scrollView.delegate = (id)self;
        
    }
    
    return _scrollView;
}

- (UIImageView *)placeImageView {
    
    if(!_placeImageView) {
        
        _placeImageView = [[UIImageView alloc]initForAutoLayout];
        _placeImageView.contentMode = UIViewContentModeScaleAspectFit;
        _placeImageView.image = [UIImage imageNamed:@"defaultImage"];
//        _placeImageView.userInteractionEnabled = YES;
    }
    return _placeImageView;
}

- (UIButton *)starButton {
    
    if (!_starButton) {
        
        _starButton = [[UIButton alloc]initForAutoLayout];
        [_starButton setBackgroundImage:[UIImage imageNamed:@"img_star"] forState:UIControlStateNormal];
        [_starButton setBackgroundImage:[UIImage imageNamed:@"img_star_selected"] forState:UIControlStateSelected];
        [_starButton addTarget:self action:@selector(starButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        BOOL isFavorite = [PlaceModel checkIfPlacefavorite:self.place.place_id];
        
        if (isFavorite) {
            
            [_starButton setSelected:YES];
            
        }else {
            
            [_starButton setSelected:NO];
        }
        
    }
    return _starButton;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc]initForAutoLayout];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.font = [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(16)];
        _addressLabel.text = @"Address";
        
    }
    
    return _addressLabel;
}

- (UILabel *)addressValueLabel {
    
    if (!_addressValueLabel) {
        
        _addressValueLabel = [[UILabel alloc]initForAutoLayout];
        _addressValueLabel.textAlignment = NSTextAlignmentLeft;
        _addressValueLabel.textColor = [UIColor blackColor];
        _addressValueLabel.font = [UIFont fontWithName:OPEN_SANS size:PTPX(13)];
        _addressValueLabel.text = self.place.vicinity;
        
        
        _addressValueLabel.numberOfLines = 2;
    }
    
    return _addressValueLabel;
}

- (UIView *)mapContainerView {
    
    
    if (!_mapContainerView) {
        
        _mapContainerView = [[UIView alloc]initForAutoLayout];
        
        self.placeMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 280, 100)];
        [_mapContainerView addSubview:self.placeMapView];
        self.placeMapView.mapType = MKMapTypeStandard;
        self.placeMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.placeMapView.backgroundColor = [UIColor redColor];
    }
    return _mapContainerView;
    
    
}

- (UILabel *)openingTimeLabel {
    
    if (!_openingTimeLabel) {
        
        _openingTimeLabel = [[UILabel alloc]initForAutoLayout];
        _openingTimeLabel.textAlignment = NSTextAlignmentLeft;
        _openingTimeLabel.textColor = [UIColor blackColor];
        _openingTimeLabel.font = [UIFont fontWithName:OPEN_SANS size:PTPX(16)];
        _openingTimeLabel.text = @"Open";
        
    }
    
    return _openingTimeLabel;
}

- (UILabel *)openingHoursLabel {
    
    if (!_openingHoursLabel) {
        
        _openingHoursLabel = [[UILabel alloc]initForAutoLayout];
        _openingHoursLabel.textAlignment = NSTextAlignmentLeft;
        _openingHoursLabel.textColor = [UIColor blackColor];
        _openingHoursLabel.font = [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(16)];
        _openingHoursLabel.text = @"Hours: ";
        
    }
    
    return _openingHoursLabel;
}

- (UILabel *)ratingLabel{
    
    if (!_ratingLabel) {
        
        _ratingLabel = [[UILabel alloc]initForAutoLayout];
        _ratingLabel.textAlignment = NSTextAlignmentLeft;
        _ratingLabel.textColor = [UIColor blackColor];
        _ratingLabel.font = [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(16)];
        _ratingLabel.text = @"Rating: ";
        
    }
    
    return _ratingLabel;
}

- (UILabel *)ratingValueLabel {
    
    if (!_ratingValueLabel) {
        
        _ratingValueLabel = [[UILabel alloc]initForAutoLayout];
        _ratingValueLabel.textAlignment = NSTextAlignmentLeft;
        _ratingValueLabel.textColor = [UIColor blackColor];
        _ratingValueLabel.font = [UIFont fontWithName:OPEN_SANS size:PTPX(16)];
        
        if (isnan(self.place.rating)) {
            
            self.place.rating = 0.0;
        }
        _ratingValueLabel.text = [NSString stringWithFormat:@"%.1f", self.place.rating];
    }
    
    return _ratingValueLabel;
}

- (void)zoomIn:(id)sender {
    
    //    CLLocationCoordinate2D annotationCoord;
    
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = [self.place.location.lat floatValue];
    annotationCoord.longitude = [self.place.location.lng floatValue];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = self.place.name;
    annotationPoint.subtitle = self.place.vicinity;
    [self.placeMapView addAnnotation:annotationPoint];
    
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        annotationCoord, 200, 200);
    [self.placeMapView setRegion:region animated:YES];
    
    
}


#pragma mark - private methods -

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                                   {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                                   } else{
                                       completionBlock(NO,nil);
                                   }
                           }];
}

#pragma mark - Event Handling Methods -

- (void)starButtonTapped:(UIButton *)sender {
    
    if (sender.isSelected) {
        
        
        BOOL status = [PlaceModel removePlaceFromFavorite:self.place.place_id];
        if (status) {
            [sender setSelected:NO];
        }
        
        
    }else {
        
        BOOL status = [PlaceModel insertPlaceAsFavorite:self.place.place_id];
        if (status) {
            [sender setSelected:YES];
        }

    }
}

@end
