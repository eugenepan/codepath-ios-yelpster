//
//  FilterViewController.m
//  yelpster
//
//  Created by Eugene Pan on 10/25/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@property (retain, nonatomic) UIBarButtonItem *cancelButton;
@property (retain, nonatomic) UIBarButtonItem *searchButton;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onSearchButton {
    [self.searchViewController loadSearch:@"Fast Food"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
