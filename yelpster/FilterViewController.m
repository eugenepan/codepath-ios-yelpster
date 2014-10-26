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

@interface FilterViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>

@property (retain, nonatomic) UIBarButtonItem *cancelButton;
@property (retain, nonatomic) UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *filtersTableView;
@property (strong, nonatomic) NSMutableArray *filterSections;
@property (nonatomic, strong) NSDictionary *filters;

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
    categoryFilterSection.options = @[@"Burmese", @"Fast Food", @"Taiwanese"];
    categoryFilterSection.paramName= @"category_filter";
    categoryFilterSection.paramValues = @[@"burmese", @"hotdogs", @"taiwanese"];
    
    FilterSection *sortFilterSection = [[FilterSection alloc] init];
    sortFilterSection.name = @"Sort by";
    sortFilterSection.options = @[@"Best Match", @"Distance", @"Rating"];
    sortFilterSection.paramName= @"sort";
    sortFilterSection.paramValues = @[@"0", @"1", @"2"];
    
    FilterSection *distanceFilterSection = [[FilterSection alloc] init];
    distanceFilterSection.name = @"Distance";
    distanceFilterSection.options = @[@"1 mi", @"5 mi", @"10 mi"];
    distanceFilterSection.paramName= @"radius_filter";
    distanceFilterSection.paramValues = @[@"1600", @"8000", @"16000"];
    
    FilterSection *dealsFilterSection = [[FilterSection alloc] init];
    dealsFilterSection.name = @"Most Popular";
    dealsFilterSection.options = @[@"Offering a Deal"];
    dealsFilterSection.paramName= @"deals_filter";
    dealsFilterSection.paramValues = @[@"true"];
    
    self.filterSections = [NSMutableArray arrayWithObjects:categoryFilterSection, sortFilterSection, distanceFilterSection, dealsFilterSection, nil];
    
    self.filters = @{
                     categoryFilterSection.paramName: [[NSMutableArray alloc]init],
                     sortFilterSection.paramName: [[NSMutableArray alloc]init],
                     distanceFilterSection.paramName: [[NSMutableArray alloc]init],
                     dealsFilterSection.paramName: [[NSMutableArray alloc]init],
                     };
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
    return filterSection.options.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView {
    return self.filterSections.count;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FilterSection *filterSection = self.filterSections[section];
    return filterSection.name;
}

- (float) tableView: (UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterSection *filterSection = self.filterSections[indexPath.section];
    
    SwitchCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    tableViewCell.titleLabel.text = filterSection.options[indexPath.row];
    NSLog(@"%@", filterSection.paramValues[indexPath.row]);
    tableViewCell.toggleSwitch.on = [self.filters[filterSection.paramName] containsObject:filterSection.paramValues[indexPath.row]];
    tableViewCell.delegate = self;
    
    return tableViewCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *) fetchCurrentSearchTerm {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"searchTerm"];
}

- (void) switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value {
    NSIndexPath *indexPath = [self.filtersTableView indexPathForCell:cell];
    FilterSection *filterSection = self.filterSections[indexPath.section];
    
    NSString *filterToUpdate = filterSection.paramValues[indexPath.row];
    
    if (value) {
        if ([filterSection.name isEqualToString:@"Sort by"] || [filterSection.name isEqualToString:@"Distance"]) {
            [self.filters[filterSection.paramName] removeAllObjects];
        }
        [self.filters[filterSection.paramName] addObject:filterToUpdate];
        [self.filtersTableView reloadData];
    } else {
        [self.filters[filterSection.paramName] removeObject:filterToUpdate];
    }
    
    NSLog(@"%@", filterSection.paramName);
    NSLog(@"%@", self.filters[filterSection.paramName]);
}

@end
