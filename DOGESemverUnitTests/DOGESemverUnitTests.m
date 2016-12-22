//
//  DOGESemverUnitTests.m
//  DOGESemverUnitTests
//
//  Created by vectorliu on 2016/12/7.
//  Copyright © 2016年 DOGE Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DOGESemver.h"
#import "DOGESemverOperatorHelper.h"

@interface DOGESemverUnitTests : XCTestCase
{
    DOGESemver *_sub;
}
@end

@implementation DOGESemverUnitTests

- (void)setUp {
    [super setUp];
    
    _sub = [DOGESemver semverWithString:@"5.7.1"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateSemver
{
    [self testCreateSemverWithString:@"5.7.2"
                              expect:@{@"major": @(5),
                                       @"minor": @(7),
                                       @"patch": @(2),
                                       }];
    
    [self testCreateSemverWithString:@"5.7"
                              expect:@{@"major": @(5),
                                       @"minor": @(7),
                                       }];
    
    [self testCreateSemverWithString:@"5"
                              expect:@{@"major": @(5),
                                       }];
}

- (void)testCreateSemverWithString:(NSString *)aString expect:(NSDictionary *)dict
{
    // given
    
    // when
    DOGESemver *semver = [DOGESemver semverWithString:aString];
    
    // then
    NSLog(@"testing create semver %@", aString);
    XCTAssertEqual(semver.major,
                   ((NSNumber *)dict[@"major"]).integerValue,
                   @"invalid major %@, expect %@", @(semver.major), dict[@"major"]);
    XCTAssertEqual(semver.minor,
                   ((NSNumber *)dict[@"minor"]).integerValue,
                   @"invalid minor %@, expect %@", @(semver.minor), dict[@"minor"]);
    XCTAssertEqual(semver.patch,
                   ((NSNumber *)dict[@"patch"]).integerValue,
                   @"invalid patch %@, expect %@", @(semver.patch), dict[@"patch"]);
}

- (void)testHelper
{
    [self testHelperWithString:@"=5.7.1"
                        expect:@{@"operator": @"=",
                                 @"major": @(5),
                                 @"minor": @(7),
                                 @"patch": @(1),
                                 }];
}

- (void)testHelperWithString:(NSString *)aString expect:(NSDictionary *)result
{
    // given
    
    // when
    NSDictionary *dict = [DOGESemverOperatorHelper separateOperatorAndSemverFromString:aString];
    DOGESemver *testee = (DOGESemver *)dict[@"semver"];
    
    // then
    XCTAssert([(NSString *)dict[@"operator"] isEqualToString:result[@"operator"]], @"invalid operator %@, expect %@", dict[@"operator"], result[@"operator"]);
    
    XCTAssert([@(testee.major) compare:result[@"major"]] == NSOrderedSame
              && [@(testee.minor) compare:result[@"minor"]] == NSOrderedSame
              && [@(testee.patch) compare:result[@"patch"]] == NSOrderedSame, @"unexpected semver");
    XCTAssert(testee.prerelease == result[@"prerelease"], @"uncexpected prerelease");
    if (testee.prerelease && result[@"prerelease"]) {
        XCTAssert([testee.prerelease isEqualToString:result[@"prerelease"]], @"uncexpected prerelease");
    }
}

//- (void)testSatisfies
//{
//
//}
//
//- (void)testSatisfiesWithString:(NSString *)aString expectResult:(BOOL)result
//{
//    // given
//    DOGESemver *aSemver = [DOGESemver semverWithString:aString];
//    
//    // when
//    
//    
//    // then
//    
//}

@end
