/*
 * Copyright (c) 2013 Kyle W. Banks
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  AsyncImageDownloader.m
//
//  Created by Kyle Banks on 2012-11-29.
//  Modified by Nicolas Schteinschraber 2013-05-30
//

#import "AsyncImageDownloader.h"
#import "NSImage+BitmapRep.h"

@implementation AsyncImageDownloader

@synthesize mediaURL, fileURL ,fileData;

-(id)initWithMediaURL:(NSString *)theMediaURL successBlock:(void (^)(NSImage *image))success failBlock:(void(^)(NSError *error))fail
{
    self = [super init];
    
    if(self)
    {
        [self setMediaURL:theMediaURL];
        [self setFileURL:nil];
        successCallback = success;
        failCallback = fail;
    }
    
    return self;
}
-(id)initWithFileURL:(NSString *)theFileURL successBlock:(void (^)(NSData *data))success failBlock:(void(^)(NSError *error))fail
{
    self = [super init];
    
    if(self)
    {
        [self setMediaURL:nil];
        [self setFileURL:theFileURL];
        successCallbackFile = success;
        failCallback = fail;
    }
    
    return self;
}

//Perform the actual download
-(void)startDownload
{
    fileData = [[NSMutableData alloc] init];
    
    NSURLRequest *request = nil;
    if (fileURL)
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileURL]];
    else
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:mediaURL]];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if(!connection)
    {
        failCallback([NSError errorWithDomain:@"Failed to create connection" code:0 userInfo:nil]);
    }
}

#pragma mark NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    failCallback(error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if([response respondsToSelector:@selector(statusCode)])
    {
        long statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400)
        {
            [connection cancel];
            failCallback([NSError errorWithDomain:@"Image download failed due to bad server response" code:0 userInfo:nil]);
        }
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [fileData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    if(fileData == nil)
    {
        failCallback([NSError errorWithDomain:@"No data received" code:0 userInfo:nil]);
    }
    else
    {
        if (fileURL) {
            successCallbackFile(fileData);
        } else {
            
            NSLog(@"----压缩前的大小%zd",fileData.length);
            NSImage *image = [[NSImage alloc] initWithDataIgnoringOrientation:fileData];
            NSString *imageContentType = [self sd_contentTypeForImageData:fileData];
            if ([imageContentType isEqualToString:@"image/gif"]) {
                successCallback(image);
            } else {
                successCallback([self decodeImageData:fileData]);
            }
           
        }
    }    
}

- (NSString *)sd_contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return nil;
    }
    return nil;
}



- (NSImage *)decodeImageData:(NSData *)image {
    NSData *imageData = [self dataForType:(NSString *)kUTTypeJPEG compression:0.8 image:image];
    NSLog(@"----压缩后的大小%zd",imageData.length);
    return [[NSImage alloc] initWithDataIgnoringOrientation:imageData];
}



- (NSData *)dataForType:(NSString *)type compression:(CGFloat)compressionQuality image:(NSData *)image {
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)image, NULL);

    NSMutableData *mutableData = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)mutableData, (__bridge CFStringRef)type, 1, NULL);
    
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:compressionQuality], kCGImageDestinationLossyCompressionQuality, nil];
    
    CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef)properties);
    
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
    return mutableData;
}




// 暂无价值 但具有参考价值
- (NSImage *)sd_animatedGIFWithData:(NSData *)data {
    
    __block NSImage *animatedImage;
    dispatch_queue_t queue = dispatch_queue_create("com.ziofrtiz.exporter", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    
    if (count <= 1) {
        animatedImage = [[NSImage alloc] initWithData:data];
    } else {
    
        NSMutableData *mutableData = [NSMutableData data];
        CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)mutableData, kUTTypeGIF, count, NULL);
        

        NSDictionary *frameProperties = @{(NSString *)kCGImagePropertyGIFDictionary : @{(NSString *)kCGImagePropertyGIFDelayTime : @(1.0 / 12.0)}};
        NSDictionary *gifProperties = @{(NSString *)kCGImagePropertyGIFDictionary : @{(NSString *)kCGImagePropertyGIFLoopCount : @0}};
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!imageRef) {
                continue;
            }
            CGImageDestinationAddImage(destination, imageRef, (__bridge CFDictionaryRef)frameProperties);
            CFRelease(imageRef);
            
        }
        
        CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperties);
        CGImageDestinationFinalize(destination);
        CFRelease(destination);
            

        dispatch_sync(dispatch_get_main_queue(), ^{
            animatedImage = [[NSImage alloc] initWithData:mutableData];
            successCallback(animatedImage);
        });
        
    }
      CFRelease(source);
   
    });
     return animatedImage;
}





@end
