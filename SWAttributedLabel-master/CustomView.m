//
//  CustomView.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/10/11.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@property (nonatomic,strong) NSButton *button;
@end


@implementation CustomView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSButton *button = [NSButton buttonWithTitle:@"按钮" target:self action:@selector(touch)];
//        [self addSubview:button];
//        self.button = button;
        
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor yellowColor].CGColor;
        
        NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                                    options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited | NSTrackingEnabledDuringMouseDrag
                                                                      owner:self
                                                                   userInfo:nil];
        [self addTrackingArea:trackingArea];
        
        
        
    }
    return self;
}
- (void)copyText:(id)sender {
    
}

- (NSMenu *)menuForEvent:(NSEvent *)event
{
    NSMenu *m = [[NSMenu alloc] initWithTitle:@""];
    
    {
        NSMenuItem *i = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Copy",nil) action:@selector(copyText:) keyEquivalent:@""];
        [i setKeyEquivalent:@"c"];
        [i setKeyEquivalentModifierMask:NSCommandKeyMask];
        [i setTarget:self];
        [m addItem:i];
        
    }
    
    return m;
}
- (void)mouseDragged:(NSEvent *)event {
     NSLog(@"mouseDragged");
    
}
- (void)mouseMoved:(NSEvent *)event {
    
   
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)touch {
//    [self setNeedsLayout:YES];

}

- (void)layout
{
    [super layout];
    
    self.button.frame = CGRectMake(5, 5, NSWidth(self.frame) - 10, NSHeight(self.frame) - 10);
    
    NSLog(@"layout");
    
}

@end
