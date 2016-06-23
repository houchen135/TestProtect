//
//  DBManager.m
//  TestProtect
//
//  Created by xthink2 on 16/3/19.
//  Copyright © 2016年 xthink2. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
@implementation DBManager
+(void)newDBWithName:(NSString *)name className:(NSString *)className{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *myFile = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.db",name]];
    FMDatabase *db = [FMDatabase databaseWithPath:myFile];
    if ([db open]) {
        NSLog(@"打开数据库");
        BOOL res = [db executeUpdate:className];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
    }else
    {
        NSLog(@"打开数据库失败");
    }
}
@end
