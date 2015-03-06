//
//  AutoCompleteFetchOperation.h
//
//  Created by Matthew Ott on 3/4/15.
//

#import <Foundation/Foundation.h>
#import "AutoCompleteModel.h"

@interface AutoCompleteFetchOperation : NSOperation {
    id<AutoCompleteSearchDelegate> searchDelegate;
    NSString* searchString;
}
-(instancetype)initWithSearchString:(NSString*)searchString delegate:(id<AutoCompleteSearchDelegate>)delegate;
@end
