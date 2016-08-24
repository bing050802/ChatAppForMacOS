//
//  ViewController.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/9.
//  Copyright © 2016年 Babeltime. All rights reserved.
//

#import "ViewController.h"
#import "HXPrefixHeader.h"
@interface ViewController ()

@property (weak) IBOutlet NSView *cView;

@property (weak) IBOutlet NSLayoutConstraint *right;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
//    self.view.window.minSize = NSMakeSize(1048, 679);
    
//    NSSplitView 


}

- (void)viewWillAppear {
    [super viewWillAppear];
    [self.cView backGroundColor:[NSColor purpleColor]];
}


- (void)mouseDown:(NSEvent *)theEvent {
    
//    NSAnimationContext *animationContext = [NSAnimationContext currentContext];
//    animationContext.duration = 2.4;
//    animationContext.allowsImplicitAnimation = YES;
//    [NSAnimationContext beginGrouping];
//    
//    self.right.constant  = 0;
////    [self.cView displayIfNeeded];
//    
//    [NSAnimationContext endGrouping];
    
}




- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
