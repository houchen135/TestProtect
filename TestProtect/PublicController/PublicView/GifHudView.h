//
//  GifHudView.h
//  TestProtect
//
//  Created by xthink2 on 16/3/10.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GifHudView : UIView
+ (void)show;
+ (void)showWithOverlay;

+ (void)dismiss;

+ (void)setGifWithImages:(NSArray *)images;
+ (void)setGifWithImageName:(NSString *)imageName;
+ (void)setGifWithURL:(NSURL *)gifUrl;
@end
