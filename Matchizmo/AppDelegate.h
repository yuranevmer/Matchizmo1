//
//  AppDelegate.h
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) ViewController *viewController;
@property (retain, nonatomic) UITabBarController *tabBarController;

@end
