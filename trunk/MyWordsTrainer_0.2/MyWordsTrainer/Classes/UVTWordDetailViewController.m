//
//  UVTWordDetailViewController.m
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import "UVTWordDetailViewController.h"

@implementation UVTWordDetailViewController


@synthesize wordMeaningView;
@synthesize wordUsageView;
@synthesize wordQuestionView;
@synthesize selectedUVTWord;
@synthesize selectedWordView;

- (void) handleRightSwipeFrom:(UISwipeGestureRecognizer*)gestureRecognizer {
	
	if (selectedWordView == Meaning) return;
	switch (selectedWordView) {
		case Usage:
			[UIView transitionFromView:wordUsageView toView:wordMeaningView duration:1.0 
							   options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
			selectedWordView = Meaning;
			wordUsageView.hidden = YES;
			wordMeaningView.hidden = NO;
			break;
		case Question:
			[UIView transitionFromView:wordQuestionView toView:wordUsageView duration:1.0 
							   options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
			selectedWordView = Usage;
			wordQuestionView.hidden = YES;
			wordUsageView.hidden = NO;
			break;
		default:
			break;
	}
	
}

- (void) handleLeftSwipeFrom:(UISwipeGestureRecognizer*)gestureRecognizer {
	
	if (selectedWordView == Question) return;
	switch (selectedWordView) {
		case Meaning:
			[UIView transitionFromView:wordMeaningView toView:wordUsageView duration:1.0 
							   options:UIViewAnimationOptionTransitionFlipFromRight completion:NULL];
			selectedWordView = Usage;
			wordMeaningView.hidden = YES;
			wordUsageView.hidden = NO;
			break;
		case Usage:
			[UIView transitionFromView:wordUsageView toView:wordQuestionView duration:1.0 
							   options:UIViewAnimationOptionTransitionFlipFromRight completion:NULL];
			selectedWordView = Question;
			wordUsageView.hidden = YES;
			wordQuestionView.hidden = NO;
			//[wordUsageView removeFromSuperview];
			break;
		default:
			break;
	}
}

- (void) initMeaning {
	NSString* textToDisplay = @"<table border = \"0\">";
	NSArray* meanings = [selectedUVTWord.meanings allKeys];
	for (NSString* meaning in meanings) {
		NSString* meaningType = [selectedUVTWord.meanings objectForKey:meaning];
		textToDisplay = [textToDisplay stringByAppendingString:@"<tr><td>"];
		textToDisplay = [textToDisplay stringByAppendingString:meaningType];
		textToDisplay = [textToDisplay stringByAppendingString:@"</td><td>"];
		textToDisplay = [textToDisplay stringByAppendingString:meaning];
		textToDisplay = [textToDisplay stringByAppendingString:@"</td></tr>"];
	}
	NSString* temp = @"</table>";
	textToDisplay = [textToDisplay stringByAppendingString:temp];
	NSLog(@"what!!");
	[wordMeaningView loadData:[textToDisplay dataUsingEncoding:NSUnicodeStringEncoding] MIMEType: @"text/html" textEncodingName:@"UTF-16" baseURL:[[NSURL alloc] initWithString: @""]];	
}

- (void) initUsage {
	NSString* textToDisplay = @"<table border = \"0\">";
	NSArray* usages = [selectedUVTWord.usages allKeys];
	for (NSString* usage in usages) {
		NSString* usageType = [selectedUVTWord.usages objectForKey:usage];
		textToDisplay = [textToDisplay stringByAppendingString:@"<tr><td>"];
		textToDisplay = [textToDisplay stringByAppendingString:usageType];
		textToDisplay = [textToDisplay stringByAppendingString:@"</td><td>"];
		textToDisplay = [textToDisplay stringByAppendingString:usage];
		textToDisplay = [textToDisplay stringByAppendingString:@"</td></tr>"];
	}
	NSString* temp = @"</table>";
	textToDisplay = [textToDisplay stringByAppendingString:temp];
	NSLog(@"what!!");
	[wordUsageView loadData:[textToDisplay dataUsingEncoding:NSUnicodeStringEncoding] MIMEType: @"text/html" textEncodingName:@"UTF-16" baseURL:[[NSURL alloc] initWithString: @""]];	
}

- (void) initQuestion {
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	UISwipeGestureRecognizer* leftToRightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
																   initWithTarget:self
																   action:@selector(handleRightSwipeFrom:)];
	leftToRightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
	leftToRightSwipeGestureRecognizer.numberOfTouchesRequired = 1;
	
	UISwipeGestureRecognizer* rightToLeftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
																   initWithTarget:self
																   action:@selector(handleLeftSwipeFrom:)];
	rightToLeftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	rightToLeftSwipeGestureRecognizer.numberOfTouchesRequired = 1;
	
	[self.view addGestureRecognizer:leftToRightSwipeGestureRecognizer];
	[self.view addGestureRecognizer:rightToLeftSwipeGestureRecognizer];
	[leftToRightSwipeGestureRecognizer release];
	[rightToLeftSwipeGestureRecognizer release];
	
	//[self.view addSubview:self.wordMeaningView];
	self.selectedWordView = Meaning;
	self.wordUsageView.hidden = YES;
	self.wordQuestionView.hidden = YES;
}



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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
