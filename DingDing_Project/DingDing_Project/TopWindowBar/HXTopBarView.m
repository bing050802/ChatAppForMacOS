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
    
}


- (void)viewWillMoveToWindow:(nullable NSWindow *)newWindow {
    [super viewWillMoveToWindow:newWindow];
    
    HXSearchField *searchField = [[HXSearchField alloc] init];
    searchField.placeHolderString = @"联系人,群组,聊天记录";
    [self addSubview:searchField];
    self.searchField = searchField;
    

    [self.searchField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
     self.searchField.rightConstrinat = [self.searchField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:55];
    [self.searchField autoSetDimension:ALDimensionHeight toSize:32];
     self.searchField.widthConstrinat = [self.searchField autoSetDimension:ALDimensionWidth toSize:210];

}



- (void)mouseDown:(NSEvent *)theEvent {
    [self.searchField resignFocus];
}


- (void)mouseDragged:(NSEvent *)theEvent {
    
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
