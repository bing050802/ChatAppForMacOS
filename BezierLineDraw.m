//
//  BezierLineDraw.m
//  CaLayerAnimationTest
//
//  Created by hanxiaoqing on 15/11/18.
//  Copyright (c) 2015年 hanxiaoqing. All rights reserved.
//

#import "BezierLineDraw.h"

@implementation BezierLineDraw


- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    [[UIColor blackColor] set];
    CGContextMoveToPoint(ctx, 100, 200);
    CGContextAddQuadCurveToPoint(ctx, 100, 210, 160, 200);
    
   
}
@end
