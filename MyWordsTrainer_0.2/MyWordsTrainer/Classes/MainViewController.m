    //
//  MainViewController.m
//  MyWordsTrainer
//
//  Created by Guo Hua on 03/01/2011.
//  Copyright 2011 HKUST. All rights reserved.
//

#import "MainViewController.h"
#import "UVTRootViewController.h"

@implementation MainViewController

@synthesize uvtButton;
@synthesize uvtIntroViewController;

- (IBAction) uvtButtonClicked {
	//Display an intro view before loading the UVTRootViewController
	self.uvtIntroViewController = [[UIViewController alloc] initWithNibName:@"UVTIntroView" bundle:[NSBundle mainBundle]];
	[self.view addSubview:uvtIntroViewController.view];
	
	[NSTimer scheduledTimerWithTimeInterval:1.5 
									 target:self
								   selector:@selector(loadUVTRootViewController)
								   userInfo:nil
									repeats:NO];
}
	 
- (void) loadUVTRootViewController {
	UVTRootViewController* uvtRootViewController = [[UVTRootViewController alloc] initWithNibName:@"UVTRootViewController" bundle:[NSBundle mainBundle]];
//	[[self navigationController] setNavigationBarHidden:NO];
	[[self navigationController] pushViewController:uvtRootViewController animated:YES];
	[self.uvtIntroViewController.view removeFromSuperview];
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

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:YES animated:animated];
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	[super viewWillDisappear:animated];
}

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
