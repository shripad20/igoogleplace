//
//  PlacesViewController.m
//  GooglePlaces
//
//  Created by Shripad on 03/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "PlacesViewController.h"
#import "CommonFilesImport.h"
#import "PlaceModel.h"
#import "PlaceTableViewCell.h"
#import "PlaceDetailsViewController.h"
#import "RootViewController.h"
#import "FavoritePlaceViewController.h"
#import "MBProgressHUD.h"

@interface PlacesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *placesTableView;
@property (nonatomic, strong) NSMutableArray *placeList;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation PlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadView {
    
    self.view = [UIView new];
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationTitle];
    [self addNavRightButton];
    [self initializeValues];
    [self.view addSubview:self.placesTableView];
    [self.view addSubview:self.messageLabel];
    [self callPlaceListAPI];
    
    [self.view setNeedsUpdateConstraints];
}



#pragma mark - Set Constraints -

- (void)updateViewConstraints {
    
    if (!self.didSetupConstraints) {
        
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
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

- (void)addNavRightButton {
    
    UIBarButtonItem *favoriteButton =[[UIBarButtonItem alloc]initWithTitle:@"Favorites" style:UIBarButtonItemStyleDone target:self action:@selector(favoriteButtonTapped:)];
    [favoriteButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(15)],
                                            NSFontAttributeName, nil]
                                  forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = favoriteButton;
}

- (void)setNavigationTitle {
    
    self.title = [self.selecetdType uppercaseString];
    [ROOT_CONTROLLER.mainNavController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(15)],
      NSFontAttributeName, nil]];
}

- (void)initializeValues {
    
    self.placeList = [[NSMutableArray alloc]init];
}

#pragma mark - API Call Methods -

- (void)callPlaceListAPI {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%@&types=%@&key=AIzaSyA3Wcw4H90yScT8Upnv5k4jpVUF1BAqDTc", ROOT_CONTROLLER.latitude, ROOT_CONTROLLER.longitude, self.rangeInMeter, self.selecetdType];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlStr]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSString *responseString =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"result: %@", responseString);
//                NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *mainDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                self.placeList = [[NSMutableArray alloc]init];
                for (NSDictionary *dict in [mainDict valueForKey:@"results"]) {
                    
                    PlaceModel *place = [PlaceModel getPlaceModelFromDictionary:dict];
                    [self.placeList addObject:place];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                    if (self.placeList.count == 0) {
                        
                        _messageLabel.hidden = NO;
                    }  else {
                        
                        self.messageLabel.hidden = YES;
                    }
                    [self.placesTableView reloadData];
                });
                
                
                
            }] resume];
    
   
}

#pragma mark - Event Methods -

- (void)favoriteButtonTapped:(UIButton *)sender {
    
    NSLog(@"Favorite Button Tapped");
    FavoritePlaceViewController *favPlaceViewController = [[FavoritePlaceViewController alloc]init];
    favPlaceViewController.selecetdType = self.selecetdType;
    favPlaceViewController.placeList = self.placeList;
    [ROOT_CONTROLLER.mainNavController pushViewController:favPlaceViewController animated:YES];
}

#pragma mark - Delegate Methods -

#pragma mark - tableview delegate methods


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    
    return self.placeList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifyer = @"PlaceViewCell";
    
    PlaceTableViewCell *cell;
    
    
    if (cell == nil) {
        
        cell = [[PlaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifyer];
    }
    
    PlaceModel *place = [self.placeList objectAtIndex:indexPath.row];
    [cell setCellDetailsValue:place];
    
    [self downloadImageWithURL:[NSURL URLWithString:place.icon] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.iconImageView.image = image;
        }
    }];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    placeDetailViewController.place = [self.placeList objectAtIndex:indexPath.row];

    [ROOT_CONTROLLER.mainNavController pushViewController:placeDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}



@end
