//
//  AutoCompleteSearchBar.h
//
//  Created by Matthew Ott on 2/27/15.
//

#import <UIKit/UIKit.h>
#import "AutoCompleteFetchOperation.h"

@interface AutoCompleteSearchBar : UISearchBar<AutoCompleteSearchDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSArray* autoCompleteResults;
    UIGestureRecognizer* tapGestureRecognizer;
}

@property (strong, readwrite) UITableView *autoCompleteTableView;
@property NSOperationQueue* operationQueue;

- (void)reloadData;
- (void)hideAutoCompleteView;
@end
