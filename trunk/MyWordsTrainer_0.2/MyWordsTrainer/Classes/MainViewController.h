//
//  MainViewController.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 03/01/2011.
//  Copyright 2011 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UVTRootViewController.h"


@interface MainViewController : UIViewController {
	UIButton* uvtButton;
}

@property (nonatomic, retain) IBOutlet UIButton* uvtButton;


- (IBAction) uvtButtonClicked;

@end
