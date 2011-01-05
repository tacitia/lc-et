//
//  MainViewController.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 03/01/2011.
//  Copyright 2011 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController {	
	UIButton* uvtButton;
	UIViewController* uvtIntroViewController;
//	UVTMainViewController* uvtMainViewController;
	//UINavigationController* mainNavigationController;
}

@property (nonatomic, retain) IBOutlet UIButton* uvtButton;
@property (nonatomic, retain) IBOutlet UIViewController* uvtIntroViewController;
//@property (nonatomic, retain) IBOutlet UVTMainViewController* uvtMainViewController;

- (IBAction) uvtButtonClicked;

@end
