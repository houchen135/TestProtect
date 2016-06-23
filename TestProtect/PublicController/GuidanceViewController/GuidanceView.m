//
//  GuidanceView.m
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "GuidanceView.h"
#import "HeaderMacroDefinition.h"
@implementation GuidanceView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor =[ UIColor whiteColor];
        self.userInteractionEnabled = YES;
//        int  screnHeight = [ UIScreen mainScreen ].bounds.size.height;
        //  4-480  5-568  5s- 568 6-667 6p- 736
//        if(screnHeight == 480){
//            imageArray = @[@"4s-01-640-960",@"4s-02-640-960",@"4s-03-640-960"];
//        }else if (screnHeight == 568){
//            imageArray = @[@"5s-01-640-1136",@"5s-02-640-1136",@"5s-03-640-1136"];
//        }else if (screnHeight == 667){
//            imageArray = @[@"6-01-750-1334",@"6-02-750-1334",@"6-03-750-1334"];
//        }else if (screnHeight == 736){
//            imageArray = @[@"6p-01-1242-2208",@"6p-02-1242-2208",@"6p-03-1242-2208"];
//        }
        
        
        
// 1
        
//        [self createScrollerView];
        
// 2
        [self goIn];
        
    }
    return self;
}
//  引导页scrollView
- (void)createScrollerView{
    
    blackScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,WIDTH(WINDOW),HEIGHT(WINDOW))];
    blackScrollView.delegate = self;
    blackScrollView.contentSize = CGSizeMake(WIDTH(WINDOW) * imageArray.count,HEIGHT(WINDOW));
    blackScrollView.pagingEnabled = YES;
    blackScrollView.showsHorizontalScrollIndicator = NO;
    blackScrollView.showsVerticalScrollIndicator = NO;
    blackScrollView.userInteractionEnabled = YES;
    
    for(int i = 0;i < imageArray.count; i++){
        
        UIImageView *guidanceImage =[[ UIImageView alloc]initWithFrame:CGRectMake(i*WIDTH(WINDOW),0,WIDTH(WINDOW),HEIGHT(WINDOW))];
        guidanceImage.userInteractionEnabled = YES;
        guidanceImage.image = [UIImage imageNamed:imageArray[i]];
        [blackScrollView addSubview:guidanceImage];
        if(i == imageArray.count - 1){
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
            [guidanceImage addGestureRecognizer:tap];
            
        }
    }
    UIPageControl *pageConteol = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH(WINDOW)/2-40,HEIGHT(WINDOW)-40,80,14)];
    pageConteol.backgroundColor=[UIColor grayColor];
    pageConteol.alpha=0.8;
    
    pageConteol.layer.masksToBounds=YES;
    pageConteol.layer.cornerRadius=7;
    pageConteol.numberOfPages = imageArray.count;//设置pageConteol 的page 和 _scrollView 上的图片一样多
    pageConteol.currentPage=0;
    pageConteol.tag = 201;
    
    [self addSubview:blackScrollView];
    [self addSubview: pageConteol];
    
    
}

// 点击进入
- (void)goIn{
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap];
    
}
-(void)imageTap:(UIGestureRecognizer *)tap
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isFirstStar"];
    [self hiddenView];
}
- (void)hiddenView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    int current = (scrollView.contentOffset.x)/WIDTH(WINDOW);
    //根据scrollView 的位置对page 的当前页赋值
    UIPageControl *page = (UIPageControl *)[self viewWithTag:201];
    page.currentPage = current;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
