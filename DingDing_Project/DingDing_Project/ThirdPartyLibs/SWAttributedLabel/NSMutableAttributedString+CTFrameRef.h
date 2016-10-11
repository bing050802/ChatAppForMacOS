//
//  NSMutableAttributedString+CTFrameRef.h
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
@class SWAttributedImageInfo;

@interface NSMutableAttributedString (CTFrameRef)

#pragma mark - NSRange / CFRange
NSRange NSRangeFromCFRange(CFRange range);

#pragma mark - CoreText CTLine/CTRun utils
BOOL CTRunContainsCharactersFromStringRange(CTRunRef run, NSRange range);
BOOL CTLineContainsCharactersFromStringRange(CTLineRef line, NSRange range);

CGRect CTRunGetTypographicBoundsAsRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin);
CGRect CTLineGetTypographicBoundsAsRect(CTLineRef line, CGPoint lineOrigin);
CGRect CTRunGetTypographicBoundsForLinkRect(CTLineRef line, NSRange range, CGPoint lineOrigin);
CGRect CTRunGetTypographicBoundsForImageRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin, SWAttributedImageInfo *imageData);

// 获取CTFrameRef
- (CTFrameRef)prepareFrameRefWithRect:(CGRect)rect;

// 所有文字占据一行所需要的宽度
- (CGFloat)oneLineRealityWidth;

// 获取固定宽度下文字需要的实际高度
- (CGFloat)realityHeightForWidth:(CGFloat)width;

// 获取固定行数需要的实际高度
- (CGSize)realitySizeForWidth:(CGFloat)width
                numberOfLines:(NSUInteger)numberOfLines;

@end
