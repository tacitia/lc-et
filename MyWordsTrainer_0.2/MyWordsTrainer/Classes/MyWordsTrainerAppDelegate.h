//
//  MyWordsTrainerAppDelegate.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UVTRootViewController.h"
#import "MainViewController.h"

@interface MyWordsTrainerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
//	MainViewController* mainViewController;
	UINavigationController* navigationController;
	
	//---TEMP---
	//UINavigationController* uvtNavigationController;
	//UITabBarController* rootViewController;
	//UVTRootViewController* uvtRootViewController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet MainViewController* mainViewController; 
@property (nonatomic, retain) IBOutlet UINavigationController* navigationController;
//@property (nonatomic, retain) IBOutlet UINavigationController* uvtNavigationController;
//@property (nonatomic, retain) IBOutlet UITabBarController* rootViewController;
//@property (nonatomic, retain) IBOutlet UVTRootViewController* uvtRootViewController;

@end

