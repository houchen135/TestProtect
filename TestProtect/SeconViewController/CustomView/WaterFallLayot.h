//
//  WaterFallLayot.h
//  TestProtect
//
//  Created by xthink2 on 16/3/14.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFallLayoutDelegate <UICollectionViewDelegate>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;
@optional


@end

@interface WaterFallLayot : UICollectionViewLayout
{
    float x;
    // 左列view起始高
    float leftY;
    // 右列view起始高
    float rightY;
}
@property (nonatomic,assign) float itemWidth;  // 每一个cell的宽度
@property (nonatomic,assign) CGPoint center;
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) NSInteger cellCount;
@property (nonatomic,weak) id <WaterFallLayoutDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *allItemAttributes;
@property (nonatomic,assign) UIEdgeInsets sectionInset;
@end
