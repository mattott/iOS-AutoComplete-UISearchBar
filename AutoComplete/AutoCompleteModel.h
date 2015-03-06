//
//  AutoCompleteModel.h
//
//  Created by Matthew Ott on 2/23/15.
//

#import <Foundation/Foundation.h>

@protocol AutoCompleteSearchDelegate <NSObject>

-(void)onAutoCompleteResultsReceived:(NSArray*)results;

@end

@interface AutoCompleteModel : NSObject

/**
 * Stores the input into a standard NSUserDefaults dictionary. Each key is the user's input with value
 * as the number of times the user has searched for that input. This function also stores the input
 * into a standard NSUserDefaults array of most recently searched for terms.
 */
+ (void)saveInput:(NSString*)input;
/**
 * Returns a dictionary of which the keys are the user's saved inputs and the values are the
 * number of times the user has searched for the input.
 */
+ (NSDictionary*)getAutoCompleteDictionary;
/**
 * Returns an array of 3 of the most recently used inputs. The indices are in reverse chronological
 * order.
 */
+ (NSArray*)getRecentlyUsedArray;
@end
