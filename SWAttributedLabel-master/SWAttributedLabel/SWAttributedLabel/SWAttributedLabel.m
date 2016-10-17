//
//  SWAttributedLabel.m
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "SWAttributedLabel.h"


static NSString* const kEllipsesCharacter = @"\u2026"; // 代表中文的 … 省略号

@implementation SWAttributedLabel

{
    NSMutableArray *_images;
    CTFrameRef _frameRef;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSettings];
    }
    return self;
}


- (void)configSettings {
    _lineSpacing       = 4.f;
    _paragraphSpacing  = 3.f;
    
    _imageSize         = CGSizeZero;
    _imageMargin       = NSEdgeInsetsMake(0, 1, 0, 1);
    _font              = [NSFont systemFontOfSize:16.f];
    _textColor         = [NSColor blackColor];
    
    _textAlignment     = kCTTextAlignmentLeft;
    _lineBreakMode     = kCTLineBreakByWordWrapping | kCTLineBreakByCharWrapping;
    _imageAlignment    = SWImageAlignmentBottom;
    
    _images = [NSMutableArray array];
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (!_attributedString) {
        return;
    }
    
    // 1.获取图形上下文
    CGContextRef context =  (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    
    // 2.获取CTFrameRef
    _frameRef = [_attributedString prepareFrameRefWithRect:dirtyRect];
    
//    // 3.绘制高亮背景
//    [self drawHighlightWithRect:rect];
    
    // 4.绘制文字
    [self drawText:context];
    
    // 5.绘制图片
    [self drawImages];
}


#pragma mark -
#pragma mark 计算文本的大小
- (CGSize)textRealContantSize
{
    if (!_attributedString) {
        return CGSizeZero;
    }
    // _numberOfLines行情况下文字的高度
    CGSize realSize = [_attributedString realitySizeForWidth:NSWidth(self.frame) numberOfLines:_numberOfLines];
    return CGSizeMake(realSize.width, realSize.height);
}

// 获取当前需要展示的行数
- (NSUInteger)currentNumberOfLines {
    
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    return _numberOfLines > 0 ? MIN(_numberOfLines, lineCount) : lineCount;
}

#pragma mark -
#pragma mark 设置属性文本
- (void)setText:(NSString *)text
{
    NSAttributedString *attributedText = [self attributedString:text];
    [self setAttributedText:attributedText];
}

// 配置属性文本样式
- (NSMutableAttributedString *)attributedString:(NSString *)text {
    return [self attributedString:text font:_font textColor:_textColor];
}

- (NSMutableAttributedString *)attributedString:(NSString *)text
                                           font:(NSFont *)font
                                      textColor:(NSColor *)textColor {
    if (!text && !text.length) {
        return nil;
    }
    
    // 初始化NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString setFont:font];
    [attributedString setTextColor:textColor];
    
    return attributedString;
}

// 处理图片，并设置属性文本版式
- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    
    _images = [_attributedString setImageAlignment:_imageAlignment imageMargin:_imageMargin imageSize:_imageSize font:_font];
    
    [_attributedString setAttributedsWithLineSpacing:_lineSpacing
                                    paragraphSpacing:_paragraphSpacing
                                       textAlignment:_textAlignment
                                       lineBreakMode:_lineBreakMode];
    
    [self.layer setNeedsDisplay];
}

#pragma mark -
#pragma mark 绘制内容   考虑需求 把缓存的html页面 解析成 coretext

- (void)drawText:(CGContextRef)context{
    CGPathRef path = CTFrameGetPath(_frameRef);
    CGRect rect = CGPathGetBoundingBox(path);
    
    // 得到所有的 CTLineRef
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    
    // 得到所有行的Origin
    NSInteger numberOfLines = [self currentNumberOfLines];
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, numberOfLines), lineOrigins);
    
    NSAttributedString *attributedString = [_attributedString mutableCopy];
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        // 取出每一行的位置Origin
        CGPoint lineOrigin = lineOrigins[lineIndex];
        
        // NSLog(@"%f-----%f",self.frame.size.height,rect.size.height);
        lineOrigin.y =  self.frame.size.height + (lineOrigin.y - rect.size.height);
        CGContextSetTextPosition(context, lineOrigin.x, lineOrigin.y);
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        BOOL shouldDrawLine = YES;
        
        if (lineIndex == numberOfLines - 1) { // 最后一行
            // 最后一行文字的 占总文字的range
            CFRange lastLineRange = CTLineGetStringRange(line);
            
            // 最后一行算出来的lastLineRange 推出的总文字长度 小于实际的总文字长度
            NSInteger estimateAttStrLength = lastLineRange.location + lastLineRange.length;
            if (estimateAttStrLength < (CFIndex)attributedString.length) {
                
                // 得到最后一行的文字
                NSMutableAttributedString *truncationString = [[attributedString attributedSubstringFromRange:NSMakeRange(lastLineRange.location, lastLineRange.length)] mutableCopy];
                
                if (lastLineRange.length > 0) {
                    unichar lastCharacter = [[truncationString string] characterAtIndex:lastLineRange.length - 1];
                    if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:lastCharacter]) {
                        [truncationString deleteCharactersInRange:NSMakeRange(lastLineRange.length - 1, 1)];
                    }
                }
                
                // 取得最后一个字符的属性Attributes
                NSUInteger truncationAttributePosition = estimateAttStrLength - 1;
                NSDictionary *tokenAttributes = [attributedString attributesAtIndex:truncationAttributePosition
                                                                     effectiveRange:NULL];
                // 根据最后一个字符属性 创建一个省略号的字符
                NSMutableAttributedString *tokenString = [[NSMutableAttributedString alloc] initWithString:kEllipsesCharacter
                                                                                                attributes:tokenAttributes];
                [truncationString appendAttributedString:tokenString];
                
                CTLineRef truncationToken = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)tokenString);
                
                // 替换
                CTLineRef truncationLine = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)truncationString);
                   CTLineTruncationType truncationType = kCTLineTruncationEnd;
                CTLineRef truncatedLine = CTLineCreateTruncatedLine(truncationLine, self.frame.size.width, truncationType, truncationToken);
                if (!truncatedLine) {
                    truncatedLine = CFRetain(truncationToken);
                }
                CFRelease(truncationLine);
                CFRelease(truncationToken);
                
                CTLineDraw(truncatedLine, context);
                NSUInteger truncatedCount =  CTLineGetGlyphCount(truncatedLine);
                
                // 获取当前显示的文字
                NSMutableAttributedString *showString = [[attributedString attributedSubstringFromRange:NSMakeRange(0, lastLineRange.location + truncatedCount - tokenString.length)] mutableCopy];
                [showString appendAttributedString:tokenString];
                
                // 获取绘制后的新属性
                _frameRef = [showString prepareFrameRefWithRect:self.frame];
                
                CFRelease(truncatedLine);
                
                shouldDrawLine = NO;
            }
        }
        
        if (shouldDrawLine) {
            CTLineDraw(line, context);
        }
    }
}

- (void)drawImages {
    if (!_frameRef) {
        return;
    }

    CFArrayRef lines = CTFrameGetLines(_frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, 0), lineOrigins);
    NSInteger numberOfLines =  [self currentNumberOfLines];
    
    for (CFIndex index = 0; index < numberOfLines; index++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, index);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        CFIndex runCount = CFArrayGetCount(runs);
        CGPoint lineOrigin = lineOrigins[index];
        
        for (CFIndex idx = 0; idx < runCount; idx++) {
            CTRunRef run = CFArrayGetValueAtIndex(runs, idx);
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (nil == delegate) {
                continue;
            }
            SWAttributedImageInfo *imageInfo = (SWAttributedImageInfo *)CTRunDelegateGetRefCon(delegate);
            // 获取将要展示图片的frame
            CGRect nrect = CTRunGetTypographicBoundsForImageRect(run, line, lineOrigin, imageInfo);
            
//            CGRect rect = CGRectMake(nrect.origin.x, self.frame.size.height - nrect.origin.y - nrect.size.height, nrect.size.width, nrect.size.height);
            CGRect rect = CGRectMake(NSMinX(nrect), NSHeight(self.frame) - NSMinY(nrect) - NSHeight(nrect), NSWidth(nrect), NSHeight(nrect));
            
            if (index == numberOfLines - 1 && idx >= runCount - 2 && _lineBreakMode == kCTLineBreakByTruncatingTail) {
                //最后行最后的2个CTRun需要做额外判断
                CGFloat attachmentWidth = CGRectGetWidth(rect);
                const CGFloat kMinEllipsesWidth = attachmentWidth;
                if (CGRectGetWidth(self.bounds) - CGRectGetMinX(rect) - attachmentWidth <  kMinEllipsesWidth) {
                    continue;
                }
            }
            
            // 绘制图片
            NSView *testView = [[NSView alloc] init];
            testView.frame = nrect;
            testView.wantsLayer = YES;
            testView.layer.backgroundColor = [NSColor redColor].CGColor;
            [self addSubview:testView];
            
            if (imageInfo.imageType == SWImageNormalType) {
                [self loadNormalImageWithRect:nrect info:imageInfo];
            } else if (imageInfo.imageType == SWImageGIFType ) {
                [self loadGIFImageWithRect:rect info:imageInfo];
            } else {
                NSLog(@"view类型的");
            }
            
        }
    }
}


- (void)loadNormalImageWithRect:(NSRect)nrect info:(SWAttributedImageInfo *)imageInfo {
    NSGraphicsContext *nsContext = [NSGraphicsContext currentContext];
    CGContextRef context = (CGContextRef)[nsContext graphicsPort];
    NSImage *image = [NSImage imageNamed:imageInfo.imageName];
    NSRect imageRect = NSMakeRect(0, 0, nrect.size.width, nrect.size.height);
    CGImageRef ref = [image CGImageForProposedRect:&imageRect context:nsContext hints:nil];
    CGContextDrawImage(context, nrect, ref);
}

- (void)loadGIFImageWithRect:(NSRect)rect info:(SWAttributedImageInfo *)imageInfo {
    CGRect frame = CGRectMake(rect.origin.x,
                              self.bounds.size.height - rect.origin.y - rect.size.height,
                              rect.size.width,
                              rect.size.height);
    
    NSImageView *imageView = [[NSImageView alloc] init];
    imageView.animates = YES;
    imageView.canDrawSubviewsIntoLayer = YES;
    NSImage *image = [NSImage imageNamed:imageInfo.imageName];
    if (image) {
        imageView.image = image;
    } else {
        NSImage *gifImage = [[NSImage alloc] initWithContentsOfFile:imageInfo.imagePath];
        imageView.image = gifImage;
    }
    [self addSubview:imageView];
    [imageView setFrame:frame];
}


@end
