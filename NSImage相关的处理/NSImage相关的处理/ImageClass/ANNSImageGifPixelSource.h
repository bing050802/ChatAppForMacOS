//
//  ANNSImageGifPixelSource.h
//  GifPro
//
//  Created by Alex Nichol on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>


@interface ANNSImageGifPixelSource : NSObject  {
	NSBitmapImageRep * bitmapRep;
}

- (id)initWithImage:(NSImage *)anImage;

- (NSUInteger)pixelsWide;
- (NSUInteger)pixelsHigh;

- (void)getPixel:(NSUInteger *)pixel atX:(NSInteger)x y:(NSInteger)y;
- (BOOL)hasTransparency;

@end
