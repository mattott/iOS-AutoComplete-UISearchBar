# iOS-AutoComplete-UISearchBar

## Usage:
<ol>
<li>Add all files in AutoComplete to your project.</li>
<li>Add UISearchBar to your NIB, show identity inspector, change custom class to "AutoCompleteSearchBar"</li>
<li>In your UIViewController, conform to the UISearchBarDelegate.</li>
<li>In your UIViewController.m, implement "searchBar:textDidChange:" and "searchBarCancelButtonClicked:"</li>
</ol>
```objective-c
- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchString {
    [searchBar reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar*)searchBar {
    [searchBar hideAutoCompleteView];
}
```
