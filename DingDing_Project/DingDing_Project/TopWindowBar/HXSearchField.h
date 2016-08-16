//
//  HXSearchField.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 16/8/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HXSearchField : NSView

@property (nonatomic, copy) NSString *placeHolderString;
- (void)resignFocus;

@end
