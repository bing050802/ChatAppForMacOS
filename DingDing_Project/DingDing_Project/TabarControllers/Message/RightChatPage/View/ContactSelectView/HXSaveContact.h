//
//  HXSaveContact.h
//  MDatabase
//
//  Created by hanxiaoqing on 2016/12/6.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXSaveContact : NSObject

+ (void)saveContact:(NSString *)name;

+ (NSArray *)selectNameWithFilteString:(NSString *)fstring;

+ (void)clearAll;

+ (NSArray *)selectAll;

+ (NSInteger)savedCount;

@end
