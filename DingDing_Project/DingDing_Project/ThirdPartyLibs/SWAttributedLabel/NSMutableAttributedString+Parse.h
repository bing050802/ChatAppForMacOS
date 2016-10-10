//
//  NSMutableAttributedString+Parse.h
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWAttributedImageInfo.h"

@interface NSMutableAttributedString (Parse)

// 检查并处理图片
- (NSMutableArray *)setImageAlignment:(SWImageAlignment)imageAlignment
                          imageMargin:(NSEdgeInsets)imageMargin
                            imageSize:(CGSize)imageSize
                                 font:(NSFont *)font;
// 创建图片attString
- (NSMutableAttributedString *)createImageAttributedString:(SWAttributedImageInfo *)imageInfo;

@end
