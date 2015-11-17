//
//  DrawLable.m
//  CaLayerAnimationTest
//
//  Created by hanxiaoqing on 15/11/16.
//  Copyright (c) 2015年 hanxiaoqing. All rights reserved.
//

#import "DrawPageCtl.h"

@interface DrawPageCtl()

@property (nonatomic,weak) CAShapeLayer *circleLayer;

@end
@implementation DrawPageCtl


- (void)setPagesNum:(NSInteger)pagesNum{
    _pagesNum = pagesNum;
    [self setNeedsDisplay];
    
}


- (void)ainimationStart{
    
    // 1.创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 2.设置动画对象
    // keyPath决定了执行怎样的动画, 调整哪个属性来执行动画
    anim.keyPath = @"transform";
    //    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1, 0)];
    anim.duration = 1;
    anim.delegate  = self;
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeBoth;
    
    // 3.添加动画
    [self.circleLayer addAnimation:anim forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
 
    
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat ratio  = 10;
    CGContextSetGrayFillColor(ctx, 0.2, 0.6);
    CGContextAddArc(ctx, ratio+3,height/2,ratio, M_PI/2, -M_PI/2, 1);
    CGContextAddArc(ctx, width-ratio, rect.size.height/2, ratio, -M_PI/2, M_PI/2, 0);
    
    CGContextFillPath(ctx);
    
   /* 
    1.NSShadowAttributeName 设置阴影，单独设置不好使，必须和这三个任一个搭配，
    NSVerticalGlyphFormAttributeName，NSObliquenessAttributeName，NSExpansionAttributeName
    NSVerticalGlyphFormAttributeName 该属性所对应的值是一个 NSNumber 对象(整数)。
    0 表示横排文本。1 表示竖排文本。在 iOS 中，总是使用横排文本，0 以外的值都未定义。
    
    2.NSObliquenessAttributeName设置字体倾斜
    
    3.NSExpansionAttributeName 设置文本扁平化 
    
    4.NSStrokeColorAttributeName  设置文字描边颜色，需要和NSStrokeWidthAttributeName设置描边宽度，
      这样就能使文字空心.
    
    5.NSStrikethroughStyleAttributeName 添加删除线
    
    6.NSUnderlineStyleAttributeName 添加下划线
    
    7.NSParagraphStyleAttributeName :paragraph 设置段落样式
      NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
      paragraph.alignment = NSTextAlignmentCenter;   
    */
    
    NSString *drawtext = [NSString stringWithFormat:@"of %zd",self.pagesNum];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],
                           NSForegroundColorAttributeName:[UIColor grayColor],
                           NSParagraphStyleAttributeName: paragraph,
                           NSStrokeWidthAttributeName:@-3,
                           NSStrokeColorAttributeName:[UIColor yellowColor],
                          };
    
    CGFloat drawtextH = [UIFont systemFontOfSize:15].lineHeight;
    CGFloat drawtextX = ratio;
    CGFloat drawtextY = (height - drawtextH)/2;
    CGFloat drawtextW = width-ratio;
    
    CGRect textrect = CGRectMake(drawtextX, drawtextY, drawtextW, drawtextH);
    [drawtext drawInRect:textrect withAttributes:dic];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
        circleLayer.fillColor = [[UIColor blackColor] CGColor];
        circleLayer.opacity = 0.5;
        circleLayer.bounds = CGRectMake(0, 0, 16, 16);
        circleLayer.position = CGPointMake(12, 8);
//        circleLayer.transform = CATransform3DMakeTranslation(-2, 0, 0);
//        circleLayer.anchorPoint = CGPointMake(0.01, 0.01);
        
//        circleLayer.anchorPoint  = CGPointMake(0.3, 0.4);
        //    backgroundLayer.lineWidth = 5;
        [self.layer addSublayer:circleLayer];
        self.circleLayer = circleLayer;
        
        
    }
    return self;
 }



- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat radius = 8;
    CGPoint arcCenter = CGPointMake(radius, self.frame.size.height/2);
    
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                              radius:radius
                                                          startAngle:M_PI
                                                            endAngle:-M_PI
                                                           clockwise:NO];
    self.circleLayer.path = circlePath.CGPath;
  
    
}
@end
