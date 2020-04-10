//
//  AppDelegate.m
//  opengles-lesson-review
//
//  Created by Sam on 2020/3/24.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FilterController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *w = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = w;
    [self.window makeKeyAndVisible];
    
    FilterController *vc = [[FilterController alloc] init];
    window.rootViewController = vc;
       
    return YES;
}


#pragma mark - UISceneSession lifecycle

@end
