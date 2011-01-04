//
//  UVTRootViewController.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UVTWordDetailViewController.h"
#import <sqlite3.h>


@interface UVTRootViewController : UITableViewController {
	NSMutableArray* words;
	NSMutableArray* copyOfWords;
	
	UISearchBar* wordSearchBar;
	
	BOOL searching;
	BOOL letUserSelectRow;
	
	NSString* databaseName;
	NSString* databasePath;
	
	UVTWordDetailViewController* uvtWordDetailViewController;
}

@property (nonatomic, retain) NSMutableArray* words;
@property (nonatomic, retain) UVTWordDetailViewController* uvtWordDetailViewController;

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@end
