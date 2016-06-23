//
//  GuidanceView.h
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//





// ****************引导页**************//






#import <UIKit/UIKit.h>

@interface GuidanceView : UIView<UIScrollViewDelegate>{
    UIScrollView *blackScrollView;
    NSArray *imageArray;
}
- (id)initWithFrame:(CGRect)frame;
@end
