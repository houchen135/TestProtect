//
//  WaterFallLayot.m
//  TestProtect
//
//  Created by xthink2 on 16/3/14.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "WaterFallLayot.h"
#import "HeaderMacroDefinition.h"
@implementation WaterFallLayot
- (void)prepareLayout
{
    [super prepareLayout];
    self.itemWidth=WIDTH(WINDOW)/2-7.5;
    self.sectionInset=UIEdgeInsetsMake(0,0,0,0);
    self.delegate = (id <WaterFallLayoutDelegate> )self.collectionView.delegate;
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(WIDTH(self.collectionView), (leftY>rightY?leftY:rightY));
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath  withIndex:(int)index
{
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    CGFloat itemHeight = floorf(itemSize.height *self.itemWidth / itemSize.width);
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    index+=1;
    if (index%2==0)
    {
        x+=(self.itemWidth+self.sectionInset.left);
        rightY+=self.sectionInset.top;
        if (WIDTH(WINDOW)<=320) {
            attributes.frame = CGRectMake(x+10-WIDTH(WINDOW)/320*15, rightY, self.itemWidth, itemHeight);
            
        }else
        {
        }
        attributes.frame = CGRectMake(x+10, rightY, self.itemWidth, itemHeight);
        
        rightY+=itemHeight+5;
        
    }else
    {
        x=self.sectionInset.left;
        leftY+=self.sectionInset.top;
        attributes.frame = CGRectMake(x+5, leftY, self.itemWidth, itemHeight);
        leftY+=itemHeight+5;
    }
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    x=0;
    leftY=5;
    rightY=5;
    
    NSMutableArray* attributes = [NSMutableArray array];
    for (int i=0 ; i <self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath withIndex:i]];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x,_center.y);
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x,_center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1,1.0);
    return attributes;
}
@end
