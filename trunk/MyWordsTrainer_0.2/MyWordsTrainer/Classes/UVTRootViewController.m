//
//  UVTRootViewController.m
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#include<stdlib.h>

#import "UVTRootViewController.h"
#import "UVTWord.h"


@implementation UVTRootViewController
@synthesize words;
@synthesize uvtWordDetailViewController;
@synthesize wordSearchBar;


#pragma mark Table Management

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	UVTWord* selectedUVTWord = nil;
	
	if (searching) {
		selectedUVTWord = [copyOfWords objectAtIndex:indexPath.row];
	}
	else {
		selectedUVTWord = [words objectAtIndex:indexPath.row];
	}
	
	[self displayWordDetailView:selectedUVTWord];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return [words count];
};

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
	static NSString* CellIdentifier = @"Cell";
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	UVTWord* selectedUVTWord = nil;
	if (searching) {
		selectedUVTWord = [copyOfWords objectAtIndex:indexPath.row];
	}
	else {
		selectedUVTWord = [words objectAtIndex:indexPath.row];
	}
	cell.textLabel.text = selectedUVTWord.word;	

	
	return cell;
}

- (NSIndexPath*)tableView:(UITableView*)theTableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	if (letUserSelectRow) {
		return indexPath;
	}
	else {
		return nil;
	}

}

#pragma mark Search Bar Management

- (void) searchBarTextDidBeginEditing:(UISearchBar*)theSearchBar {
	searching = YES;
	letUserSelectRow = NO;
	self.tableView.scrollEnabled = NO;
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
											   target:self
											   action:@selector(doneSearching_Clicked:)] autorelease];
}


- (void)searchBar:(UISearchBar*)theSearchBar textDidChange:(NSString*)searchText{
	
	[copyOfWords removeAllObjects];
	
	if([searchText length] > 0) {
		searching = YES;
		letUserSelectRow = YES;
		self.tableView.scrollEnabled = YES;
		[self searchTableView];
	}
	else {
		searching = NO;
		letUserSelectRow = NO;
		self.tableView.scrollEnabled = NO;
	}
	
	[self.tableView	reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar*)theSearchBar {
	[self searchTableView];
}

- (void) searchTableView {
	NSString* searchText = wordSearchBar.text;
		
	for (NSString* word in words) {
		NSRange titleResultsRange = [word rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0)
			[copyOfWords addObject:word];
	}
	
}

- (void) doneSearching_Clicked:(id)sender {
	
	wordSearchBar.text = @"";
	[wordSearchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	self.tableView.scrollEnabled = YES;
	
	[self.tableView reloadData];
}


#pragma mark Database Management

- (void) checkAndCreateDatabase {
	BOOL success;
	
	NSFileManager* fileManager = [NSFileManager defaultManager];
	
	//[fileManager delete:databasePath];
	
	success = [fileManager fileExistsAtPath:databasePath];
	
	if (success){
		printf("dawawa");
		return;
	}
	
	NSString* databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	[fileManager release];
}

- (void) readWordsFromDatabase {
	words = [[NSMutableArray alloc] init];
	
	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		const char* selectWordStmt = "select distinct Word from uvtWordMeaning";
		sqlite3_stmt* compiledSelectWordStmt;
		int returnV = sqlite3_prepare_v2(database, selectWordStmt, -1, &compiledSelectWordStmt, NULL); 
		//printf("%i",returnV);
		//printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		if (returnV == SQLITE_OK) {
			while (sqlite3_step(compiledSelectWordStmt) == SQLITE_ROW) {
				NSString* theWord = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectWordStmt, 0)];
				NSMutableDictionary* theMeanings = [NSMutableDictionary dictionary];
				NSMutableDictionary* theUsages = [NSMutableDictionary dictionary];
				
				NSString* selectMeaningsStmtString = @"select MeaningType, Meaning from uvtWordMeaning where Word = \"";
				selectMeaningsStmtString = [selectMeaningsStmtString stringByAppendingString:theWord];
				selectMeaningsStmtString = [selectMeaningsStmtString stringByAppendingString:@"\""];
				const char* selectMeaningsStmt = [selectMeaningsStmtString UTF8String];
				
				sqlite3_stmt* compiledSelectMeaningsStmt;
				sqlite3_prepare_v2(database, selectMeaningsStmt, -1, &compiledSelectMeaningsStmt, NULL);
				//printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 

				while (sqlite3_step(compiledSelectMeaningsStmt) == SQLITE_ROW) {
					NSString* theMeaningType = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectMeaningsStmt, 0)];
					NSString* theMeaning = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectMeaningsStmt, 1)];
					[theMeanings setObject:theMeaningType forKey:theMeaning];
				}
				
				
				NSString* selectUsagesStmtString = @"select UsageType, Usage from uvtWordUsage where Word = \"";
				selectUsagesStmtString = [selectUsagesStmtString stringByAppendingString:theWord];
				selectUsagesStmtString = [selectUsagesStmtString stringByAppendingString:@"\""];
				const char* selectUsagesStmt = [selectUsagesStmtString UTF8String];
				
				sqlite3_stmt* compiledSelectUsagesStmt;
				sqlite3_prepare_v2(database, selectUsagesStmt, -1, &compiledSelectUsagesStmt, NULL);
				//printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
				
				while (sqlite3_step(compiledSelectUsagesStmt) == SQLITE_ROW) {
					NSString* theUsageType = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectUsagesStmt, 0)];
					NSString* theUsage = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectUsagesStmt, 1)];
					[theUsages setObject:theUsageType forKey:theUsage];
				}
								
				UVTWord* theUVTWord = [[UVTWord alloc] initWithWord:theWord meanings:theMeanings usages:theUsages];
				[words addObject:theUVTWord];
				[theUVTWord release];
			}
		}
		sqlite3_finalize(compiledSelectWordStmt);
	}
//	sqlite3_close(database);
}


- (void) helpButtonClicked {
	
}

#pragma mark View Management

- (void)viewDidLoad {
	[super viewDidLoad];
	
	databaseName = @"uvtDatabase.sqlite";
	
	NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	NSLog(databasePath);
	
	[self checkAndCreateDatabase];
	[self readWordsFromDatabase];
		
	copyOfWords = [[NSMutableArray alloc] init];

	//self.navigationItem.title = @"";

	UIBarButtonItem* helpButton = [[UIBarButtonItem alloc]
							 initWithTitle:@"Help"
									style:UIBarButtonItemStyleBordered
									target:self
									action:@selector(helpButtonClicked)];
	self.navigationItem.rightBarButtonItem = helpButton;
	
	self.tableView.tableHeaderView = wordSearchBar;
	wordSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	
	searching = NO;
	letUserSelectRow = YES;
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[self becomeFirstResponder];
	[super viewDidAppear:animated];
}

- (NSMutableArray*)generateTopTenUnfamiliarWords {
	NSMutableArray* topTenWords = [[NSMutableArray alloc] init];
	printf("###");
//	int returnValue = sqlite3_open([databasePath UTF8String], &database);
//	printf("%i", returnValue);
//	printf("tried open database: %s\n", sqlite3_errmsg(database));
	
//	if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		printf("$$$");
		const char* selectMostUnfamiliarWordsStmt = "select * from uvtUserStat order by Score desc limit 10";
		sqlite3_stmt* compiledSelectMostUnfamiliarWordsStmt;
		int returnV = sqlite3_prepare_v2(database, selectMostUnfamiliarWordsStmt, -1, &compiledSelectMostUnfamiliarWordsStmt, NULL);
		printf("%i", returnV);
		printf("could not prepare statement:%s\n", sqlite3_errmsg(database));
		if (returnV == SQLITE_OK) {
			while (sqlite3_step(compiledSelectMostUnfamiliarWordsStmt) == SQLITE_ROW) {
				NSString* theWord = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectMostUnfamiliarWordsStmt, 0)];
				NSMutableDictionary* theMeanings = [NSMutableDictionary dictionary];
				NSMutableDictionary* theUsages = [NSMutableDictionary dictionary];
				
				NSString* selectMeaningsStmtString = @"select MeaningType, Meaning from uvtWordMeaning where Word = \"";
				selectMeaningsStmtString = [selectMeaningsStmtString stringByAppendingString:theWord];
				selectMeaningsStmtString = [selectMeaningsStmtString stringByAppendingString:@"\""];
				const char* selectMeaningsStmt = [selectMeaningsStmtString UTF8String];
				
				sqlite3_stmt* compiledSelectMeaningsStmt;
				sqlite3_prepare_v2(database, selectMeaningsStmt, -1, &compiledSelectMeaningsStmt, NULL);
				printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
				
				while (sqlite3_step(compiledSelectMeaningsStmt) == SQLITE_ROW) {
					NSString* theMeaningType = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectMeaningsStmt, 0)];
					NSString* theMeaning = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectMeaningsStmt, 1)];
					[theMeanings setObject:theMeaningType forKey:theMeaning];
				}
				
				
				NSString* selectUsagesStmtString = @"select UsageType, Usage from uvtWordUsage where Word = \"";
				selectUsagesStmtString = [selectUsagesStmtString stringByAppendingString:theWord];
				selectUsagesStmtString = [selectUsagesStmtString stringByAppendingString:@"\""];
				const char* selectUsagesStmt = [selectUsagesStmtString UTF8String];
				
				sqlite3_stmt* compiledSelectUsagesStmt;
				sqlite3_prepare_v2(database, selectUsagesStmt, -1, &compiledSelectUsagesStmt, NULL);
				printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
				
				while (sqlite3_step(compiledSelectUsagesStmt) == SQLITE_ROW) {
					NSString* theUsageType = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectUsagesStmt, 0)];
					NSString* theUsage = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledSelectUsagesStmt, 1)];
					[theUsages setObject:theUsageType forKey:theUsage];
				}
				
				UVTWord* theUVTWord = [[UVTWord alloc] initWithWord:theWord meanings:theMeanings usages:theUsages];
				[topTenWords addObject:theUVTWord];
				[theUVTWord release];
			}
			
		}
		sqlite3_finalize(compiledSelectMostUnfamiliarWordsStmt);
//	}
//	sqlite3_close(database);
	
	return topTenWords;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event {
	if (motion == UIEventSubtypeMotionShake) {
		printf("!!!");
		NSMutableArray* topTenWords = [self generateTopTenUnfamiliarWords];
		printf("???");
		int wordIndex = arc4random() % 10;
		[self displayWordDetailView:[topTenWords objectAtIndex:wordIndex]];
	}
	return;
}


- (void)displayWordDetailView:(UVTWord*)selectedUVTWord {
	if (self.uvtWordDetailViewController == nil) {
		UVTWordDetailViewController* tempViewController = [[UVTWordDetailViewController alloc] initWithNibName:@"UVTWordDetailViewController" bundle:[NSBundle mainBundle]];
		self.uvtWordDetailViewController = tempViewController;
		[tempViewController release];
	}
	
	[self.navigationController pushViewController:uvtWordDetailViewController animated:YES];
	self.uvtWordDetailViewController.title = selectedUVTWord.word;
	self.uvtWordDetailViewController.selectedUVTWord = [[UVTWord alloc] initWithWord:selectedUVTWord.word 
																			meanings:selectedUVTWord.meanings
																			  usages:selectedUVTWord.usages];
	[self.uvtWordDetailViewController initMeaning];
	[self.uvtWordDetailViewController initUsage];
	[self.uvtWordDetailViewController initQuestion];
	
}

- (void)updateWord:(NSString*)word scoreChange:(NSInteger)change {
}



- (void)dealloc {
	[words release];
	[wordSearchBar release];
    [super dealloc];
}


@end
