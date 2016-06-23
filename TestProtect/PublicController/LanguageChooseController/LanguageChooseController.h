//
//  LanguageChooseController.h
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//



// *************国际化多语言控制器***********




#import <Foundation/Foundation.h>

@interface LanguageChooseController : NSObject
+(NSBundle *)bundle;//获取当前资源文件
+(void)initUserLanguage;//初始化语言文件
+(NSString *)userLanguage;//获取应用当前语言
+(void)setUserlanguage:(NSString *)language;//设置当前语言
@end
