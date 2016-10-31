//
//  AppDelegate.m
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "AppDelegate.h"
#import "SWAttributedLabel.h"
#import "CustomView.h"


#import "CustomAttachMentCell.h"
#import "HXTextView.h"

#import <CoreText/CoreText.h>


@interface AppDelegate ()

@property (unsafe_unretained) IBOutlet HXTextView *textView;

@property (weak) IBOutlet NSTextField *textField;

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *imageView;


@property (weak) IBOutlet NSLayoutConstraint *widthCns;
@property (weak) IBOutlet NSLayoutConstraint *heightCns;

@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    NSMutableAttributedString *mAttString = [NSMutableAttributedString parseFaceWordFromString:@"我是刘强东[hha]"];
    CGSize size = [mAttString singelineSize];
    
    NSLog(@"--%@",NSStringFromSize(size));
    
    
    self.widthCns.constant = size.width + 13 ;
    self.heightCns.constant = size.height + 2;
    self.textView.drawsBackground = NO;
    [self.textView insertText:mAttString replacementRange:NSMakeRange(0, 0)];
    self.textView.editable = NO;
    
//    [self textSWAttributedLabel];
}








- (void)pattarn {
    NSString *str = @"我戳，戳戳戳就是不破。很很牛牛比比，谁也不必聊，[哈哈]老师第一的，牛逼得很我曹很很[哈哈]牛比比，谁也不必聊，老师第一的，牛逼得[哈哈]我曹很很牛牛比比，谁也不必聊，老师第一的，牛逼得很我曹很很牛牛比比，谁也不必聊，老师第一的，牛逼得很我曹";
    NSString *patternStr = @"\\[\\w{0,100}\\]";
    NSRegularExpression *regs = [[NSRegularExpression alloc] initWithPattern:patternStr options:0 error:nil];
    NSArray *results = [regs matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    NSLog(@"%@",results);
    for (NSTextCheckingResult *match in results) {
        str = [str stringByReplacingCharactersInRange:match.range withString:@"黑"];
    }
    NSLog(@"%@",str);
}



- (void)testCustomView {
    CustomView *cview = [[CustomView alloc] init];
    cview.frame = CGRectMake(400, 300, 100, 100);
    [self.window.contentView addSubview:cview];
    self.imageView.image = [self swatchWithColor:[NSColor redColor] size:CGSizeMake(40, 40)];
}


- (void)textSWAttributedLabel {
    NSString *str = @"刘强东微[/haha]博发声shi个好事刘强东微[/haha]博发声刘强东微[/haha]";     // CGRectMake(10, 10, 200, 492)
    SWAttributedLabel *label = [[SWAttributedLabel alloc] initWithFrame:NSMakeRect(10, 10, 200, 492)];
    //    label.numberOfLines = 0;
    label.imageSize = CGSizeMake(35, 35);
    label.wantsLayer = YES;
    label.layer.backgroundColor = [NSColor orangeColor].CGColor;
    [label setText:str];
    NSLog(@"oneLineRealityWidth--%f",[label.attributedString oneLineRealityWidth]);
    NSLog(@"realityHeightForWidth--%f",[label.attributedString realityHeightForWidth:22]);
    NSLog(@"sizeThatFits--%@",NSStringFromSize([label textRealContantSize]));
    [self.window.contentView addSubview:label];
}

- (NSImage *)swatchWithColor:(NSColor *)color size:(NSSize)size {
    NSImage *image = [[NSImage alloc] initWithSize:size];
    [image lockFocus];
    [color drawSwatchInRect:NSMakeRect(0, 0, size.width, size.height)];
    [image unlockFocus];
    return image;
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
