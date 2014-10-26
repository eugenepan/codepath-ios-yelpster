//
//  FilterViewController.h
//  yelpster
//
//  Created by Eugene Pan on 10/25/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

- (void)filterViewController:(FilterViewController *) filterViewController didChangeFilters:(NSDictionary *) filters;

@end

@interface FilterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;

@end
