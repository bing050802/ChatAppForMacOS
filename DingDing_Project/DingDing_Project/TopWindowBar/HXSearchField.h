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
@property (nonatomic, strong) NSLayoutConstraint *widthConstrinat;

@property (nonatomic, strong) NSLayoutConstraint *rightConstrinat;

@end



typedef void(^clearInput)();

@interface NOHighlightBtn : NSButton

@property (nonatomic, strong) NSImage *normalImage;
@property (nonatomic, strong) NSImage *mouseinImage;
@property (nonatomic, assign) BOOL mouseinState;

@end


@interface HXSearchButton : NSView

@property (nonatomic, strong) NOHighlightBtn *seekBtn;

@property (nonatomic, strong) NOHighlightBtn *clearBtn;
@property (nonatomic, copy) clearInput clearInputBlock;

@property (nonatomic, strong) NSTrackingArea *trackingArea;


@end