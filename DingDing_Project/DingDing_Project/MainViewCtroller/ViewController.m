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
    [_cView backGroundColor:[NSColor redColor]];
    // Do any additional setup after loading the view.
}


- (void)mouseDown:(NSEvent *)theEvent {
    
    
    NSAnimationContext *animationContext = [NSAnimationContext currentContext];
    animationContext.duration = 3.0;
    
    
    [NSAnimationContext beginGrouping];
    self.view.needsUpdateConstraints = YES;
    self.right.constant = 50;
    [self.view updateConstraintsForSubtreeIfNeeded];
    
    [NSAnimationContext endGrouping];
    
}




- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
