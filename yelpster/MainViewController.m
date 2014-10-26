//
//  MainViewController.m
//  yelpster
//
//  Created by Eugene Pan on 10/24/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "MainViewController.h"
#import "FilterViewController.h"
#import "YelpClient.h"
#import "Result.h"
#import "ResultCell.h"
#import "SVProgressHUD.h"

NSString * const kYelpConsumerKey=@"KLYpINtx0-aHzp8LjaAklA";
NSString * const kYelpConsumerSecret=@"KDxfNaZ6C_OZuehpzLLRq0RA7Ec";
NSString * const kYelpToken=@"bforA2MYtu8zx_jWG4B-sCFvF9JPaBR1";
NSString * const kYelpTokenSecret=@"j_VPwzZoIf-HIGQwaK0fbv5jCNU";

@interface MainViewController ()<FilterViewControllerDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, retain) NSArray *searchResults;
@property (nonatomic, weak) NSString *currSearchTerm;

@property (retain, nonatomic) UIBarButtonItem *filterButton;
@property (retain, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filterButton = [[UIBarButtonItem alloc]
                         initWithTitle:@"Filters"
                         style:UIBarButtonItemStylePlain
                         target:self
                         action:@selector(onFilterButton)];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar showsCancelButton];
    
    self.resultsTableView.dataSource = self;
    self.resultsTableView.delegate = self;
    [self.resultsTableView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:nil]
                forCellReuseIdentifier:@"ResultCell"];
    
    self.navigationItem.leftBarButtonItem = self.filterButton;
    self.navigationItem.titleView = self.searchBar;
    
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    
    [self saveCurrentSearchTerm:@"Burma"];
    [self loadSearch:@"Burma"];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.resultsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    Result *result = self.searchResults[indexPath.row];
    
    [cell.resultImageView setImageWithURL:[NSURL URLWithString:result.imageURL]];
    cell.resultImageView.layer.borderWidth = 1.0f;
    cell.resultImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.resultImageView.layer.masksToBounds = YES;
    cell.resultImageView.layer.cornerRadius = 10.0f;
    
    cell.nameLabel.text = result.name;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi", result.distance];
    [cell.ratingsImageView setImageWithURL:[NSURL URLWithString:result.ratingsURL]];
    cell.reviewCountLabel.text =
        [NSString stringWithFormat:@"%@ reviews", result.reviewCount];
    cell.addressLabel.text = result.address;
    cell.categoriesLabel.text = [result.categories componentsJoinedByString:@", "];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self saveCurrentSearchTerm:searchBar.text];
    [self loadSearch:searchBar.text];
    [self.searchBar resignFirstResponder];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void) loadSearch:(NSString *)searchTerm {
    [SVProgressHUD show];
    [self.client searchWithTerm:searchTerm
                        success:^(AFHTTPRequestOperation *operation, id response) {
     //   NSLog(@"response: %@", response);
        self.searchResults = [Result unpackSearchResponse:response[@"businesses"]];
        [self.resultsTableView reloadData];
                           [SVProgressHUD dismiss];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error: %@", [error description]);
     }];
}

- (void) onFilterButton {
    FilterViewController *fvc = [[FilterViewController alloc]init];
    fvc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc]
                                   initWithRootViewController:fvc];
    nvc.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) saveCurrentSearchTerm: (NSString *) searchTerm {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:searchTerm forKey:@"searchTerm"];
    [defaults synchronize];
}

- (NSString *) fetchCurrentSearchTerm {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"searchTerm"];
}

#pragma mark - Filter delegate methods

- (void)filterViewController:(FilterViewController *)filterViewController didChangeFilters:(NSDictionary *)filters {
    
}

@end
