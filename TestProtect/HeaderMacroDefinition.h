//
//  HeaderMacroDefinition.h
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//



// ****************宏定义头文件************




#ifndef HeaderMacroDefinition_h
#define HeaderMacroDefinition_h
// 屏幕尺寸以及view坐标元素获取
#define WINDOW [[UIApplication sharedApplication].delegate window]
#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define X(view) view.frame.origin.x
#define Y(view) view.frame.origin.y
// 系统版本获取
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
// 多语言获取文本
#define LanguageAdaptation(key) [[LanguageChooseController bundle]localizedStringForKey:key value:nil table:nil]
//带有RGBA的颜色设置
#define Color(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define BaseTag 100000


#endif /* HeaderMacroDefinition_h */
