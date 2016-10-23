//
//  CustomAttachMentCell.h
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/10/20.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "NSMutableAttributedString+AttachMent.h"

@interface CustomAttachMentCell : NSTextAttachmentCell

@property (nonatomic,strong) NSImage *attachImage;
@property (nonatomic,assign) CGSize attachSize;

@property (nonatomic,assign,readonly) NSTextAttachment *bulidAttachment;
@end
