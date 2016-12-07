//
//  DOGESemver.m
//  DOGESemver
//
//  Created by vectorliu on 2016/12/7.
//  Copyright © 2016年 DOGE Studio. All rights reserved.
//

#import "DOGESemver.h"
#import "DOGESemverOperatorHelper.h"

@implementation DOGESemver
@synthesize prerelease = _prerelease;

+ (instancetype)semverWithString:(NSString *)aString
{
    return [[[self class] alloc] initWithString:aString];
}

- (instancetype)initWithString:(NSString *)aString
{
    self = [super init];
    if (self) {
        semver_t semver;
        if (semver_parse([aString cStringUsingEncoding:NSUTF8StringEncoding], &semver) == 0) {
            _prototype = semver;
        }
    }
    return self;
}

- (void)dealloc
{
    semver_free(&_prototype);
}

- (NSInteger)major
{
    return (NSInteger)_prototype.major;
}

- (NSInteger)minor
{
    return (NSInteger)_prototype.minor;
}

- (NSInteger)patch
{
    return (NSInteger)_prototype.patch;
}

- (NSString *)prerelease
{
    if (!_prerelease) {
        _prerelease = [NSString stringWithCString:_prototype.prerelease encoding:NSUTF8StringEncoding];
    }
    return _prerelease;
}

#pragma mark - public methods
- (NSComparisonResult)compare:(DOGESemver *)aSemver
{
    return (NSComparisonResult)semver_compare(aSemver->_prototype, _prototype);
}

- (BOOL)satisfiesSemver:(DOGESemver *)aSemver withOperator:(NSString *)anOperator
{
    return (BOOL)semver_satisfies(_prototype,
                                  aSemver->_prototype,
                                  [anOperator cStringUsingEncoding:NSUTF8StringEncoding]);
}

- (BOOL)satisfiesString:(NSString *)aString
{
    NSDictionary *dict = [DOGESemverOperatorHelper separateOperatorAndSemverFromString:aString];
    NSString *op = dict[@"operator"];
    DOGESemver *semver = dict[@"semver"];
    
    if (op.length == 0) {
        return ([self compare:semver] == NSOrderedSame);
    }
    else {
        return [self satisfiesSemver:semver withOperator:op];
    }
}

#pragma mark - others

@end
