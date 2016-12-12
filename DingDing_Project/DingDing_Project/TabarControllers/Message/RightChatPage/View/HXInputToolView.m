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

#import "RegexKitLite.h"
#import "HXSaveContact.h"
#import "HXContactListView.h"


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


@property (nonatomic,strong) NSMutableArray *peopleList;
@property (nonatomic,strong) HXContactListView *listView;




@end

@implementation HXInputToolView

- (NSMutableArray *)peopleList {
    if (!_peopleList) {
        _peopleList = [[NSMutableArray alloc] init];
        [_peopleList addObject:@"玄知枫"];
        [_peopleList addObject:@"李小将"];
        [_peopleList addObject:@"沐君勒"];
        [_peopleList addObject:@"吴原"];
        [_peopleList addObject:@"沐连勒"];
        [_peopleList addObject:@"宇凌司"];
        [_peopleList addObject:@"苏献宁"];
        [_peopleList addObject:@"乔汜枫"];
    }
    return _peopleList;
}


- (NSView *)listView {
    if (!_listView) {
        _listView = [HXContactListView loadXibContactListView];
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


- (void)configContacts {
    [HXSaveContact clearAll];
    if (![HXSaveContact savedCount]) {
        for (NSString *name in self.peopleList) {
            [HXSaveContact saveContact:name];
        }
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self configContacts];
    
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
        
        if(self.listView.superview == nil) {
            [self.delegate inputCompleteToSend:textView];
            self.sendButton.selected = NO;
        }
        else {
           // 记录一下所有的@人选
            [textView insertText:self.listView.selectName];
            [self.listView removeFromSuperview];
        }
        
        
        return YES;
    }
    if (commandSelector == @selector(moveLeft:) || commandSelector == @selector(moveRight:))
    {
        // 看一下是否有@选中的人员 把所有@+人名 当成一个字符处理
        return NO;
    }
    if (commandSelector == @selector(deleteBackward:))
    {
        // 看一下是否有@选中的人员 把所有@+人名 删除的时候当成一个字符处理
        return NO;
    }
    
    if (commandSelector == @selector(moveUp:) || commandSelector == @selector(moveDown:)) {
        
        return NO;
    }
    
    return NO;
}


/**
 鼠标光标位置改变时候就会调用（包括左移右移，文字增删改都会调用）
 */
- (void)textViewDidChangeSelection:(NSNotification *)notification
{
    NSTextView *textView = notification.object;
    
    // 取出鼠标光标前所有的文字
    NSString *stringBeforeCursor = [textView.string substringToIndex:textView.selectedRange.location];
    
    // 遍历文字中所有包含”@“字符的range
    NSMutableArray *elterRanges = [NSMutableArray array];
    [stringBeforeCursor enumerateStringsMatchedByRegex:@"@" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [elterRanges addObject:[NSValue valueWithRange:*capturedRanges]];
    }];
    
    if (elterRanges.count) {
        // 取出最后一个@（就是离光标最近的）的范围
        NSRange lastElterRange = [[elterRanges lastObject] rangeValue];
        
        // 在@位置展示一个过滤联系人列表
        [self contactListWithElterRange:lastElterRange];
        
        // @后面的过滤性关键字符
        NSString *filterString = [stringBeforeCursor substringFromIndex:lastElterRange.location + 1];
        [self startfilterWithPattern:filterString];
    }
    else {
        [self.listView removeFromSuperview];
    }
    
}





- (void)contactListWithElterRange:(NSRange)eRange
{
    NSRect rect = [self.inputTextView firstRectForCharacterRange:NSMakeRange(eRange.location, 1) actualRange:NULL];
    NSRect windowRect = [self.window  convertRectFromScreen:rect];
    self.listView.frame = CGRectMake(NSMinX(windowRect), NSMinY(windowRect) + 17, 30, 160);
    [self.window.contentView addSubview:self.listView];
}


- (void)startfilterWithPattern:(NSString *)string
{
    if (string.length == 0) {
        self.listView.contactsArray = [HXSaveContact selectAll];
        return;
    }
    self.listView.contactsArray = [HXSaveContact selectNameWithFilteString:string];
}


- (void)textDidChange:(NSNotification *)notification
{
    NSTextView *textView = notification.object;
    if (textView.string.length == 0) {
        self.sendButton.selected = NO;
    }
    else {
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
