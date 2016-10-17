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

@interface AppDelegate ()
@property (weak) IBOutlet NSTextField *textField;

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *imageView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    刘强东微[/haha]博发声刘强东微[/haha]
    NSString *str = @"刘强东微[/haha]博发声shi个好事刘强东微[/haha]博发声刘强东微[/haha]";     // CGRectMake(10, 10, 200, 492)
    SWAttributedLabel *label = [[SWAttributedLabel alloc] initWithFrame:NSMakeRect(10, 10, 200, 492)];
//    label.numberOfLines = 0;
    label.imageSize = CGSizeMake(35, 35);
    label.wantsLayer = YES;
    label.layer.backgroundColor = [NSColor orangeColor].CGColor;
    [label setText:str];
//    label.
    NSLog(@"oneLineRealityWidth--%f",[label.attributedString oneLineRealityWidth]);
    NSLog(@"realityHeightForWidth--%f",[label.attributedString realityHeightForWidth:22]);
    NSLog(@"sizeThatFits--%@",NSStringFromSize([label textRealContantSize]));
    
    [self.window.contentView addSubview:label];
    
    
    
    CustomView *cview = [[CustomView alloc] init];
    cview.frame = CGRectMake(400, 300, 100, 100);
    [self.window.contentView addSubview:cview];
    
    
//    
//    self.textField.stringValue = @"fdsafdasfasdfasdfasdf";
////    self.textField.editable = YES;
//     self.textField.selectable = YES;
    
    self.imageView.image = [self swatchWithColor:[NSColor redColor] size:CGSizeMake(40, 40)];
    

    
    
    
}


- (NSImage *)swatchWithColor:(NSColor *)color size:(NSSize)size
{
    NSImage *image = [[NSImage alloc] initWithSize:size];
    [image lockFocus];
    [color drawSwatchInRect:NSMakeRect(0, 0, size.width, size.height)];
    [image unlockFocus];
    return image;
}

- (NSImage *)normalize
{
    
    
    int width = 40;
    int height = 40;
    
//    [[NSBitmapImageRep alloc]
//     initWithBitmapDataPlanes: NULL
//     pixelsWide: width
//     pixelsHigh: height
//     bitsPerSample: 8
//     samplesPerPixel: 4
//     hasAlpha: YES
//     isPlanar: NO
//     colorSpaceName: NSDeviceRGBColorSpace
//     bytesPerRow: 0
//     bitsPerPixel: 0]
    NSBitmapImageRep *rep =[[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, width, height)] ;
    
    NSGraphicsContext *nsContext = [NSGraphicsContext graphicsContextWithBitmapImageRep:rep];
    CGContextRef     thumbBitmapCtxt  = nsContext.CGContext;
    
    
//
//    CGColorSpaceRef genericColorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef thumbBitmapCtxt = CGBitmapContextCreate(NULL,
//                                                         width,
//                                                         height,
//                                                         8, (4 * width),
//                                                         genericColorSpace,
//                                                         (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
//    CGColorSpaceRelease(genericColorSpace);
    CGContextSetInterpolationQuality(thumbBitmapCtxt, kCGInterpolationDefault);
    CGRect destRect = CGRectMake(0, 0, width, height);
    
    CGContextSetStrokeColorWithColor(thumbBitmapCtxt, [NSColor redColor].CGColor);
    
    
    
    CGImageRef tmpThumbImage = CGBitmapContextCreateImage(thumbBitmapCtxt);
    CGContextRelease(thumbBitmapCtxt);
    NSImage *result = [[NSImage alloc] initWithCGImage:tmpThumbImage size:destRect.size];
    CGImageRelease(tmpThumbImage);
    
    return result;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
