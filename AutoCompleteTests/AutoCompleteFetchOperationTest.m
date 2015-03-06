//
//  AutoCompleteFetchOperationTest.m
//
//  Created by Matthew on 3/4/15.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AutoCompleteFetchOperation.h"

@interface TestingAutoCompleteSearchDelegate : NSObject<AutoCompleteSearchDelegate>
@property NSArray* results;
@property (copy) void(^expectationHandler)(NSArray*);
@end

@interface AutoCompleteFetchOperationTest : XCTestCase
@property AutoCompleteFetchOperation* fetchOperation;
@property TestingAutoCompleteSearchDelegate* searchDelegate;
@end

@implementation TestingAutoCompleteSearchDelegate

-(instancetype)initWithExpectationHandler:(void (^)(NSArray*))expectationHandler {
    if (self = [super init]) {
        _expectationHandler = expectationHandler;
    }
    return self;
}
-(void)onAutoCompleteResultsReceived:(NSArray *)results {
    _expectationHandler(results);
}
@end

@implementation AutoCompleteFetchOperationTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Remove previously saved AutoComplete words.
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    [super tearDown];
}

- (void)testFetchArrayOfMatches {
    XCTestExpectation* operationCompletedExpectation = [self expectationWithDescription:@"AutoCompleteFetchOperation"];
    _searchDelegate = [[TestingAutoCompleteSearchDelegate alloc]initWithExpectationHandler:^(NSArray *results) {
        XCTAssertNotNil(results);
        XCTAssertEqual(results.count, 3);
        XCTAssertEqualObjects(results[0], @"test1.com");
        XCTAssertEqualObjects(results[1], @"test2.com");
        XCTAssertEqualObjects(results[2], @"test3.com");
        [operationCompletedExpectation fulfill];
    }];
    _fetchOperation = [[AutoCompleteFetchOperation alloc]initWithSearchString:@"test" delegate:_searchDelegate];

    // Prepare NSUserDefaults with inputs
    [AutoCompleteModel saveInput:@"test1.com"];
    [AutoCompleteModel saveInput:@"test2.com"];
    [AutoCompleteModel saveInput:@"test3.com"];
    
    // Run the operation
    [_fetchOperation main];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
