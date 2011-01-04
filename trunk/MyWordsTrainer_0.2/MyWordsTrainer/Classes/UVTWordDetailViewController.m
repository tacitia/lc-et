    //
//  UVTWordDetailViewController.m
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import "UVTWordDetailViewController.h"

@implementation UVTWordDetailViewController


@synthesize wordDetailTextView;
@synthesize meaningUsageSegmentedControl;
@synthesize selectedUVTWord;


- (IBAction) segmentedControlIndexChanged{
	switch (self.meaningUsageSegmentedControl.selectedSegmentIndex) {
		case 0: {
			NSString* textToDisplay = @"";
			NSArray* meanings = [selectedUVTWord.meanings allKeys];
			for (NSString* meaning in meanings) {
				NSString* meaningType = [selectedUVTWord.meanings objectForKey:meaning];
				textToDisplay = [textToDisplay stringByAppendingString:meaningType];
				textToDisplay = [textToDisplay stringByAppendingString:meaning];
				printf("!!!");
				printf(&textToDisplay);
			}
			wordDetailTextView.text = textToDisplay;
			break;
		}
		case 1: {
			NSString* textToDisplay = @"";
			NSArray* usages = [selectedUVTWord.usages allKeys];
			for (NSString* usage in usages) {
				NSString* usageType = [selectedUVTWord.usages objectForKey:usage];
				textToDisplay = [textToDisplay stringByAppendingString:usageType];
				textToDisplay = [textToDisplay stringByAppendingString:usage];
			}
			wordDetailTextView.text = textToDisplay;
			break;
		}
		default:
			break;
	}
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	NSLog(selectedUVTWord.word);
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[wordDetailTextView release];
	[meaningUsageSegmentedControl release];
    [super dealloc];
}


@end
