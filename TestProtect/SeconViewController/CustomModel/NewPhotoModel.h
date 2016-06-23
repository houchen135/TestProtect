//
//  NewPhotoModel.h
//  同城
//
//  Created by xthink2 on 16/1/28.
//  Copyright © 2016年 xthink4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <UIKit/UIKit.h>
@interface NewPhotoModel : NSObject
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)ALAsset *asset;
@end
