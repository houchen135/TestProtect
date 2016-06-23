//
//  NewPhotoCollectionViewCell.h
//  同城
//
//  Created by xthink2 on 16/1/28.
//  Copyright © 2016年 xthink4. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBtnClickBlock) (BOOL isSelect);
@interface NewPhotoCollectionViewCell : UICollectionViewCell
@property (weak ,nonatomic)  IBOutlet  UIImageView *  imageView;
@property (weak ,nonatomic)  IBOutlet  UIImageView *  selectImageView;
@property (nonatomic,copy) SelectBtnClickBlock selectBtnClickBlock;
- (IBAction)selectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@end
