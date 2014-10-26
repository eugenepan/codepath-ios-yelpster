//
//  SwitchCell.h
//  yelpster
//
//  Created by Eugene Pan on 10/25/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

- (IBAction)switchValueChanged:(id)sender;

@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;

@end
