//
//  DINGViewController.h
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/16.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/**
 
 _defaultLayout = [CNGridViewItemLayout defaultLayout];
 _hoverLayout = [CNGridViewItemLayout defaultLayout];
 _selectionLayout = [CNGridViewItemLayout defaultLayout];
 
 self.hoverLayout.backgroundColor = [[NSColor grayColor] colorWithAlphaComponent:0.42];
 self.selectionLayout.backgroundColor = [NSColor colorWithCalibratedRed:0.542 green:0.699 blue:0.807 alpha:0.420];
 //    _defaultLayout.contentInset = 10;
 //    self.items = [NSMutableArray array];
 
 
 self.gridView.backgroundColor = [NSColor colorWithRed:248/255.0 green:251/255.0 blue:255/255.0 alpha:1.0];
 self.gridView.itemSize = NSMakeSize(280, 170);
 self.gridView.useHover =NO;
 self.gridView.allowsSelection = NO;
 self.gridView.scrollElasticity = YES;
 [self.gridView reloadData];
 }
 
 - (NSUInteger)gridView:(CNGridView *)gridView numberOfItemsInSection:(NSInteger)section {
 return 8;
 }
 
 - (CNGridViewItem *)gridView:(CNGridView *)gridView itemAtIndex:(NSInteger)index inSection:(NSInteger)section {
 static NSString *reuseIdentifier = @"CNGridViewItem";
 
 DINGMessageCell *item = [gridView dequeueReusableItemWithIdentifier:reuseIdentifier];
 if (item == nil) {
 item = [[DINGMessageCell alloc] initWithLayout:self.defaultLayout reuseIdentifier:reuseIdentifier];
 }
 item.hoverLayout = self.hoverLayout;
 item.selectionLayout = self.selectionLayout;
 
 return item;
 }

 
 
 */

@interface DINGViewController : NSViewController

@end
