//
//  FilterViewController.h
//  yelpster
//
//  Created by Eugene Pan on 10/25/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@protocol FilterViewControllerDelegate <NSObject>

- (void)loadSearch:(NSString *) searchTerm;

@end

@interface FilterViewController : UIViewController

@property (nonatomic, strong) id<FilterViewControllerDelegate> delegate;

@end
