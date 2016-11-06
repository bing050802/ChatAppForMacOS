//
//  HXInputToolView.h
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/11/3.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol InputToolViewDelegate <NSObject>

- (void)toolViewSelect:(NSInteger)tag;
- (void)inputCompleteToSend:(NSTextView *)textView;

@end

@interface HXInputToolView : NSView

+ (HXInputToolView *)loadXibInputView;

@property (nonatomic,weak) id <InputToolViewDelegate> delegate;

@end
