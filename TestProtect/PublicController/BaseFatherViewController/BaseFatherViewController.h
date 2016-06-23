//
//  BaseFatherViewController.h
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderMacroDefinition.h" //头宏定义
#import "LanguageChooseController.h"
#import <CoreLocation/CoreLocation.h>
#import "GifHudView.h"
//#import <CommonCrypto/>
@interface BaseFatherViewController : UIViewController
// 属性
@property (nonatomic,assign)CGFloat longitude;
@property (nonatomic,assign)CGFloat latitude;
// 设置导航Title
# pragma  mark - 设置导航Title
- (void)setNavigationTitle:(NSString *)title;
# pragma mark - 设置导航TitleView
- (void)setNavigationTitleView:(UIView *)titleView;
//设置导航左按钮
# pragma mark - 根据按钮Title名字 设置导航左按钮
- (void)setNavigationBarLeftBtnWitBtnTitle:(NSString *)BtnTitle;
# pragma mark - 根据按钮图片名字 设置导航左按钮
- (void)setNavigationBarLeftBtnWithImageName:(NSString *)imageStr;
#pragma mark - 导航左按钮 点击事件
- (void)NavigationBarLeftBarButtonAction:(UIButton *)tmpBarBtn;
# pragma mark - 设置导航左按钮（多个）
- (void)setNavigationBarLeftBtnsWithImageNameArr:(NSArray *)imageNameArr;
//设置导航右按钮
# pragma mark - 根据按钮Title名字 设置导航右按钮
- (void)setNavigationBarRightBtnWitBtnTitle:(NSString *)BtnTitle;
# pragma mark - 根据按钮图片名字 设置导航右按钮
- (void)setNavigationBarRightBtnWithImageName:(NSString *)imageStr;
#pragma mark - 导航右按钮 点击事件
- (void)NavigationBarRightBarButtonAction:(UIButton *)tmpBarBtn;
# pragma mark - 设置导航右按钮（多个）
- (void)setNavigationBarRightBtnsWithImageNameArr:(NSArray *)imageNameArr;

# pragma mark - 开始定位获得经纬度
- (void)getLocationMessage;
# pragma mark - 停止定位，关闭GPS
- (void)stopCLLocationManager;
# pragma mark - 根据经纬度算距离
- (NSString *)kiometresWithNewLatitude:(NSString *)newLatitude newLongitude:(NSString *)newLongitude oldLatitude:(NSString *)oldLatitude oldLongitude:(NSString *)oldLongitude;
# pragma mark - 检测当前网络状况
- (NSString *)getNetWorkStates;
# pragma  mark - 键盘弹出收回的四种状态消息
- (void)keyBoardWillShow:(NSNotification *)notification;
- (void)keyBoardDidShow:(NSNotification *)notification;
- (void)keyBoardWillHide:(NSNotification *)notification;
- (void)keyBoardDidHide:(NSNotification *)notification;
#pragma mark - 参数按首字母排序
-(NSString *)stringWithDict:(NSDictionary *)dict;
#pragma mark - 加密字符串
- (NSString *) md5:(NSString *)str;
@end
