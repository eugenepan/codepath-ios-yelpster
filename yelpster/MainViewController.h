//
//  MainViewController.h
//  yelpster
//
//  Created by Eugene Pan on 10/24/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

- (void) executeSearch:(NSDictionary *)searchParams;

@end
