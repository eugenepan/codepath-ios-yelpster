//
//  MainViewController.m
//  yelpster
//
//  Created by Eugene Pan on 10/24/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import "MainViewController.h"

NSString * const kYelpConsumerKey=@"KLYpINtx0-aHzp8LjaAklA";
NSString * const kYelpConsumerSecret=@"KDxfNaZ6C_OZuehpzLLRq0RA7Ec";
NSString * const kYelpToken=@"bforA2MYtu8zx_jWG4B-sCFvF9JPaBR1";
NSString * const kYelpTokenSecret=@"j_VPwzZoIf-HIGQwaK0fbv5jCNU";

@interface MainViewController ()

@property (retain, nonatomic) UIBarButtonItem *filterButton;
@property (retain, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filterButton = [[UIBarButtonItem alloc] init];
    [self.filterButton setTitle:@"Filters"];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar showsCancelButton];
    
    self.resultsTableView.dataSource = self;
    self.resultsTableView.delegate = self;
    
    self.navigationItem.leftBarButtonItem = self.filterButton;
    self.navigationItem.titleView = self.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

@end
