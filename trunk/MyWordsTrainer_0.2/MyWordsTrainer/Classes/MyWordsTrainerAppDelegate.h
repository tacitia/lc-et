//
//  MyWordsTrainerAppDelegate.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UVTRootViewController.h"

@interface MyWordsTrainerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MainViewController* mainViewController;
//	UINavigationController* uvtNavigationController;
	//	UITabBarController* rootViewController;
	//	UVTRootViewController* uvtRootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController* mainViewController; 
//@property (nonatomic, retain) IBOutlet UINavigationController* uvtNavigationController;
//@property (nonatomic, retain) IBOutlet UITabBarController* rootViewController;
//@property (nonatomic, retain) IBOutlet UVTRootViewController* uvtRootViewController;

@end

