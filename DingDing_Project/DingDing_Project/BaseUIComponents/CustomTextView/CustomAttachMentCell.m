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
    [self.attachImage drawInRect:cellFrame];
}

- (NSSize)cellSize {
    return self.attachSize;
}
- (NSPoint)cellBaselineOffset {
    return self.baselineOffset;
}


@end
