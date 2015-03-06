//
//  AutoCompleteModel.m
//
//  Created by Matthew Ott on 2/23/15.
//

#import "AutoCompleteModel.h"

static NSString* recentlyAddedKey = @"RECENTLY_ADDED_ARRAY";
static NSString* autoCompleteKey = @"AUTO_COMPLETE_DICT";
@implementation AutoCompleteModel

/**
 * Stores the input into a standard NSUserDefaults dictionary. Each key is the user's input with value
 * as the number of times the user has searched for that input. This function also stores the input
 * into a standard NSUserDefaults array of most recently searched for terms.
 */
+ (void)saveInput:(NSString*)input {
    // Don't store empty values.
    if (input == nil || [@"" isEqualToString:[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        return;
    }
    // Remove whitespaces and set to lowercase
    input = [[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    // Get the Preferences file
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // Get the "auto-complete" dictionary
    NSMutableDictionary* userInputsDictionary;
    NSDictionary* dictionary = [defaults dictionaryForKey:autoCompleteKey];
    if (dictionary) {
        userInputsDictionary = [dictionary mutableCopy];
    } else {
        userInputsDictionary = [@{} mutableCopy];
    }
    
    // Increment the value count if previously stored.
    NSNumber* updatedInputSearchedCount = @(1);
    NSObject* inputSearchedCount = [userInputsDictionary objectForKey:input];
    if ([inputSearchedCount isKindOfClass:[NSNumber class]]) {
        updatedInputSearchedCount = @([updatedInputSearchedCount intValue] + [(NSNumber*)inputSearchedCount intValue]);
    }
    [userInputsDictionary setObject:updatedInputSearchedCount forKey:input];
    // Save updated "auto-complete" dictionary to NSUserDefaults
    [defaults setObject:userInputsDictionary forKey:autoCompleteKey];
    
    // Store the value into the "most recently used" array.
    NSMutableArray* recentlyUsedArray;
    NSArray* array = [defaults arrayForKey:recentlyAddedKey];
    if (array) {
        recentlyUsedArray = [array mutableCopy];
    } else {
        recentlyUsedArray = [@[] mutableCopy];
    }
    // Remove the key from the "most recently used" array
    if ([recentlyUsedArray containsObject:input]) {
        [recentlyUsedArray removeObject:input];
        // Maintain a 3 count max.
    } else if ([recentlyUsedArray count] == 3) {
        [recentlyUsedArray removeObjectAtIndex:0];
    }
    
    // Insert the value into the first array position.
    [recentlyUsedArray addObject:input];
    // Save updated "most recently used" array to NSUserDefaults.
    [defaults setObject:recentlyUsedArray forKey:recentlyAddedKey];
    
    // Make the data persistent.
    [defaults synchronize];
}

/**
 * Returns a dictionary of which the keys are the user's saved inputs and the values are the
 * number of times the user has searched for the input.
 */
+ (NSDictionary*)getAutoCompleteDictionary {
    NSDictionary* autoCompleteDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:autoCompleteKey];
    return autoCompleteDictionary ? autoCompleteDictionary : @{};
}

/**
 * Returns an array of 3 of the most recently used inputs. The indices are in reverse chronological
 * order.
 */
+ (NSArray*)getRecentlyUsedArray {
    NSArray* recentlyUsed = [[NSUserDefaults standardUserDefaults] arrayForKey:recentlyAddedKey];
    return recentlyUsed ? recentlyUsed : @[];
}


@end
