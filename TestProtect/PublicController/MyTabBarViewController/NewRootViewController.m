//
//  NewRootViewController.m
//  TestProtect
//
//  Created by xthink2 on 16/4/20.
//  Copyright © 2016年 xthink2. All rights reserved.
//
#import "HeaderMacroDefinition.h"
#import "NewRootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "GuidanceView.h"
#import "MyTabBar.h"
@interface NewRootViewController ()<MyTabBarDelegate,UITabBarControllerDelegate>

@end

@implementation NewRootViewController

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
- (void)creatUi{
    [self addChildVc:[[FirstViewController alloc] init] title:LanguageAdaptation(@"0") image:@"First" selectedImage:@"FirstSelect"];
    [self addChildVc:[[SecondViewController alloc] init] title:LanguageAdaptation(@"1") image:@"collect" selectedImage:@"collectSelect"];
    [self addChildVc:[[ThirdViewController alloc] init] title:LanguageAdaptation(@"2") image:@"Shop" selectedImage:@"ShopSelect"];
    [self addChildVc:[[FourthViewController alloc] init] title:LanguageAdaptation(@"3") image:@"preson" selectedImage:@"presonSelect"];
    
    MyTabBar *tabBar = [[MyTabBar alloc] init];
    tabBar.delegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}
- (void)createGuidanceView{
    GuidanceView *gudanV =[[GuidanceView alloc]initWithFrame:CGRectMake(0,0,WIDTH(WINDOW), HEIGHT(WINDOW))];
    [self.view addSubview:gudanV];
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : Color(123, 123, 123,1)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    UINavigationController *navigationVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [tabBar.items indexOfObject:item];
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
