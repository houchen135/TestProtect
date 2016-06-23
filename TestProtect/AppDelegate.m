//
//  AppDelegate.m
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "LanguageChooseController.h"
#import "NewRootViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>
//@property (nonatomic,strong)RootTabBarController *MyTabBar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // 设定软件语言
    [LanguageChooseController initUserLanguage];
    
    
    //  设置根视图
    [self setRoootControllerByTabBarController];
    return YES;
}
#pragma mark - 设置TableBarControler 为RootController
- (void)setRoootControllerByTabBarController{
    // 自定义tabBar 在tabBar内加引导页
//    RootTabBarController *MyTabBar = [[RootTabBarController alloc]init];
//    MyTabBar.tabBar.tintColor = [ UIColor redColor];
//    MyTabBar.selectedIndex = 0;
//    self.window.rootViewController = MyTabBar;
    
    NewRootViewController *MyTabBar =[[NewRootViewController alloc]init];
    MyTabBar.selectedIndex =0;
    self.window.rootViewController =MyTabBar;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
