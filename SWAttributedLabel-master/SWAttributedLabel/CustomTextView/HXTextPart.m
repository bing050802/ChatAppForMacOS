//
//  HXTextPart.m
//  DingDing_Project
//
//  Created by han on 2016/10/29.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXTextPart.h"

@implementation HXTextPart

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}

@end
