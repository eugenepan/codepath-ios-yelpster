//
//  Result.m
//  yelpster
//
//  Created by Eugene Pan on 10/24/14.
//  Copyright (c) 2014 Eugene Pan. All rights reserved.
//

#import "Result.h"

@implementation Result

+ (NSArray *)unpackSearchResponse:(NSArray *)searchResults {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    float milesPerMeter = 0.000621371;
    
    for (NSDictionary *searchResult in searchResults) {
        Result *result = [[Result alloc]init];
        result.imageURL = searchResult[@"image_url"];
        result.name = searchResult[@"name"];
        result.distance = [searchResult[@"distance"] integerValue] * milesPerMeter;
        result.ratingsURL = searchResult[@"rating_img_url"];
        result.reviewCount = [NSString stringWithFormat:@"%@",searchResult[@"review_count"]];
        NSArray *address = [searchResult valueForKeyPath:@"location.address"];
        result.address = address.count ? address[0] : @"";
        result.categories = [[NSMutableArray alloc]init];
        for (NSString *category in searchResult[@"categories"][0]) {
            [result.categories addObject:category];
        }
        [results addObject:result];
    }
    
    return results;
}

@end