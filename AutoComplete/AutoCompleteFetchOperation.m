//
//  AutoCompleteFetchOperation.m
//
//  Created by Matthew Ott on 3/4/15.
//

#import "AutoCompleteFetchOperation.h"
#import "AutoCompleteModel.h"

@implementation AutoCompleteFetchOperation

-(instancetype)initWithSearchString:(NSString*)string delegate:(id<AutoCompleteSearchDelegate>)delegate {
    if (self = [super init]) {
        searchDelegate = delegate;
        self->searchString = string;
    }
    return self;
}

- (void)main {
    if (searchDelegate) {
        NSMutableArray* results = [@[] mutableCopy];
        // Don't bother looking up new results if the input is empty.
        if (searchString && ![@"" isEqualToString:[searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
            NSDictionary* previousInputs = [AutoCompleteModel getAutoCompleteDictionary];
            for (NSString* key in [previousInputs keyEnumerator]) {
                if (self.isCancelled) {
                    return;
                }
                if ([key hasPrefix:searchString]) {
                    [results addObject:key];
                }
            }
        }
        
        // Alphabetically sort the results.
        [results sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]]) {
                return [(NSString*)obj1 compare:(NSString*)obj2];
            } else {
                return NSOrderedSame;
            }
        }];

        [(NSObject*)searchDelegate performSelectorOnMainThread:@selector(onAutoCompleteResultsReceived:)
                                                    withObject:results
                                                 waitUntilDone:NO];
    }
}

@end
