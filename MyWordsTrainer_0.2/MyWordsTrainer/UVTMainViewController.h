//
//  UVTMainViewController.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 04/01/2011.
//  Copyright 2011 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UVTRootViewController.h"

@interface UVTMainViewController : UIViewController {
	UVTRootViewController* uvtRootViewController;
	UINavigationController* uvtNavigationController;	
}

@property (nonatomic, retain) UVTRootViewController* uvtRootViewController;
@property (nonatomic, retain) UINavigationController* uvtNavigationController;

@end
