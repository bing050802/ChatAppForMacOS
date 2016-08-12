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
    
    
//
//    NSViewNotSizable			=  0,
//    NSViewMinXMargin			=  1,
//    NSViewWidthSizable			=  2,
//    NSViewMaxXMargin			=  4,
//    NSViewMinYMargin			=  8,
//    NSViewHeightSizable			= 16,
//    NSViewMaxYMargin			= 32
    
    HXSearchField *searchField = [[HXSearchField alloc] initWithFrame:NSMakeRect(newWindow.frame.size.width * 2 - 200 * 2, 0, 180, 33)];
//    searchField.autoresizingMask =  NSViewMinYMargin | NSViewWidthSizable ;
    searchField.placeHolderString = @"联系人,群组,聊天记录";
    [self addSubview:searchField];
    self.searchField = searchField;
    

    [self.searchField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [self.searchField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:100];
    [self.searchField autoSetDimension:ALDimensionHeight toSize:33];
    [self.searchField autoSetDimension:ALDimensionWidth toSize:180];
    
//        NSLog(@"%@",NSStringFromRect());
    
//         NSLog(@"%@",);
}


- (void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    
    //

    
    
}



- (void)mouseDown:(NSEvent *)theEvent {

    [self.searchField resignFocus];

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
