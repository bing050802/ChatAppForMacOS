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

//#import <>

@interface AppDelegate ()

@property (unsafe_unretained) IBOutlet HXTextView *textView;

@property (weak) IBOutlet NSTextField *textField;

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *imageView;

@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
//    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
//    attCell.attachImage = [NSImage imageNamed:@"haha@2x"];
//    attCell.attachSize = CGSizeMake(30, 30);
//    NSMutableAttributedString *attString = [NSMutableAttributedString attributedStringWithAttachmentCell:attCell];
//    
//    NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc] initWithString:@"我是刘强东微[/haha]博发声shi个好事刘强东微个"];
//    [mAttString appendAttributedString:attString];
//    
//    
////    [mAttString ]
//    
//    
//    
//    self.textView.textContainerInset = NSMakeSize(0, 10.0);
//    self.textView.drawsBackground = NO;
//    self.textView.font = [NSFont systemFontOfSize:14];
//    [self.textView insertText:mAttString replacementRange:NSMakeRange(0, 0)];
//    self.textView.editable = NO;
    
  
    
    [self textSWAttributedLabel];
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
