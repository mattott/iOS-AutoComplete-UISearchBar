//
//  AutoCompleteModelTest.m
//
//  Created by Matthew on 2/24/15.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AutoCompleteModel.h"

@interface AutoCompleteModelTest : XCTestCase

@end

@implementation AutoCompleteModelTest

- (void)setUp {
    NSString* bundleString = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:bundleString];
}

- (void)testCountIncrement_whenValueAddedMultipleTimes {
    NSString* input = @"test.com";
    
    // Verify that the autocomplete dictionary doesn't contain the value.
    NSDictionary* dictionary = [AutoCompleteModel getAutoCompleteDictionary];
    
    [AutoCompleteModel saveInput:input];
    dictionary = [AutoCompleteModel getAutoCompleteDictionary];
    XCTAssertEqual(1, [[dictionary valueForKey:input]intValue]);
    [AutoCompleteModel saveInput:input];
    dictionary = [AutoCompleteModel getAutoCompleteDictionary];
    XCTAssertEqual(2, [[dictionary valueForKey:input]intValue]);
    [AutoCompleteModel saveInput:input];
    dictionary = [AutoCompleteModel getAutoCompleteDictionary];
    XCTAssertEqual(3, [[dictionary valueForKey:input]intValue]);
}

- (void)testRecentlyUsed {
    NSString* input1 = @"test1.com";
    NSString* input2 = @"test2.com";
    NSString* input3 = @"test3.com";
    NSString* input4 = @"test4.com";

    // Verify that the contents of the recently used array are empty.
    NSArray* recentlyUsed = [AutoCompleteModel getRecentlyUsedArray];
    XCTAssertEqual(0, [recentlyUsed count]);
    
    [AutoCompleteModel saveInput:input1];
    
    recentlyUsed = [AutoCompleteModel getRecentlyUsedArray];
    XCTAssertEqual(1, [recentlyUsed count]);
    XCTAssertEqualObjects(input1, recentlyUsed[0]);
    
    [AutoCompleteModel saveInput:input2];
    
    recentlyUsed = [AutoCompleteModel getRecentlyUsedArray];
    XCTAssertEqual(2, [recentlyUsed count]);
    XCTAssertEqualObjects(input1, recentlyUsed[0]);
    XCTAssertEqualObjects(input2, recentlyUsed[1]);
    
    [AutoCompleteModel saveInput:input3];

    recentlyUsed = [AutoCompleteModel getRecentlyUsedArray];
    XCTAssertEqual(3, [recentlyUsed count]);
    XCTAssertEqualObjects(input1, recentlyUsed[0]);
    XCTAssertEqualObjects(input2, recentlyUsed[1]);
    XCTAssertEqualObjects(input3, recentlyUsed[2]);
    
    [AutoCompleteModel saveInput:input4];
    
    recentlyUsed = [AutoCompleteModel getRecentlyUsedArray];
    XCTAssertEqual(3, [recentlyUsed count]);
    XCTAssertEqualObjects(input2, recentlyUsed[0]);
    XCTAssertEqualObjects(input3, recentlyUsed[1]);
    XCTAssertEqualObjects(input4, recentlyUsed[2]);
}

@end
