//
//  AppDelegate.m
//  Demo
//
//  Created by lyz1 on 2018/11/8.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "AppDelegate.h"
#import "featureView/FeatureView.h"

@interface AppDelegate ()
@property (nonatomic,strong)FeatureView *launchView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    //Feature 界面：
    self.window.rootViewController.view.hidden = YES;
    _launchView = [[FeatureView alloc] initWithFrame:self.window.frame];
    [self.window addSubview:_launchView];
    
    __weak typeof(self) weakSelf = self;
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{     
        [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [weakSelf.launchView removeFromSuperview];
            weakSelf.window.rootViewController.view.hidden = NO;

        } completion:nil];
       
    });
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end