//
//  CustomAttachMentCell.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/10/20.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "CustomAttachMentCell.h"

@implementation CustomAttachMentCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(nullable NSView *)controlView {
    
    CGFloat controlViewH = NSHeight(controlView.frame);
    CGFloat cellX = cellFrame.origin.x;
    CGFloat cellW = cellFrame.size.width;
    CGFloat cellH = cellFrame.size.height;
    CGFloat cellY = (controlViewH - cellH) * 0.5;
    [self.attachImage drawInRect:CGRectMake(cellX, cellY, cellW, cellH)];
}

- (NSSize)cellSize {
    return self.attachSize;
}
//- (NSPoint)cellBaselineOffset {
//    return CGPointZero;
//}


@end
