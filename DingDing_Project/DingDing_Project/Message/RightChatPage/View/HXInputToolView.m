//
//  HXInputToolView.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/11/3.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXInputToolView.h"
#import "HXPrefixHeader.h"
#import "HXBarButton.h"
#import "HXTextView.h"


@interface HXInputToolView ()

@property (weak) IBOutlet HXBarButton *attchBtn;
@property (weak) IBOutlet HXBarButton *faceBtn;
@property (weak) IBOutlet HXBarButton *aiteBtn;
@property (weak) IBOutlet HXBarButton *dingFileBtn;
@property (weak) IBOutlet HXBarButton *cutBtn;
@property (weak) IBOutlet HXBarButton *mingPianBtn;
@property (weak) IBOutlet HXBarButton *zanBtn;

@property (unsafe_unretained) IBOutlet HXTextView *inputTextView;


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


- (void)settingWithImageName:(NSString *)name btn:(HXBarButton *)btn {
    btn.trackingEabled = YES;
    btn.cell.highlightsBy = NSNoCellMask;
    [btn setImage:[NSImage imageNamed:name] forState:ButtonStateNormal];
    [btn setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@_entered",name]] forState:ButtonStateMouseIn];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self backGroundColor:HXColor(245, 249, 255)];
    [self inputViewButtonsSetting];
    
    self.inputTextView.drawsBackground = NO;
    self.inputTextView.textContainerInset = NSMakeSize(0, 10.0);
    self.inputTextView.borderWidth = 0;
    self.inputTextView.textViewBgColor = [NSColor clearColor];
    self.inputTextView.font = [NSFont systemFontOfSize:14.0];
    self.inputTextView.textColor = HXColor(70, 70, 70);
    
    
    NSLog(@"---%@",self.subviews);
    //    [self backGroundColor:[NSColor redColor]];
}


- (IBAction)buttonClick:(HXBarButton *)sender {
    
       NSLog(@"---%zd",sender.tag);
}




@end
