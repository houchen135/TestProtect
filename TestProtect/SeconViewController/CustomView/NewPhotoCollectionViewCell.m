//
//  NewPhotoCollectionViewCell.m
//  同城
//
//  Created by xthink2 on 16/1/28.
//  Copyright © 2016年 xthink4. All rights reserved.
//

#import "NewPhotoCollectionViewCell.h"

@implementation NewPhotoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)selectBtnClick:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    _selectBtnClickBlock(btn.selected);
}

@end
