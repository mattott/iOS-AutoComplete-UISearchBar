//
//  AutoCompleteSearchBarTest.m
//
//  Created by Matthew Ott on 3/4/15.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AutoCompleteSearchBar.h"

@interface AutoCompleteSearchBarTest : XCTestCase
@property UIView* superView;
@property AutoCompleteSearchBar* searchBar;
@end

@implementation AutoCompleteSearchBarTest

- (void)setUp {
    [super setUp];
    _superView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 500, 500)];
    _searchBar = [[AutoCompleteSearchBar alloc]init];
    [_superView addSubview:_searchBar];
    [_superView layoutSubviews];
}

- (void)testShowTableWhenResultsReceived {
    [_searchBar onAutoCompleteResultsReceived:@[@"test.com"]];
    XCTAssertFalse(_searchBar.autoCompleteTableView.hidden);
    XCTAssertEqualObjects(_searchBar.autoCompleteTableView.superview, _superView);
}

- (void)testHideTableWhenNoResultsReceived {
    [_searchBar onAutoCompleteResultsReceived:@[]];
    XCTAssertTrue(_searchBar.autoCompleteTableView.hidden);
    XCTAssertNil(_searchBar.autoCompleteTableView.superview);
}

- (void)testSubmitFetchOperationOnUpdateResults {
    XCTAssertEqual(_searchBar.operationQueue.operationCount, 0);
    [_searchBar reloadData];
    XCTAssertEqual(_searchBar.operationQueue.operationCount, 1);
    XCTAssertTrue([_searchBar.operationQueue.operations[0] isKindOfClass:[AutoCompleteFetchOperation class]]);
}

- (void)testAutoCompleteTableCells {
    [_searchBar onAutoCompleteResultsReceived:@[@"test.com"]];
    UITableViewCell* cell = [_searchBar tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    XCTAssertEqualObjects(cell.textLabel.text, @"test.com");
    XCTAssertEqualObjects(cell.accessibilityLabel, @"{0,0}");
}

@end
