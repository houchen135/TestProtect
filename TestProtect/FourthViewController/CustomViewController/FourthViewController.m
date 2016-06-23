//
//  FourthViewController.m
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//
#import "AppDelegate.h"
#import "FourthViewController.h"
#import "LanguageChooseController.h"
@interface FourthViewController ()<UIApplicationDelegate>

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:LanguageAdaptation(@"3Title")];
    UILabel *language =[[UILabel alloc]initWithFrame:CGRectMake(30, 20, 200, 40)];
    language.text =LanguageAdaptation(@"语言");
    language.textColor =[UIColor blackColor];
    [self.view addSubview:language];
    
    
    UIButton *ChineseS =[UIButton buttonWithType:UIButtonTypeCustom];
    ChineseS.frame =CGRectMake(50, 120, 150, 30);
    ChineseS.tintColor =[UIColor cyanColor];
    ChineseS.backgroundColor =[UIColor greenColor];
    [ChineseS setTitle:@"简体中文" forState:UIControlStateNormal];
    ChineseS.tag = 55;
    [self.view addSubview:ChineseS];
    UIButton *English =[UIButton buttonWithType:UIButtonTypeCustom];
    English.frame =CGRectMake(50, 180, 150, 30);
    English.tintColor =[UIColor cyanColor];
    English.backgroundColor =[UIColor greenColor];
    [English setTitle:@"英文" forState:UIControlStateNormal];
    English.tag = 56;
    [self.view addSubview:English];
    UIButton *Chineset =[UIButton buttonWithType:UIButtonTypeCustom];
    Chineset.frame =CGRectMake(50, 240, 150, 30);
    Chineset.tintColor =[UIColor cyanColor];
    Chineset.backgroundColor =[UIColor greenColor];
    [Chineset setTitle:@"繁体中文" forState:UIControlStateNormal];
    Chineset.tag = 57;
    [self.view addSubview:Chineset];
    [ChineseS addTarget:self action:@selector(chooseLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [Chineset addTarget:self action:@selector(chooseLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [English addTarget:self action:@selector(chooseLanguage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)chooseLanguage:(UIButton *)sender
{
    if (sender.tag ==55) {
        [LanguageChooseController setUserlanguage:@"zh-Hans"];
    }else if (sender.tag ==56){
        [LanguageChooseController setUserlanguage:@"en"];
    }else{
        [LanguageChooseController setUserlanguage:@"zh-Hant"];
    }
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app setRoootControllerByTabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
