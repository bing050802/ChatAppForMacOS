//
//  HXTopBarView.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXTopBarView.h"

#import "HXPrefixHeader.h"
#import <objc/runtime.h>
#import "MVGraphicsFunctions.h"
#import "HXSearchField.h"



@interface HXTopBarView ()

@property (nonatomic, strong) HXSearchField *searchField;

@end

@implementation HXTopBarView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (void)viewWillMoveToWindow:(nullable NSWindow *)newWindow {
    [super viewWillMoveToWindow:newWindow];
    

    
    HXSearchField *searchField = [[HXSearchField alloc] initWithFrame:NSMakeRect(100, 20, 200, 30)];
    searchField.placeHolderString = @"我爱他妈";
    [self addSubview:searchField];
    self.searchField = searchField;
    
    
}

- (void)mouseDown:(NSEvent *)theEvent {

    NSLog(@"%@",self.searchField.textfield.subviews);
    
    [self.searchField resignFocus];
    
    NSLog(@"%@",self.searchField.textfield.subviews);

    
}


- (void)mouseDragged:(NSEvent *)theEvent
{
    NSWindow *window = self.window;
    if (window.isMovableByWindowBackground || (window.styleMask & NSFullScreenWindowMask) == NSFullScreenWindowMask) {
        [super mouseDragged:theEvent];
        return;
    }
    
    NSPoint where = [window convertRectToScreen:NSMakeRect(theEvent.locationInWindow.x, theEvent.locationInWindow.y, 0, 0)].origin;
    NSPoint origin = window.frame.origin;
    CGFloat deltaX = 0.0;
    CGFloat deltaY = 0.0;
    while ((theEvent = [NSApp nextEventMatchingMask:NSLeftMouseDownMask | NSLeftMouseDraggedMask | NSLeftMouseUpMask untilDate:[NSDate distantFuture] inMode:NSEventTrackingRunLoopMode dequeue:YES]) && (theEvent.type != NSLeftMouseUp)) {
        @autoreleasepool {
            NSPoint now = [window convertRectToScreen:NSMakeRect(theEvent.locationInWindow.x, theEvent.locationInWindow.y, 0, 0)].origin;
            deltaX += now.x - where.x;
            deltaY += now.y - where.y;
            if (fabs(deltaX) >= 1 || fabs(deltaY) >= 1) {
                // This part is only called if drag occurs on container view!
                origin.x += deltaX;
                origin.y += deltaY;
                window.frameOrigin = origin;
                deltaX = 0.0;
                deltaY = 0.0;
            }
            where = now; // this should be inside above if but doing that results in jittering while moving the window...
        }
    }
}

@end
