//
//  Result.h
//  yelpster
//
//  Created by Eugene Pan on 10/24/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Result : NSObject

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, strong) NSString *ratingsURL;
@property (nonatomic, strong) NSString *reviewCount;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSMutableArray *categories;

+ (NSArray *)unpackSearchResponse:(NSArray *)searchResults;

@end
