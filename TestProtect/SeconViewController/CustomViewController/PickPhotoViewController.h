//
//  PickPhotoViewController.h
//  同城
//
//  Created by xthink2 on 16/1/28.
//  Copyright © 2016年 xthink4. All rights reserved.
//

#import "BaseFatherViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface PickPhotoViewController : BaseFatherViewController
@property (nonatomic,assign)int leastNum;
@property (nonatomic,assign)int mostNum;
@property (nonatomic,strong)void(^returenPickedPhoto)(NSMutableArray *thumbnail,NSMutableArray *Original);
@end
