//
//  WaterFallCollectionView.m
//  TestProtect
//
//  Created by xthink2 on 16/3/14.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "WaterFallCollectionView.h"

@interface WaterFallCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation WaterFallCollectionView
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewLayout *layout=[[UICollectionViewLayout alloc]init];
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view)) collectionViewLayout:layout];
        _collectionView.dataSource =self;
        _collectionView.delegate =self;
        [_collectionView registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@""];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
