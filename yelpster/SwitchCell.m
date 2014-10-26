//
//  SwitchCell.m
//  yelpster
//
//  Created by Eugene Pan on 10/25/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate switchCell:self didUpdateValue:self.toggleSwitch.on];
}

@end
