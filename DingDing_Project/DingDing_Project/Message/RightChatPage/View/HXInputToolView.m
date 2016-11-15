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

@end

@implementation HXInputToolView 

+ (HXInputToolView *)loadXibInputView {
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

- (void)inputViewButtonsSetting {
    [self settingWithImageName:@"attach" btn:self.attchBtn];
    [self settingWithImageName:@"face" btn:self.faceBtn];
    [self settingWithImageName:@"aite" btn:self.aiteBtn];
    [self settingWithImageName:@"file" btn:self.dingFileBtn];
    [self settingWithImageName:@"cut" btn:self.cutBtn];
    [self settingWithImageName:@"mingPian" btn:self.mingPianBtn];
    [self settingWithImageName:@"zan" btn:self.zanBtn];
}


- (void)settingWithImageName:(NSString *)name btn:(HXButton *)btn {
    btn.trackingEabled = YES;
    [btn setImage:[NSImage imageNamed:name] forState:NSControlStateNormal];
    [btn setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@_entered",name]] forState:NSControlStateMouseIn];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    [NotificationCenter addObserver:self selector:@selector(emotionSelect:) name:EmotionSelectNotification object:nil];
    
    [self backGroundColor:HXColor(245, 249, 255)];
    [self inputViewButtonsSetting];
    
    self.inputTextView.drawsBackground = NO;
    self.inputTextView.textContainerInset = NSMakeSize(0, 10.0);
    self.inputTextView.borderWidth = 0;
    self.inputTextView.textViewBgColor = [NSColor clearColor];
    self.inputTextView.font = [NSFont systemFontOfSize:14.0];
    self.inputTextView.textColor = HXColor(70, 70, 70);
    self.inputTextView.delegate = self;
    
//    self.sendButton.title = @"发送";
//    [self.sendButton setBackgroundColor:[NSColor redColor] forState:ButtonStateNormal];
//    [self.sendButton setBackgroundColor:[NSColor whiteColor] forState:ButtonStateSelected];
//    [self.sendButton setTitleColor:[NSColor redColor] forState:ButtonStateNormal];
//    [self.sendButton setTitleColor:HXColor(25, 132, 230) forState:ButtonStateSelected];



//    NSLog(@"---%@",self.subviews);
    //    [self backGroundColor:[NSColor redColor]];
}


- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
    
    if (commandSelector == @selector(insertNewline:)) {
        if (!textView.string.length) return YES;
        [self.delegate inputCompleteToSend:textView];
        return YES;
    }
    return NO;
}


- (IBAction)buttonClick:(HXButton *)sender {
    [self.delegate toolViewSelect:sender.tag];
}

- (void)emotionSelect:(NSNotification *)noti {
    [self.inputTextView insertText:noti.object];
}


@end
