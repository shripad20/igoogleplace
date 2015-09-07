//
//  HomeViewController.m
//  GooglePlaces
//
//  Created by Shripad on 03/09/15.
//  Copyright (c) 2015 Shripad Chidrawar. All rights reserved.
//

#import "HomeViewController.h"
#import "CommonFilesImport.h"
#import "PlacesViewController.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *placesTableView;
@property (nonatomic, strong) NSArray *placeList;
@property (nonatomic, strong) NSString *rangeInMeter;



@end

@implementation HomeViewController

#pragma mark - View life cycle -

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

    [self.view setNeedsUpdateConstraints];
}

#pragma mark - Set Constraints -

- (void)updateViewConstraints {
    
    if (!self.didSetupConstraints) {
        
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:PTPX(10)];
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [_placesTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        
        
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




#pragma mark - Private methods - 

- (void)addNavRightButton {
    
    UIBarButtonItem *rangeButton =[[UIBarButtonItem alloc]initWithTitle:@"Change Range" style:UIBarButtonItemStyleDone target:self action:@selector(rangeButtonTapped)];
    [rangeButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(15)],
                                         NSFontAttributeName, nil]
                               forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = rangeButton;
}

- (void)setNavigationTitle {
    
    self.title = @"PLACES";
    [ROOT_CONTROLLER.mainNavController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:OPEN_SANS_BOLD size:PTPX(20)],
      NSFontAttributeName, nil]];
}

- (void)initializeValues {
    
    self.placeList = [[NSArray alloc]initWithObjects:@"Food", @"Gym", @"School", @"Hospital", @"Spa", @"Restaurant", nil];
    
    self.rangeInMeter = @"200";
}

- (void)askForRange {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                     message:@"Please select distance in meter to search places "
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Ok", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Enter Range";
    [alert show];
}

#pragma mark - Event Handling methods -

- (void)rangeButtonTapped {
    
    [self askForRange];
}

#pragma mark - Delegate Methods -

#pragma mark - alertview delegate methods -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        self.rangeInMeter = [[alertView textFieldAtIndex:0] text];
    }
}

#pragma mark - tableview delegate methods


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    
    return self.placeList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifyer = @"PlaceViewCell";
    
    UITableViewCell *cell =  (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifyer];
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifyer];
    }
    
    cell.textLabel.text = [self.placeList objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:OPEN_SANS_SEMIBOLD size:PTPX(13)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}


#pragma mark - Table View Delegate methods


- (CGFloat)	  tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PlacesViewController *placeViewController = [[PlacesViewController alloc]init];
    placeViewController.selecetdType = [[self.placeList objectAtIndex:indexPath.row] lowercaseString];
    placeViewController.rangeInMeter = self.rangeInMeter;
    [ROOT_CONTROLLER.mainNavController pushViewController:placeViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}


@end
