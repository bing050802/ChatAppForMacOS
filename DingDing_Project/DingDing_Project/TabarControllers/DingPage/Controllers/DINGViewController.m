
//
//  DINGViewController.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/16.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "DINGViewController.h"
#import "CNGridView.h"
#import "CNGridViewItemLayout.h"
#import "HXButton.h"
#import "HXDingMessageItem.h"

//https://www.raywenderlich.com/120494/collection-views-os-x-tutorial

static NSString *kContentTitleKey, *kContentImageKey, *kItemSizeSliderPositionKey;

@interface DINGViewController () <NSCollectionViewDelegate>


@property (weak) IBOutlet CNGridView *gridView;
@property (strong) NSMutableArray *items;


@property (strong) CNGridViewItemLayout *defaultLayout;
@property (strong) CNGridViewItemLayout *hoverLayout;
@property (strong) CNGridViewItemLayout *selectionLayout;

@property (weak) IBOutlet HXButton *testBtn;

@property (weak) IBOutlet NSCollectionView *collectionView;

@end

@implementation DINGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    


}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

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

    



}

@end
