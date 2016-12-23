//
//  ViewController.m
//  HXRefreshForMac
//
//  Created by hanxiaoqing on 2016/12/20.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "ViewController.h"
#import "HXScrollView.h"

@interface ViewController ()

@property (weak) IBOutlet HXScrollView *scrollView;

@end

@implementation ViewController

/*
 1.背景色
 self.scrollView.drawsBackground = NO;
 self.scrollView.backgroundColor= [NSColor purpleColor];
 
 设置drawsBackground = NO 背景色无效（默认是YES）
 
 2.为scrollView的contentView增加额外的滚动区域
 self.scrollView.contentView.automaticallyAdjustsContentInsets = NO;
 self.scrollView.contentView.contentInsets = NSEdgeInsetsMake(40, 0, 40, 0);
 
 3.控制鼠标滚轮滑动量
 @property CGFloat horizontalLineScroll;
 @property CGFloat verticalLineScroll;
 @property CGFloat lineScroll;
 lineScroll同时设置水平和数值滚动量
 
 4.放大scrollView的contentView的内容
 self.scrollView.allowsMagnification = YES;
 self.scrollView.magnification = 2;

 设置最小/最大放大倍数
 @property CGFloat maxMagnification;
 @property CGFloat minMagnification;

 // 制定rect矩形区域放大
 - (void)magnifyToFitRect:(NSRect)rect;
 // 围绕某个中心点放大
 - (void)setMagnification:(CGFloat)magnification centeredAtPoint:(NSPoint)point;
 
 6.增加流动的view（滚动内容的时候可竖直方向一直可见，也可以水平方向一直可见）
 NSView *dView = [[NSView alloc] init];
 dView.wantsLayer = YES;
 dView.layer.backgroundColor = [NSColor redColor].CGColor;
 [dView setFrameSize:CGSizeMake(50, 50)];
 [self.scrollView addFloatingSubview:dView forAxis:NSEventGestureAxisHorizontal];
 NSEventGestureAxisHorizontal //水平总可见
 NSEventGestureAxisVertical //竖直总可见
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];

//    CGSize bs = self.scrollView.documentView.bounds.size;
//    self.scrollView.documentView.bounds = CGRectMake(0, 40, bs.width, bs.height);
    
    NSImage *image = [NSImage imageNamed:@"test.png"];
    NSImageView *imageView = [[NSImageView alloc] init];
    [imageView setFrameSize:image.size];
    imageView.image = image;
    self.scrollView.documentView = imageView;
    
//    NSView *dView = [[NSView alloc] init];
//    [dView setFrameSize:image.size];
//    dView.wantsLayer = YES;
//    dView.layer.backgroundColor = [NSColor redColor].CGColor;
//    self.scrollView.documentView = dView;
    
    self.scrollView.contentView.automaticallyAdjustsContentInsets = NO;
//    self.scrollView.contentView.contentInsets = NSEdgeInsetsMake(40, 0, 40, 0);
    

}
- (IBAction)openInSafari:(id)sender {
    
    NSWorkspace *ws = [NSWorkspace sharedWorkspace];

   NSRunningApplication *rapp = [ws openURL:[NSURL URLWithString:@"http://www.baidu.com"] options:NSWorkspaceLaunchWithoutActivation configuration:nil error:NULL];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allNoti:) name:nil object:nil];
}

- (void)allNoti:(NSNotification *)noti {
    NSLog(@"--%@",noti);
}

- (void)viewDidAppear {
    [super viewDidAppear];
//   [self stringFromInsets:self.scrollView.contentView.contentInsets] 
    NSLog(@"--%@",NSStringFromRect(self.scrollView.documentView.frame));
    
    
    
    
//    - (nullable NSRunningApplication *)launchApplicationAtURL:(NSURL *)url options:(NSWorkspaceLaunchOptions)options configuration:(NSDictionary<NSString *, id> *)configuration error:(NSError **)error
}


- (NSString *)stringFromInsets:(NSEdgeInsets)insets {
    return [NSString stringWithFormat:@"top-%f,bottom-%f,left-%f,right-%f",insets.top,insets.bottom,insets.left,insets.right];
}



- (void)mouseDown:(NSEvent *)event {
    //     NSLog(@"--%@",NSStringFromRect(self.scrollView.bounds));
    //    [self.scrollView.contentView scrollPoint:CGPointMake(0, 0)];
    
    NSLog(@"--%f--%f",self.scrollView.horizontalLineScroll,self.scrollView.verticalLineScroll);
//    
//    CGRect bs = self.scrollView.contentView.bounds;
//    bs.origin.y = 400;
//    self.scrollView.contentView.bounds = bs;
    

}

- (void)viewFrameChanged:(NSNotification *)notification {
    
    
}
- (void)viewBoundsChanged:(NSNotification *)notification {
    
    
}


@end
