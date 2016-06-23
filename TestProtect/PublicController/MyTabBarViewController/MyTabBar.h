//
//  MyTabBar.h
//  TestProtect
//
//  Created by xthink2 on 16/4/20.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBar;

#pragma mark-- ZTTabBar继承自UITabBar，所以ZTTabBar的代理必须遵循UITabBar的代理协议！
@protocol MyTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(MyTabBar *)tabBar;

@end
@interface MyTabBar : UITabBar
@property (nonatomic, weak) id<MyTabBarDelegate> delegate;
@end
