//
//  UVTWordDetailViewController.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UVTWord.h"

typedef enum {
	Meaning = 1,
	Usage = 2,
	Question = 3
} WordView;

@interface UVTWordDetailViewController : UIViewController {
	UIWebView* wordMeaningView;
	UIWebView* wordUsageView;
	UIWebView* wordQuestionView;
	UVTWord* selectedUVTWord;
	
	WordView selectedWordView;
}

@property (nonatomic, retain) IBOutlet UIWebView* wordMeaningView;
@property (nonatomic, retain) IBOutlet UIWebView* wordUsageView;
@property (nonatomic, retain) IBOutlet UIWebView* wordQuestionView;
@property (nonatomic, retain) UVTWord* selectedUVTWord;
@property (nonatomic) WordView selectedWordView;
//- (IBAction) segmentedControlIndexChanged;

- (void)initMeaning;
- (void)initUsage;
- (void)initQuestion;

@end
