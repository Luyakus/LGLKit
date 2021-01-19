//
//  AppDelegate.m
//  opengles-lesson-1
//
//  Created by Sam on 2020/2/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *w = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = w;
    [self.window makeKeyAndVisible];
    
    ViewController *vc = [[ViewController alloc] init];
    window.rootViewController = vc;
    return YES;
}


@end
