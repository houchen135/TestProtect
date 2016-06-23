//
//  BaseFatherViewController.m
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "BaseFatherViewController.h"
#import "LanguageChooseController.h"
#import "HeaderMacroDefinition.h"
#import "CommonCrypto/CommonDigest.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@interface BaseFatherViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation BaseFatherViewController
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager =[[CLLocationManager alloc]init];
        _locationManager.delegate =self;
        // 设置定位精度
        // kCLLocationAccuracyNearestTenMeters:精度10米
        // kCLLocationAccuracyHundredMeters:精度100 米
        // kCLLocationAccuracyKilometer:精度1000 米
        // kCLLocationAccuracyThreeKilometers:精度3000米
        // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        // kCLLocationAccuracyBestForNavigation:导航情况下最高精度，一般要有外接电源时才能使用
        _locationManager.desiredAccuracy =kCLLocationAccuracyBestForNavigation;
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        // 如果设为kCLDistanceFilterNone，则每秒更新一次;
        _locationManager.distanceFilter = 1000.0f;
        //  iOS8中，苹果已经强制开发者在请求定位服务时获得用户的授权，此外iOS状态栏中还有指示图标，提示用户当前应用是否正在使用定位服务。另外在iOS8中，苹果进一步改善了定位服务，让开发者请求定位服务时需要向用户提供更多的透明。此外，iOS8中还支持让应用开发者调用全新的“访问监控”功能，当用户允许后应用才能获得更多的定位数据
        //  在info.plist里面添加key: NSLocationAlwaysUsageDescription/NSLocationWhenInUseUsageDescription，value就是对话框上想要询问的语句。这时候程序才能正确的弹出授权对话框，用户选了同意以后，定位代码就正确的运行。(requestAlwaysAuthorization:始终允许访问位置信息;requestWhenInUseAuthorization:使用应用程序期间允许访问位置数据)
        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
#ifdef __IPHONE_8_0
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                //用这个方法，plist中需要NSLocationAlwaysUsageDescription
                [_locationManager performSelector:@selector(requestAlwaysAuthorization)];
            }
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                //用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
                [_locationManager performSelector:@selector(requestWhenInUseAuthorization)];
                
            }
#endif
        }
        
        
        
    }
    return _locationManager;
}
- (void)viewWillAppear:(BOOL)animated
{
    //注册键盘出现 消失 通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:self];
}
# pragma  mark - 键盘弹出收回的四种状态消息
- (void)keyBoardWillShow:(NSNotification *)notification{

}
- (void)keyBoardDidShow:(NSNotification *)notification{
    
}
- (void)keyBoardWillHide:(NSNotification *)notification{
    
}
- (void)keyBoardDidHide:(NSNotification *)notification{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent =NO;
    self.view.backgroundColor = Color(241.0f, 241.0f, 241.0f, 1.0f);
    [GifHudView setGifWithImageName:@"Loading1.gif"];
    // Do any additional setup after loading the view.
}

#pragma mark ------------设置导航-------------
# pragma  mark - 设置导航Title
- (void)setNavigationTitle:(NSString *)title{
    self.navigationItem.title = title;
    
}
# pragma mark -------设置导航TitleView----------
- (void)setNavigationTitleView:(UIView *)titleView{
    self.navigationItem.titleView = titleView;
}
# pragma mark -------设置导航左按钮----------
- (void)setNavigationBarLeftBtnWitBtnTitle:(NSString *)BtnTitle{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0,19, 19);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBtn addTarget:self action:@selector(NavigationBarLeftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:BtnTitle forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
}
# pragma mark - 根据按钮图片名字 设置导航左按钮
- (void)setNavigationBarLeftBtnWithImageName:(NSString *)imageStr{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,0,19, 19);
    [leftBtn addTarget:self action:@selector(NavigationBarLeftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    
    UIView *backBtnView = [[UIView alloc] initWithFrame:leftBtn.bounds];
    //    backBtnView.bounds = CGRectOffset(backBtnView.bounds, -6, 0);
    [backBtnView addSubview:leftBtn];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtnView];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
}
# pragma mark - 设置导航左按钮（多个）
- (void)setNavigationBarLeftBtnsWithImageNameArr:(NSArray *)imageNameArr{
    NSMutableArray *btnArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < imageNameArr.count;i++) {
        
        NSString *imageStr = imageNameArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,0,19, 19);
        [btn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        btn.tag = BaseTag + i;
        [btn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnArray addObject:btn];
    }
    self.navigationItem.leftBarButtonItems = btnArray;
    
    
}
#pragma mark - 导航左按钮 点击事件  ---已在 .h 中声明 可在子类中直接调用
- (void)NavigationBarLeftBarButtonAction:(UIButton *)tmpBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

//-----------------------------设置导航右按钮-------------------------------
# pragma mark - 根据按钮Title名字 设置导航右按钮
- (void)setNavigationBarRightBtnWitBtnTitle:(NSString *)BtnTitle{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0,0,70, 19 + 15);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    //    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -45);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:BtnTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:82.0/255.0 blue:79.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -48);
    
}
# pragma mark - 根据按钮图片名字 设置导航右按钮
- (void)setNavigationBarRightBtnWithImageName:(NSString *)imageStr{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0,0,19,19);
    [rightBtn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}

# pragma mark - 设置导航右按钮（多个）
- (void)setNavigationBarRightBtnsWithImageNameArr:(NSArray *)imageNameArr{
    
    NSMutableArray *btnArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < imageNameArr.count;i++) {
        
        NSString *imageStr = imageNameArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,0,19, 19);
        [btn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        btn.tag = BaseTag + i;
        [btn addTarget:self action:@selector(NavigationBarRightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
        [btnArray addObject:rightBarBtn];
        
    }
    self.navigationItem.rightBarButtonItems = btnArray;
    
}
#pragma mark - 导航右按钮 点击事件
- (void)NavigationBarRightBarButtonAction:(UIButton *)tmpBtn{
    if (tmpBtn.tag == BaseTag) {//推送按钮
        
    }else if(tmpBtn.tag == BaseTag + 1){//更多按钮
        
    }
}
# pragma mark -----------获取经纬度------------
// 采用CLLoncationManager类库获得用户位置
// 先导入CoreLocation.frameWord  再通过CLLocationManager获得
# pragma  mark - 开始定位,获取经纬度
- (void)getLocationMessage{
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
    }
    else {
        NSLog(@"请开启定位功能！");
    }
}
# pragma  mark - 停止定位，并关闭定位
- (void)stopCLLocationManager{
    [self.locationManager stopUpdatingLocation];
}
// CoreLocationManagerDelegate的实现
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    self.latitude = newLocation.coordinate.latitude;
    self.longitude = newLocation.coordinate.longitude;
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
}
# pragma mark - 根据经纬度算距离
- (NSString *)kiometresWithNewLatitude:(NSString *)newLatitude newLongitude:(NSString *)newLongitude oldLatitude:(NSString *)oldLatitude oldLongitude:(NSString *)oldLongitude
{
    CLLocation *dist=[[CLLocation alloc]initWithLatitude:[newLatitude doubleValue] longitude:[newLatitude doubleValue]];
    CLLocation *orig=[[CLLocation alloc]initWithLatitude:[oldLatitude doubleValue]  longitude:[oldLongitude doubleValue]];
    CLLocationDistance liometrers=[orig distanceFromLocation:dist];
    if (liometrers>1000) {
        return [NSString stringWithFormat:@"%.0f千米",liometrers/1000];
    }
    return [NSString stringWithFormat:@"%.0f米",liometrers];
}
# pragma mark -----------判断网络状态------------
- (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]initWithFormat:@"无网络"];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}
#pragma mark - 参数按首字母排序
// 拼接成key=value&key=value&.....
-(NSString *)stringWithDict:(NSDictionary *)dict
{
    NSArray *sortedArray = [dict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableString *strapp=[NSMutableString string];
    for (NSString *str in sortedArray) {
        [strapp appendString:[NSString stringWithFormat:@"%@=%@&",str,[dict valueForKey:str]]];
    }
    return strapp;
}
#pragma mark -----------MD5加密字符串------------
- (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]
   ]lowercaseString];
}
//md5 32位 加密
//+ (NSString *)md5With32:(NSString *)str {
//    const char *cStr = [str UTF8String];
//    unsigned char result[32];
//    CC_MD5( cStr, (int)strlen(cStr), result );
//    return [NSString stringWithFormat:
//            @"xxxxxxxxxxxxxxxx",
//            result[0],result[1],result[2],result[3],
//            result[4],result[5],result[6],result[7],
//            result[8],result[9],result[10],result[11],
//            result[12],result[13],result[14],result[15],
//            result[16], result[17],result[18], result[19],
//            result[20], result[21],result[22], result[23],
//            result[24], result[25],result[26], result[27],
//            result[28], result[29],result[30], result[31]];
//    
//}


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
