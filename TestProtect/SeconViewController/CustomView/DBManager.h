//
//  DBManager.h
//  TestProtect
//
//  Created by xthink2 on 16/3/19.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
#pragma mark - 创建数据库并添加表
// name 为数据库文件名
// className是创建数据库的语句格式："CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT, '%@' TEXT, '%@' TEXT)",@"USER",@"id",@"name",@"headImage"
// 对应的数据库类型都是：TEXT，其中表名是：USER
// 其中有3个属性：id、name、headerImage
+(void)newDBWithName:(NSString *)name className:(NSString *)className;
@end
