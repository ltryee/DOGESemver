//
//  DOGESemver.h
//  DOGESemver
//
//  Created by vectorliu on 2016/12/7.
//  Copyright © 2016年 DOGE Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "semver.h"

@interface DOGESemver : NSObject
{
    semver_t _prototype;
}

@property (nonatomic, readonly) NSInteger major;
@property (nonatomic, readonly) NSInteger minor;
@property (nonatomic, readonly) NSInteger patch;
@property (nonatomic, readonly) NSString *prerelease;
@property (nonatomic, readonly) NSString *stringValue;

+ (instancetype)semverWithString:(NSString *)aString;

- (instancetype)initWithString:(NSString *)aString;
- (NSComparisonResult)compare:(DOGESemver *)aSemver;
- (BOOL)satisfiesSemver:(DOGESemver *)aSemver withOperator:(NSString *)anOperator;

- (BOOL)satisfiesString:(NSString *)aString;

@end
