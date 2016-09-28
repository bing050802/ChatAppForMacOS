//
//  NSImage+StackBlur.h
//  NeteaseMusic
//
//  Created by han on 3/3/15.
//  Copyright (c) 2015 openthread. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (StackBlur)

- (NSImage *)stackBlur:(int)inradius;

- (NSImage *)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(NSColor *)borderColor size:(CGSize)size;
@end
