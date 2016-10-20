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

@interface AppDelegate ()

@property (weak) IBOutlet NSTextField *textField;

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *imageView;

@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
    attCell.attachImage = [NSImage imageNamed:@"haha@2x"];
    attCell.attachSize = CGSizeMake(20, 20);
    NSMutableAttributedString *attString = [NSMutableAttributedString attributedStringWithAttachmentCell:attCell];

    NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc] initWithString:@"我是个"];
    [mAttString appendAttributedString:attString];
    
    self.textField.attributedStringValue = mAttString;

    
//    CGRect boundingRect = self.textField.font.boundingRectForFont;
//    CGFloat pointSize = self.textField.font.pointSize;
//    NSSize maximumAdvancement = self.textField.font.maximumAdvancement;
    
    
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
