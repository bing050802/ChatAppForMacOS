//
//  DrawLable.m
//  CaLayerAnimationTest
//
//  Created by hanxiaoqing on 15/11/16.
//  Copyright (c) 2015年 hanxiaoqing. All rights reserved.
//

#import "DrawPageCtl.h"

#define leftCircleRa  8
#define leftArcRatio 10

#define margin 4
#define leftArcX  leftCircleRa * 2+ margin - leftArcRatio
@interface DrawPageCtl()

@property (nonatomic,weak) CAShapeLayer *circleLayer;

@property (nonatomic,weak) UIButton *circlebtn;

@end
@implementation DrawPageCtl


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.layer.cornerRadius = leftCircleRa;
        [self addSubview:btn];
        self.circlebtn = btn;
        
    }
    return self;
}


- (void)setLeftCircleColor:(UIColor *)leftCircleColor{
    _leftCircleColor = leftCircleColor;
    [self.circlebtn setBackgroundColor:leftCircleColor];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.circlebtn.frame = CGRectMake(0, self.frame.size.height/2- leftCircleRa, leftCircleRa*2,leftCircleRa*2);
    
}
- (void)setPagesNum:(NSInteger)pagesNum{
    [self.circlebtn setTitle:nil forState:UIControlStateNormal];
    _pagesNum = pagesNum;
    [self setNeedsDisplay];
    
}

- (void)setCurrentPageNum:(NSInteger)currentPageNum{
    _currentPageNum = currentPageNum;
    [self ainimationStart];
    
}


- (void)ainimationStart{
    
    // 1.创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    // 2.设置动画对象
    // keyPath决定了执行怎样的动画, 调整哪个属性来执行动画
    anim.keyPath = @"transform";
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1, 0)];
    anim.duration = 0.3;
    anim.delegate  = self;
    anim.removedOnCompletion =YES;
    anim.fillMode = kCAFillModeForwards;
    
    // 3.添加动画
    [self.circlebtn.layer addAnimation:anim forKey:nil];
}


- (void)animationDidStart:(CAAnimation *)anim{
    [self.circlebtn setTitle:nil forState:UIControlStateNormal];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.circlebtn setTitle:[NSString stringWithFormat:@"%zd",_currentPageNum] forState:UIControlStateNormal];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGContextSetGrayFillColor(ctx, 0.2, 0.6);
    
    //左半边圆弧
    CGContextAddArc(ctx,leftArcX ,height/2,leftArcRatio, M_PI/2, -M_PI/2, 1);
    //右半边圆弧
    CGContextAddArc(ctx, width-leftArcRatio, rect.size.height/2, leftArcRatio, -M_PI/2, M_PI/2, 0);
    
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
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{ NSFontAttributeName:[UIFont systemFontOfSize:10],
                           NSForegroundColorAttributeName:[UIColor grayColor],
                           NSParagraphStyleAttributeName: paragraph,
                           NSStrokeWidthAttributeName:@-3,
                           NSStrokeColorAttributeName:[UIColor orangeColor],
                           };
    
    CGFloat drawtextH = [UIFont systemFontOfSize:10].lineHeight;
    CGFloat drawtextX = leftArcRatio;
    CGFloat drawtextY = (height - drawtextH)/2;
    CGFloat drawtextW = width-leftArcRatio;
    
    CGRect textrectR = CGRectMake(drawtextX, drawtextY, drawtextW, drawtextH);
    NSString *drawtextR = [NSString stringWithFormat:@"of %zd",self.pagesNum];
    [drawtextR drawInRect:textrectR withAttributes:dic];
    
}


@end
