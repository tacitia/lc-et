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

	UITextView* wordDetailTextView;
	UISegmentedControl* meaningUsageSegmentedControl;
	UVTWord* selectedUVTWord;
}

@property (nonatomic, retain) IBOutlet UITextView* wordDetailTextView;
@property (nonatomic, retain) IBOutlet UISegmentedControl* meaningUsageSegmentedControl;
@property (nonatomic, retain) UVTWord* selectedUVTWord;

- (IBAction) segmentedControlIndexChanged;

@end
