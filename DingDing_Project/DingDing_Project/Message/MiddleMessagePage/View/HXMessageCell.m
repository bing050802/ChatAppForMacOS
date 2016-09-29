//
//  HXMessageCell.m
//  DingDing_Project
//
//  Created by han on 2016/9/25.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMessageCell.h"
#import "HXPrefixHeader.h"
#import "HXBageView.h"

@interface HXMessageCell ()

@property (weak) IBOutlet NSImageView *iconImageView;

@property (weak) IBOutlet NSTextField *nameLabel;
@property (weak) IBOutlet NSTextField *timeLable;
@property (weak) IBOutlet NSTextField *msgLabel;

@property (weak) IBOutlet HXBageView *bageView;

@property (nonatomic,strong) NSTrackingArea *trackingArea;


@property (weak) IBOutlet NSButton *deleteBtn;



@end

@implementation HXMessageCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (NSTableRowView *)rowView {
    return (NSTableRowView *)self.superview;
}

- (NSTrackingArea *)trackingArea {
    if (!_trackingArea) {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
    }
    return _trackingArea;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self backGroundColor:[NSColor clearColor]];
//    self.backgroundStyle = NSBackgroundStyleDark;
    
    self.bageView.hidden = YES;
    [self addTrackingArea:self.trackingArea];
    
    // 按钮 去除高亮样式
    [self.deleteBtn.cell setHighlightsBy:NSNoCellMask];
    self.deleteBtn.hidden = YES;

}


// 点击最左边的 删除按钮
- (IBAction)deleteAction:(id)sender {
//    NSLog(@"deleteAction");
    [NotificationCenter postNotificationName:cellDeleteNotification object:self userInfo:nil];
}



- (void)mouseEntered:(NSEvent *)theEvent {
    self.deleteBtn.hidden = NO;
    if (self.rowView.selected) {
        // 当鼠标tracking 到已选中的cell的时候 ，不改变cell颜色
        return;
    }
    [self backGroundColor:HXColor(223, 236, 249)];
}

- (void)mouseExited:(NSEvent *)theEvent {
     self.deleteBtn.hidden = YES;
    [self backGroundColor:[NSColor clearColor]];
}


- (void)setMessage:(HXMessage *)message {
    _message = message;
    
    if (message.profile_image.length == 0) {
        self.bageView.bageValue = 10;
    }
    
    [self.iconImageView sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
    
    // 2014-10-30 18:07:47
    self.timeLable.stringValue = [message.create_time substringWithRange:NSMakeRange(message.create_time.length - 5, 5)];
    self.msgLabel.stringValue = message.text;
    
}

- (void)viewDidMoveToWindow {
     self.rowView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
}


- (void)setBackgroundStyle:(NSBackgroundStyle)backgroundStyle {
    if (self.rowView.selected) {
        self.bageView.bageValue = 0;
        // 选中状态下 清除cell的mouseEntered color
        [self backGroundColor:[NSColor clearColor]];

    }
}

@end
