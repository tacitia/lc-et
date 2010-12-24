//
//  My_Words_TrainerAppDelegate.h
//  My Words Trainer
//
//  Created by LIU Haixiang on 24/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class My_Words_TrainerViewController;

@interface My_Words_TrainerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    My_Words_TrainerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet My_Words_TrainerViewController *viewController;

@end

