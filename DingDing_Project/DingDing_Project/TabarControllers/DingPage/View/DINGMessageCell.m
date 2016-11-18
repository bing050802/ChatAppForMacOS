//
//  DINGMessageCell.m
//  CNGridView Example
//
//  Created by hanxiaoqing on 2016/11/17.
//  Copyright © 2016年 cocoa:naut. All rights reserved.
//

#import "DINGMessageCell.h"
#import "HXButton.h"

#define HXColor(r, g, b) [NSColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface DINGMessageCell ()

@property (weak) IBOutlet NSScrollView *textScrollView;

@property (weak) IBOutlet HXButton *nameBtn;

@property (weak) IBOutlet HXButton *lookDetailBtn;

@end

@implementation DINGMessageCell

- (DINGMessageCell *)loadCell {
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


- (id)initWithLayout:(CNGridViewItemLayout *)layout reuseIdentifier:(NSString *)reuseIdentifier {
    layout.backgroundColor = [NSColor whiteColor];
    return  [super initWithLayout:layout reuseIdentifier:reuseIdentifier];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self loadCell];
    
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_textScrollView setVerticalLineScroll:0.0];
    [_textScrollView setVerticalPageScroll:0.0];
    
    self.nameBtn.trackingEabled = YES;
    [self.nameBtn setTitleColor:HXColor(111, 195, 253) forState:NSControlStateNormal];
    [self.nameBtn setTitleColor:HXColor(85, 183, 252) forState:NSControlStateMouseIn];
    [self.nameBtn setTitle:@"张三" forState:0];
    
    self.lookDetailBtn.trackingEabled = YES;
    self.lookDetailBtn.titleEdgeInsets = NSEdgeInsetsMake(0, 30, 0, 0);
    self.lookDetailBtn.imageEdgeInsets = NSEdgeInsetsMake(0, 0, 0, 200);
    
    [self.lookDetailBtn setTitleColor:[NSColor grayColor] forState:NSControlStateNormal];
    [self.lookDetailBtn setTitleColor:HXColor(85, 183, 252) forState:NSControlStateMouseIn];
    [self.lookDetailBtn setImage:[NSImage imageNamed:@"detail"] forState:NSControlStateNormal];
    [self.lookDetailBtn setImage:[NSImage imageNamed:@"detail_in"] forState:NSControlStateMouseIn];
    [self.lookDetailBtn setTitle:@"点击到详情页回复" forState:NSControlStateNormal];
    
}

- (IBAction)nameClick:(HXButton *)sender {
}


- (IBAction)detailClick:(id)sender {
    
}



@end
