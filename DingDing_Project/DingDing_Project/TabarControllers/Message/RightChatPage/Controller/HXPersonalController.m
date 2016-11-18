//
//  HXPersonalController.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXPersonalController.h"
#import "HXPrefixHeader.h"


@interface HXPersonalController ()

@end

@implementation HXPersonalController

- (void)loadView {
    [super loadView];
    
    [self.view backGroundColor:[NSColor grayColor]];
    self.view.layer.borderColor = [NSColor whiteColor].CGColor;
    self.view.layer.borderWidth = 5;
    
}

- (IBAction)confirm:(id)sender {
    
    NSPopover *popover = [[NSPopover alloc] init];
    
    [popover setContentSize:NSMakeSize(380, 300)];

    [popover setAnimates:NO];
    [popover setAppearance: NSPopoverAppearanceMinimal];

    NSButton *btn = sender;
    NSRect cellRect = [btn bounds];
    
    [popover showRelativeToRect:cellRect ofView:btn preferredEdge:NSRectEdgeMinY];
}


//- (void)mouseDown:(NSEvent *)event {
//    NSLog(@"%s",__func__);
//}
//
//- (void)mouseMoved:(NSEvent *)event {
//    NSLog(@"%s",__func__);
//}
@end
