//
//  FilterSection.h
//  yelpster
//
//  Created by Eugene Pan on 10/25/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterSection : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSArray *paramValues;

@end
