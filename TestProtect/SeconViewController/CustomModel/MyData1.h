//
//  MyData1.h
//  TestProtect
//
//  Created by xthink2 on 16/3/9.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyData1 : NSObject{
    NSMutableArray *_array;
    BOOL _isShow;
    NSString *_name;
}
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)BOOL isShow;
@end
