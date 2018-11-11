//
//  SNPCategoryTests.m
//  SNPCategoryTests
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SNPHead.h"
@interface SNPCategoryTests : XCTestCase

@end

@implementation SNPCategoryTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNSArrayCategory {
    
    NSArray *arr0 = @[@"0", @"1"];
    NSArray *arr = @[arr0, @"2"];
    NSArray *arrCpDeep = [arr copyDeeply];
    
    XCTAssertFalse(arr == arrCpDeep);
    XCTAssertTrue([arr isEqualToArray:arrCpDeep]);
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:@[@"0", @"1"]];
    NSMutableArray *arr11 = [NSMutableArray arrayWithArray:@[arr1, @"1"]];
    NSMutableArray *marrCpDeep = [arr11 mutableCopyDeeply];
    
    XCTAssertFalse(arr11 == marrCpDeep);
    XCTAssertTrue([arr11 isEqualToArray:marrCpDeep]);
    marrCpDeep[1] = @"3";
    NSMutableArray *arrX = marrCpDeep[0];
    arrX[0] = @"00";
    XCTAssertFalse([arr11 isEqualToArray:marrCpDeep]);
}

- (void)testNSDictionaryCategory {
    
}

- (void)testNSStringCategory {
//    NSString *strInt = @"11";
//    NSString *strInteger = @"16";
//    NSString *strDouble = @"60.05";
//    NSString *strFloat = @"3.15";
    
    NSString *strJSON = @"{\"a\" : \"1\", \"b\" : \"2\"}";
    id dictObj = strJSON.strToDict();
    XCTAssertTrue([dictObj isKindOfClass:[NSDictionary class]]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
