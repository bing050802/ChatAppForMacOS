//
//  UIImage+MultiFormat.m
//  SDWebImage
//
//  Created by Olivier Poitrey on 07/06/13.
//  Copyright (c) 2013 Dailymotion. All rights reserved.
//

#import "NSImage+MultiFormat.h"
#import "NSImage+GIF.h"
#import <ImageIO/ImageIO.h>
#import  <CoreGraphics/CoreGraphics.h>
@implementation UIImage (MultiFormat)

+ (UIImage *)sd_imageWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    return [[UIImage alloc] initWithDataIgnoringOrientation:data];
}



- (NSBitmapImageRep *)bitmapImageRepresentation {
    NSArray * imageReps = [self representations];
    float width = 0;
    float height = 0;
    
    for (NSImageRep * imageRep in imageReps) {
        if ([imageRep pixelsWide] > width) width = [imageRep pixelsWide];
        if ([imageRep pixelsHigh] > height) height = [imageRep pixelsHigh];
    }
    
    if(width < 1 || height < 1)
        return nil;
    
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                             initWithBitmapDataPlanes: NULL
                             pixelsWide: width
                             pixelsHigh: height
                             bitsPerSample: 8
                             samplesPerPixel: 4
                             hasAlpha: YES
                             isPlanar: NO
                             colorSpaceName: NSDeviceRGBColorSpace
                             bytesPerRow: 0
                             bitsPerPixel: 0];
    
    NSGraphicsContext *ctx = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx];
    [self drawInRect:NSMakeRect(0, 0, width, height) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    [ctx flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    return rep;
}


//- (UIImage *)circleImage {
//    
//    // 开始图形上下文
//   
//    
//    // 获得图形上下文
//    CGContextRef ctx =  [NSGraphicsContext currentContext].CGContext;
//    
//    // 设置一个范围
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    
//    // 根据一个rect创建一个椭圆
//    CGContextAddEllipseInRect(ctx, rect);
//    
//    // 裁剪
//    CGContextClip(ctx);
//    
//    // 将原照片画到图形上下文
//    [self drawInRect:rect];
//    
//    // 从上下文上获取剪裁后的照片
//    UIGraphicsGet
//    
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // 关闭上下文
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}

@end
