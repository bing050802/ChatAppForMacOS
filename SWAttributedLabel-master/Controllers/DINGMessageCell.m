//
//  DINGMessageCell.m
//  CNGridView Example
//
//  Created by hanxiaoqing on 2016/11/17.
//  Copyright © 2016年 cocoa:naut. All rights reserved.
//

#import "DINGMessageCell.h"

@implementation DINGMessageCell

+ (DINGMessageCell *)loadXibLeftToolBar {
    NSArray *viewsArray;
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"DINGMessageCell" bundle:nil];
    [nib instantiateWithOwner:self topLevelObjects:&viewsArray];
    for (NSView *view in viewsArray) {
        if ([view isKindOfClass:[self class]]) {
            return (DINGMessageCell *)view;
        }
    }
    return nil;
}

@end
