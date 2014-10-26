//
//  FilterViewController.m
//  yelpster
//
//  Created by Eugene Pan on 10/25/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterSection.h"
#import "SwitchCell.h"

@interface FilterViewController ()

@property (retain, nonatomic) UIBarButtonItem *cancelButton;
@property (retain, nonatomic) UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *filtersTableView;
@property (strong, nonatomic) NSMutableArray *filterSections;
@property (nonatomic, readonly) NSDictionary *filters;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cancelButton = [[UIBarButtonItem alloc]
                         initWithTitle:@"Cancel"
                         style:UIBarButtonItemStylePlain
                         target:self
                         action:@selector(onCancelButton)];
    
    self.searchButton = [[UIBarButtonItem alloc]
                         initWithTitle:@"Search"
                         style:UIBarButtonItemStylePlain
                         target:self
                         action:@selector(onSearchButton)];
    
    self.navigationItem.leftBarButtonItem = self.cancelButton;
    self.navigationItem.rightBarButtonItem = self.searchButton;
    self.navigationItem.title = @"Filters";
    
    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self;
    
    [self.filtersTableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    
    FilterSection *categoryFilterSection = [[FilterSection alloc] init];
    categoryFilterSection.name = @"Category";
    categoryFilterSection.optionToParamValueDict = @{
                                                     @"Burmese" : @"Burmese",
                                                     @"Fast Food" : @"Fast Food",
                                                     @"Taiwanes" : @"Taiwanes",
                                                     };
    
    FilterSection *sortFilterSection = [[FilterSection alloc] init];
    sortFilterSection.name = @"Sort by";
    sortFilterSection.optionToParamValueDict = @{
                                                 @"Best Match" : [NSNumber numberWithInt:0],
                                                 @"Distance" : [NSNumber numberWithInt: 1],
                                                 @"Rating" : [NSNumber numberWithInt:2],
                                                 };
    
    FilterSection *distanceFilterSection = [[FilterSection alloc] init];
    distanceFilterSection.name = @"Distance";
    distanceFilterSection.optionToParamValueDict = @{
                                                     @"1 mi" : [NSNumber numberWithInt:1600],
                                                     @"5 mi" : [NSNumber numberWithInt:80000],
                                                     @"10 mi" : [NSNumber numberWithInt:16000],
                                                     };
    
    
    FilterSection *dealsFilterSection = [[FilterSection alloc] init];
    dealsFilterSection.name = @"Most Popular";
    dealsFilterSection.optionToParamValueDict = @{@"Offering a Deal" : @NO};
    
    self.filterSections = [NSMutableArray arrayWithObjects:categoryFilterSection, sortFilterSection, distanceFilterSection, dealsFilterSection, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onSearchButton {
    [self.delegate filterViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FilterSection *filterSection = self.filterSections[section];
    return filterSection.optionToParamValueDict.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView {
    return self.filterSections.count;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FilterSection *filterSection = self.filterSections[section];
    return filterSection.name;
}

- (float) tableView: (UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterSection *filterSection = self.filterSections[indexPath.section];
    
    SwitchCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    tableViewCell.titleLabel.text = [filterSection.optionToParamValueDict allKeys][indexPath.row];
    
    return tableViewCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *) fetchCurrentSearchTerm {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"searchTerm"];
}

@end
