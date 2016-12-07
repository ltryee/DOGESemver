//
//  DOGESemverOperatorHelper.m
//  DOGESemver
//
//  Created by vectorliu on 2016/12/7.
//  Copyright © 2016年 DOGE Studio. All rights reserved.
//

#import "DOGESemverOperatorHelper.h"
#import "DOGESemver.h"

@implementation DOGESemverOperatorHelper

+ (NSDictionary *)separateOperatorAndSemverFromString:(NSString *)aString
{
    NSRange range = [aString rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]];
    NSString *op = nil;
    DOGESemver *semver = nil;
    
    if (range.location == NSNotFound) {
        return nil;
    }
    
    if (range.location == 0) {
        op = @"";
        semver = [DOGESemver semverWithString:aString];
    }
    else {
        op = [aString substringToIndex:range.location - 1];
        semver = [DOGESemver semverWithString:[aString substringFromIndex:range.location]];
    }
    
    return @{
             @"operator": op,
             @"semver": semver,
             };
}

@end
