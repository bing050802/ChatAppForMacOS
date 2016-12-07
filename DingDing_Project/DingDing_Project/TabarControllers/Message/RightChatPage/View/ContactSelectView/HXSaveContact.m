//
//  HXSaveContact.m
//  MDatabase
//
//  Created by hanxiaoqing on 2016/12/6.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "HXSaveContact.h"
#import "FMDB.h"

@interface HXSaveContact ()

@end

@implementation HXSaveContact

static FMDatabase *_db;


+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"saveContact.sqlite"];
    //    NSLog(@"%@",path);
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_saveContact (id integer PRIMARY KEY, contact text NOT NULL, pinyin text NOT NULL);"];
}



+ (void)saveContact:(NSString *)name
{
    NSString *pinyin = [self transform:name];
    [_db executeUpdateWithFormat:@"INSERT INTO t_saveContact(contact, pinyin) VALUES (%@,%@);", name,pinyin];
}



+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    NSString *offEmpty = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    pinyin = [offEmpty mutableCopy];
    
    return [pinyin uppercaseString];
}

+ (BOOL)IsChinese:(NSString *)str {
    for (int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}


+ (NSArray *)selectNameWithFilteString:(NSString *)fstring {
    // 判断输入过滤文字是否包含
    NSString *sql;
    if ([self IsChinese:fstring]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_saveContact WHERE contact LIKE '%%%@%%';",fstring];
    }
    else {
        NSString *pinyinFs = [self transform:fstring];
        sql = [NSString stringWithFormat:@"SELECT * FROM t_saveContact WHERE pinyin LIKE '%%%@%%';",pinyinFs];
    }
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *accounts = [NSMutableArray array];
    while (set.next) {
        NSString *account = [set objectForColumnName:@"contact"];
        [accounts addObject:account];
    }
    
    return accounts;
    
}

+ (void)clearAll
{
    [_db executeUpdateWithFormat:@"DELETE FROM t_saveContact;"];
}

+ (NSInteger)savedCount {
    //SELECT count(*) ... FROM （*代表任意字段）
    NSString *sqlstr = @"SELECT count(*) as 'count' FROM t_saveContact";
    FMResultSet *set = [_db executeQuery:sqlstr];
    while (set.next) {
        NSInteger count = [set intForColumn:@"count"];
        return count;
    }
    return 0;
}

+ (NSArray *)selectAll {
    NSMutableArray *arrayM = [[self selectNameWithFilteString:@""] mutableCopy];
    [arrayM insertObject:@"所有人" atIndex:0];
    return arrayM;
}



@end
