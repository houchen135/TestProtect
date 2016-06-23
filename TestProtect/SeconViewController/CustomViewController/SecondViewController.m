//
//  SecondViewController.m
//  TestProtect
//
//  Created by xthink2 on 16/1/11.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "SecondViewController.h"
#import "MyData1.h"
#import "PickPhotoViewController.h"
#import "WaterFallCollectionView.h"
@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *myDateArray1;
@end

@implementation SecondViewController
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), HEIGHT(WINDOW))];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        
    }
    return _tableView;
}
- (NSMutableArray *)myDateArray1
{
    if (!_myDateArray1) {
        _myDateArray1 =[NSMutableArray array];
        MyData1 *mydata1 =[[MyData1 alloc]init];
        mydata1.name =@"1";
        mydata1.array =[NSMutableArray array];
        [mydata1.array addObject:@"多选相册，带相机按钮"];
        [mydata1.array addObject:@"加载动画开始！"];
        [mydata1.array addObject:@"加载动画结束！"];
        [mydata1.array addObject:@"加载动画开始5S后结束！"];
        [mydata1.array addObject:@"瀑布流！"];
        [_myDateArray1 addObject:mydata1];
        MyData1 *mydata2 =[[MyData1 alloc]init];
        mydata2.name =@"2";
        mydata2.array =[NSMutableArray array];
        [mydata2.array addObject:@"a"];
        [mydata2.array addObject:@"b"];
        [mydata2.array addObject:@"c"];
        [mydata2.array addObject:@"d"];
        [_myDateArray1 addObject:mydata2];
    }
    return _myDateArray1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:LanguageAdaptation(@"1Title")];
    [self creat];
}
- (void)creat{
    [self.view addSubview:self.tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyData1 *data =[self.myDateArray1 objectAtIndex:section];
    if ([data isShow]) {
        return [[data array]count];
    }else{
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.myDateArray1.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyData1 *data =[self.myDateArray1 objectAtIndex:section];
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, WIDTH(tableView), 35.0f);
    [btn setTitle:data.name forState:UIControlStateNormal];
    btn.tag =section;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    if (section%2) {
        btn.backgroundColor=[UIColor darkGrayColor];
    }else{
        btn.backgroundColor =[UIColor lightGrayColor];
    };
    return btn;
}
- (void)btnAction:(UIButton *)btn{
    MyData1 *data=[self.myDateArray1 objectAtIndex:btn.tag];
    if ([data isShow]) {
        [data setIsShow:NO];
    }else{
        [data setIsShow:YES];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName =@"cell1";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyData1 *data =[self.myDateArray1 objectAtIndex:indexPath.section];
    NSString *str =[data.array objectAtIndex:indexPath.row];
    cell.textLabel.text =str;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyData1 *data =[self.myDateArray1 objectAtIndex:indexPath.section];
    NSLog(@"%@---%@",data.name,data.array[indexPath.row]);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            PickPhotoViewController *pic =[[PickPhotoViewController alloc]init];
            pic.leastNum =1;
            pic.mostNum =9;
            pic.hidesBottomBarWhenPushed =YES;
            pic.returenPickedPhoto = ^(NSMutableArray *thumbnail,NSMutableArray *Original){
                NSLog(@"选中的原图%@\n选中的缩略图%@",Original,thumbnail);
            };
            [self.navigationController pushViewController:pic animated:YES];
        }else if (indexPath.row == 1){
            [GifHudView show];
        }else if (indexPath.row == 2){
            [GifHudView dismiss];
        }else if (indexPath.row == 3){
            [GifHudView showWithOverlay];
            dispatch_time_t time =dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [GifHudView dismiss];
            });
        }else{
            WaterFallCollectionView *water =[[WaterFallCollectionView alloc]init];
            water.hidesBottomBarWhenPushed =YES;
            
            [self.navigationController pushViewController:water animated:YES];
        }
    }
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
