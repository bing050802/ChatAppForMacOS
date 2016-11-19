
//
//  DINGViewController.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/16.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "DINGViewController.h"
#import "HXPrefixHeader.h"
#import "HXButton.h"
#import "HXDingMessageItem.h"

//https://www.raywenderlich.com/120494/collection-views-os-x-tutorial

static NSString *kContentTitleKey, *kContentImageKey, *kItemSizeSliderPositionKey;

@interface DINGViewController () <NSCollectionViewDelegate>


@property (strong) NSMutableArray *items;


@property (weak) IBOutlet HXButton *testBtn;

@property (weak) IBOutlet NSCollectionView *collectionView;

@property (weak) IBOutlet NSTextField *titleLabel;


@property (weak) IBOutlet HXButton *myShouBtn;

@property (weak) IBOutlet HXButton *mySendBtn;
@property (nonatomic,strong) HXButton *lastBtn;

@end

@implementation DINGViewController



- (void)loadView {
    [super loadView];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor colorWithRed:248/255.0 green:251/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    self.testBtn.trackingEabled = YES;
    [self.testBtn setImage:[NSImage imageNamed:@"dingBtn"] forState:NSControlStateNormal];
    [self.testBtn setImage:[NSImage imageNamed:@"dingBtn_in"] forState:NSControlStateMouseIn];
    
    self.collectionView.wantsLayer = YES;
    self.collectionView.layer.backgroundColor = [NSColor redColor].CGColor;
    
    HXDingMessageItem *item = [[HXDingMessageItem alloc] initWithNibName:@"HXDingMessageItem" bundle:nil];
    CGSize itemSize = NSMakeSize(285, 160);
    [_collectionView setMaxItemSize:itemSize];
    [_collectionView setMinItemSize:itemSize];
    
    self.collectionView.itemPrototype = item;
    self.collectionView.content = @[@"dfa",@"faf",@"dfa",@"dfa",@"dfa",@"dfa",@"dfa",@"dfa"];
    self.collectionView.backgroundColors = @[[NSColor clearColor],[NSColor clearColor]];
        
    [self setBtn:_myShouBtn imageName:@"shouDing" title:@"我收到的"];
    [self setBtn:_mySendBtn imageName:@"sendDing" title:@"我发出的"];
    [self leftBtnClick:_myShouBtn];
}

- (void)setBtn:(HXButton *)btn imageName:(NSString *)imgName title:(NSString *)title{
    btn.titleEdgeInsets = NSEdgeInsetsMake(0, 60, 0, 0);
    btn.imageEdgeInsets = NSEdgeInsetsMake(0, 0, 0, 60);
    [btn setImage:[NSImage imageNamed:imgName] forState:NSControlStateNormal];
    [btn setImage:[NSImage imageNamed:[imgName stringByAppendingString:@"_s"]] forState:NSControlStateSelected];
    [btn setTitleColor:[NSColor grayColor] forState:NSControlStateNormal];
    [btn setTitleColor:HXColor(85, 183, 252) forState:NSControlStateSelected];
    [btn setTitle:title forState:NSControlStateNormal];

}

- (IBAction)leftBtnClick:(HXButton *)sender {
    
    _titleLabel.stringValue = [sender.titleString stringByAppendingString:@"DING"];
    if ([sender.titleString isEqualToString:@"我发出的"]) {
        self.collectionView.hidden = YES ;
    } else{
        self.collectionView.hidden = NO;
    }
    self.lastBtn.selected = NO;
    sender.selected = YES;
    self.lastBtn = sender;
}

@end
