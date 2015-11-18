//
//  DrawLable.h
//  CaLayerAnimationTest
//
//  Created by hanxiaoqing on 15/11/16.
//  Copyright (c) 2015年 hanxiaoqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPageCtl : UIView

//总页数
@property (nonatomic,assign) NSInteger pagesNum;
//当前页数
@property (nonatomic,assign) NSInteger currentPageNum;


//左边翻转小球的颜色
@property (nonatomic,strong) UIColor  *leftCircleColor;
@end
