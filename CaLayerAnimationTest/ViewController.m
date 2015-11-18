//
//  ViewController.m
//  CaLayerAnimationTest
//
//  Created by zhangyuhe on 15/11/16.
//  Copyright (c) 2015年 hanxiaoqing. All rights reserved.
//

#import "ViewController.h"
#import "DrawPageCtl.h"
@interface ViewController ()

@property (nonatomic,weak)CALayer *layer;
@property (nonatomic,weak)DrawPageCtl *pagectl;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    DrawPageCtl *pagectl = [[DrawPageCtl alloc] init];
    pagectl.leftCircleColor = [UIColor orangeColor];
    pagectl.frame = CGRectMake(100, 100,200, 40);
    //总页数
    pagectl.pagesNum = 10;
    pagectl.currentPageNum = 5;
    [self.view addSubview:pagectl];
    self.pagectl = pagectl;
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    static NSInteger i  = 0;
    self.pagectl.currentPageNum = i++;
    
}



- (void)emitterTest{
    
    CAEmitterCell *ecell = [CAEmitterCell emitterCell];
    // The number of emitted objects created every second
    ecell.birthRate = 1;
    // The lifetime of each emitted object in seconds
    ecell.lifetime  = 100;
    
    //粒子速度和速度的范围
    ecell.velocity = 10;
    ecell.velocityRange = 10;
    
    //粒子y方向的加速度分量
    ecell.yAcceleration = 2;
    
    //粒子刚出来的缩放大小，以及缩放速度，缩放范围
    ecell.scale = 0.3;
    ecell.scaleSpeed = 0.05;
    ecell.scaleRange = 0.2;
    
    //周围发射角度
    ecell.emissionRange = M_PI/2;
    //子旋转角度范围
    ecell.spinRange =  M_PI/4;
    
    //粒子颜色
    //    ecell.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:0.8] CGColor];
    //粒子内容
    ecell.contents = (id)[UIImage imageNamed:@"QQ20151117"].CGImage;
    
    
    
    CAEmitterCell *ecell1 = [CAEmitterCell emitterCell];
    
    ecell1.birthRate = 1;
    ecell1.lifetime = 100;
    
    ecell1.velocity = 10;
    ecell1.velocityRange = 20;
    
    ecell1.yAcceleration = 10;
    
    ecell1.emissionRange = M_PI/2;
    ecell1.spinRange = M_PI/4;
    
    ecell1.scale = 0.3;
    ecell1.scaleSpeed = 0.1;
    ecell1.scaleRange = 0.5;
    
    
    ecell1.contents = (id)[UIImage imageNamed:@"QQ20151118"].CGImage;
    
    
    CAEmitterLayer *elayer = [CAEmitterLayer layer];
    //粒子发射位置
    elayer.emitterPosition = CGPointMake(100, 100);
    //粒子发射大小
    elayer.emitterSize = CGSizeMake(30, 15);
    //粒子发射模式
    elayer.emitterMode = kCAEmitterLayerVolume;
    //粒子发射形状
    elayer.emitterShape = kCAEmitterLayerCircle;
    
    elayer.emitterCells = @[ecell1,ecell];
    
    [self.view.layer addSublayer:elayer];
    

    
}


@end
