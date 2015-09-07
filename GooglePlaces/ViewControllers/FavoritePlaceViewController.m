//
//  FavoritePlaceViewController.m
//  GooglePlaces
//
//  Created by Shripad on 06/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "FavoritePlaceViewController.h"
#import "CommonFilesImport.h"
#import "PlaceModel.h"
#import "PlaceTableViewCell.h"
#import "PlaceDetailsViewController.h"
#import "RootViewController.h"

@interface FavoritePlaceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *placesTableView;
@property (nonatomic, strong) NSMutableArray *favPlaceList;
@property (nonatomic, strong) UILabel *messageLabel;


@end

@implementation FavoritePlaceViewController


- (void)loadView {
    
    self.view = [UIView new];
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [NSString stringWithFormat:@"FAVORITE %@", [self.selecetdType uppercaseString]];
    [ROOT_CONTROLLER.mainNavController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(15)],
      NSFontAttributeName, nil]];
    [self initializeValues];
    [self.view addSubview:self.placesTableView];
    [self.view addSubview:self.messageLabel];
    [self callPlaceListAPI];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self initializeValues];
}

#pragma mark - Set Constraints -

- (void)updateViewConstraints {
    
    if (!self.didSetupConstraints) {
        
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:PTPX(0)];
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        
        [self.messageLabel autoCenterInSuperview];
        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
    
}

#pragma mark - Getter methods -

- (UITableView *)placesTableView {
    
    if (!_placesTableView) {
        
        _placesTableView = [[UITableView alloc]initForAutoLayout];
        _placesTableView.delegate = self;
        _placesTableView.dataSource = self;
        _placesTableView.backgroundColor = [UIColor clearColor];
        
    }
    return _placesTableView;
}

- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        
        _messageLabel = [[UILabel alloc]initForAutoLayout];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(16)];
        _messageLabel.text = @"No Records found";
        _messageLabel.hidden = YES;
        
    }
    
    return _messageLabel;
}


#pragma mark - Private methods -

- (void)initializeValues {
    
    self.favPlaceList = [[NSMutableArray alloc]init];
    [self.favPlaceList removeAllObjects];
    for (int i = 0; i<self.placeList.count; i++) {
    
        PlaceModel *place = [self.placeList objectAtIndex:i];
        if ([PlaceModel checkIfPlacefavorite:place.place_id]) {
            
            [self.favPlaceList addObject:place];
        }
    }
    
    if (self.favPlaceList.count == 0) {
        
        self.messageLabel.hidden = NO;
    } else {
        
        self.messageLabel.hidden = YES;
    }
    [self.placesTableView reloadData];
}

#pragma mark - API Call Methods -

- (void)callPlaceListAPI {
    
    //   https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=19.017615,72.856164&radius=100&types=food&key=AIzaSyDD865XS5WcS9KikbHAlMDq6byTzb8rxGQ
    //
    NSString *urlStr = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=600&types=%@&key=AIzaSyA3Wcw4H90yScT8Upnv5k4jpVUF1BAqDTc", ROOT_CONTROLLER.latitude, ROOT_CONTROLLER.longitude, self.selecetdType];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlStr]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSString *responseString =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"result: %@", responseString);
                NSDictionary *mainDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                self.placeList = [[NSMutableArray alloc]init];
                for (NSDictionary *dict in [mainDict valueForKey:@"results"]) {
                    
                    PlaceModel *place = [PlaceModel getPlaceModelFromDictionary:dict];
                    [self.placeList addObject:place];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.placesTableView reloadData];
                });
                
                
                
            }] resume];
    
    
}

#pragma mark - Delegate Methods -

#pragma mark - tableview delegate methods


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    
    return self.favPlaceList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifyer = @"PlaceViewCell";
    
    PlaceTableViewCell *cell;
    
    
    if (cell == nil) {
        
        cell = [[PlaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifyer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    PlaceModel *place = [self.favPlaceList objectAtIndex:indexPath.row];
    [cell setCellDetailsValue:place];
    
    [self downloadImageWithURL:[NSURL URLWithString:place.icon] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.iconImageView.image = image;
        }
    }];
    return cell;
    
}

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


#pragma mark - Table View Delegate methods


- (CGFloat)	  tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlaceDetailsViewController *placeDetailViewController = [[PlaceDetailsViewController alloc]init];
    placeDetailViewController.place = [self.favPlaceList objectAtIndex:indexPath.row];
    
    [ROOT_CONTROLLER.mainNavController pushViewController:placeDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}



@end
