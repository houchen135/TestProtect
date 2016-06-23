//
//  RootTabBarViewController.m
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//
#import "HeaderMacroDefinition.h"
#import "RootTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "GuidanceView.h"
@interface RootTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"isFirstStar"]){
        //创建引导页
        [self createGuidanceView];
    }else{
        
    }
    [self creatUi];
    // Do any additional setup after loading the view.
}
- (void)creatUi
{
    NSMutableArray *itemArray = [[NSMutableArray alloc]init];
    FirstViewController *first =[[FirstViewController alloc]init];
    first.tabBarItem.title = LanguageAdaptation(@"0");
    first.tabBarItem.image =[[UIImage imageNamed:@"First"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    first.tabBarItem.selectedImage =[[UIImage imageNamed:@"FirstSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *firstNav =[[UINavigationController alloc]initWithRootViewController:first];
    
    
    SecondViewController *second =[[SecondViewController alloc]init];
    second.tabBarItem.title = LanguageAdaptation(@"1");
    second.tabBarItem.image =[[UIImage imageNamed:@"collect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    second.tabBarItem.selectedImage =[[UIImage imageNamed:@"collectSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *secondNav =[[UINavigationController alloc]initWithRootViewController:second];
    
    
    ThirdViewController *third =[[ThirdViewController alloc]init];
    third.tabBarItem.title =LanguageAdaptation(@"2");
    third.tabBarItem.image =[[UIImage imageNamed:@"Shop"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    third.tabBarItem.selectedImage =[[UIImage imageNamed:@"ShopSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *thirdNav =[[UINavigationController alloc]initWithRootViewController:third];
    
    FourthViewController *fourth = [[FourthViewController alloc]init];
    fourth.tabBarItem.title = LanguageAdaptation(@"3");
    fourth.tabBarItem.image =[[UIImage imageNamed:@"presonSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourth.tabBarItem.selectedImage =[[UIImage imageNamed:@"preson"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *fourthNav =[[UINavigationController alloc]initWithRootViewController:fourth];
    [itemArray addObject:firstNav];
    [itemArray addObject:secondNav];
    [itemArray addObject:thirdNav];
    [itemArray addObject:fourthNav];
    self.viewControllers = itemArray;
    
}
- (void)createGuidanceView{
    GuidanceView *gudanV =[[GuidanceView alloc]initWithFrame:CGRectMake(0,0,WIDTH(WINDOW), HEIGHT(WINDOW))];
    [self.view addSubview:gudanV];
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
