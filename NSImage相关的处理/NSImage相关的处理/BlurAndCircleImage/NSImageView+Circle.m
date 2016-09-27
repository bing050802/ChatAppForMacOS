//
//  NSImageView+ACircle.m
//  NSImage相关的处理
//
//  Created by hanxiaoqing on 2016/9/27.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "NSImageView+Circle.h"
#import "NSImage+StackBlur.h"
@implementation NSImageView (Circle)

- (void)circle {
   self.image = [self.image circleImageWithBorderWidth:5 borderColor:[NSColor whiteColor] size:self.bounds.size];
}
@end
