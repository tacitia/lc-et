//
//  UVTWordDetailViewController.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UVTWord.h"

@interface UVTWordDetailViewController : UIViewController {

	UIWebView* wordDetailTextView;
	UISegmentedControl* meaningUsageSegmentedControl;
	UVTWord* selectedUVTWord;
}

@property (nonatomic, retain) IBOutlet UIWebView* wordDetailTextView;
@property (nonatomic, retain) IBOutlet UISegmentedControl* meaningUsageSegmentedControl;
@property (nonatomic, retain) UVTWord* selectedUVTWord;

- (IBAction) segmentedControlIndexChanged;

@end
