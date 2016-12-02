//
//  HXInputToolView.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/11/3.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXInputToolView.h"
#import "HXPrefixHeader.h"
#import "HXButton.h"
#import "HXTextView.h"


@interface HXInputToolView () <NSTextViewDelegate>

@property (weak) IBOutlet HXButton *attchBtn;
@property (weak) IBOutlet HXButton *faceBtn;
@property (weak) IBOutlet HXButton *aiteBtn;
@property (weak) IBOutlet HXButton *dingFileBtn;
@property (weak) IBOutlet HXButton *cutBtn;
@property (weak) IBOutlet HXButton *mingPianBtn;
@property (weak) IBOutlet HXButton *zanBtn;

@property (unsafe_unretained) IBOutlet HXTextView *inputTextView;

@property (weak) IBOutlet HXButton *sendButton;


@property (nonatomic,strong) NSView *listView;



@end

@implementation HXInputToolView

- (NSView  *)listView {
    if (!_listView) {
        _listView = [[NSView alloc] init];
        _listView.wantsLayer = YES;
        _listView.layer.backgroundColor = [NSColor redColor].CGColor;
    }
    return _listView;
}



+ (HXInputToolView *)loadXibInputView
{
    NSArray *viewsArray;
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"HXInputToolView" bundle:nil];
    [nib instantiateWithOwner:self topLevelObjects:&viewsArray];
    for (NSView *view in viewsArray) {
        if ([view isKindOfClass:[self class]]) {
            return (HXInputToolView *)view;
        }
    }
    return nil;
}

- (void)inputViewButtonsSetting
{
    [self settingWithImageName:@"attach" btn:self.attchBtn tag:100];
    [self settingWithImageName:@"face" btn:self.faceBtn tag:101];
    [self settingWithImageName:@"aite" btn:self.aiteBtn tag:102];
    [self settingWithImageName:@"file" btn:self.dingFileBtn tag:103];
    [self settingWithImageName:@"cut" btn:self.cutBtn tag:104] ;
    [self settingWithImageName:@"mingPian" btn:self.mingPianBtn tag:105];
    [self settingWithImageName:@"zan" btn:self.zanBtn tag:106];
}


- (void)settingWithImageName:(NSString *)name btn:(HXButton *)btn tag:(NSInteger)tag
{
    btn.trackingEabled = YES;
    btn.tag = tag;
    [btn setImage:[NSImage imageNamed:name] forState:NSControlStateNormal];
    [btn setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@_entered",name]] forState:NSControlStateMouseIn];
    btn.target = self;
    btn.action = @selector(buttonClick:);
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [NotificationCenter addObserver:self selector:@selector(emotionSelect:) name:EmotionSelectNotification object:nil];
    
    [self backGroundColor:HXColor(245, 249, 255)];

    self.inputTextView.drawsBackground = NO;
    self.inputTextView.textContainerInset = NSMakeSize(0, 10.0);
    self.inputTextView.borderWidth = 0;
    self.inputTextView.textViewBgColor = [NSColor clearColor];
    self.inputTextView.font = [NSFont systemFontOfSize:14.0];
    self.inputTextView.textColor = HXColor(70, 70, 70);
    self.inputTextView.delegate = self;

    self.sendButton.titleEdgeInsets = NSEdgeInsetsMake(0, 25, 0, 0);
    self.sendButton.titleFont = [NSFont systemFontOfSize:13];
    [self.sendButton setTitleColor:[NSColor lightGrayColor] forState:NSControlStateNormal];
    [self.sendButton setTitleColor:HXColor(25, 132, 230) forState:NSControlStateSelected];
    [self.sendButton setTitle:@"发送" forState:NSControlStateNormal];
    [self.sendButton setBackgroundColor:[NSColor whiteColor] forState:NSControlStateNormal];
    self.sendButton.target = self;
    self.sendButton.action = @selector(send);

}



- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector
{
    if (commandSelector == @selector(insertNewline:)) {
        if (!textView.string.length) return YES;
        [self.delegate inputCompleteToSend:textView];
        self.sendButton.selected = NO;
        return YES;
    }
    if (commandSelector == @selector(moveLeft:) || commandSelector == @selector(moveRight:)) {

        if (textView.selectedRange.location <= textView.string.length) {
//            [view removeFromSuperview];
        }
        // 得到光标前一个字符
        
        // 如果光标移动中碰到@ 就显示popver菜单
        
        return NO;
    }
    if (commandSelector == @selector(deleteBackward:)) {
        
//        NSLog(@"------%@",NSStringFromRange(textView.selectedRange));
        
        return NO;
    }
    
    
    return NO;
}


/*
 
 NSString *old = [textView.string substringFromIndex:affectedCharRange.location];
 //    NSLog(@"old------%@",old);
 
 if ([textView.string rangeOfString:@"@"].location != NSNotFound && self.listView)  {
 [self.listView removeFromSuperview];
 }
 
 if ([old isEqualToString:@"@"]) {
 [self.listView removeFromSuperview];
 }
 
 
 */
- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(nullable NSString *)replacementString {
    
    // 当删除的时候 replacementString = nil
    
    NSLog(@"new------%@",replacementString);
    // 第一步：实现任意位置输入@弹出框展示所有的人员列表
    if ([replacementString isEqualToString:@"@"]) {
        NSRange range;
        NSRect rect = [textView firstRectForCharacterRange:NSMakeRange(affectedCharRange.location, 1) actualRange:&range];
        NSRect windowRect = [self.window  convertRectFromScreen:rect];
        self.listView.frame = CGRectMake(NSMinX(windowRect), NSMinY(windowRect) + 17, 30, 160);
        [self.window.contentView addSubview:self.listView];
    }
    
    // 判断是否是输入@之后接着再输入的
    // 得到新插入字符的前一个字符
    NSString *beforeCurorChar;
    if (textView.string.length > 0 ) {
        beforeCurorChar = [textView.string substringWithRange:NSMakeRange(textView.selectedRange.location - 1, 1)];
    }
    NSLog(@"beforeCurorChar------%@",beforeCurorChar);
    
    // 如果显示列表之后，继续输入，则进入过滤模式，根据新加入的字符串，过滤人名
    [self startfilterWithPattern:replacementString];
    
    
    
    
    
    //    NSLog(@"------%@",NSStringFromRange(affectedCharRange));
    return YES;
}


- (void)startfilterWithPattern:(NSString *)string  {
    

}



- (void)textDidChange:(NSNotification *)notification {

    if (self.inputTextView.string.length == 0) {
        self.sendButton.selected = NO;
    } else {
        self.sendButton.selected = YES;
    }
    
}

- (void)send
{
    if (!self.inputTextView.string.length) return;
    [self.delegate inputCompleteToSend:self.inputTextView];
    self.sendButton.selected = NO;
}


- (void)buttonClick:(HXButton *)sender
{
    [self.delegate toolViewSelect:sender.tag];
}

- (void)emotionSelect:(NSNotification *)noti
{
    [self.inputTextView insertText:noti.object];
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (hidden == NO) {
        [self inputViewButtonsSetting];
    }
}

@end
