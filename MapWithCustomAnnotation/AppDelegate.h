//
//  AppDelegate.h
//  MapWithCustomAnnotation
//
//  Created by Bindu on 03/05/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) UINavigationController *mainNavigationController;
@end

