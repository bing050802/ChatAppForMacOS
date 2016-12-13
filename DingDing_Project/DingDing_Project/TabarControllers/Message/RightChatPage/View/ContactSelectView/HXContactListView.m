//
//  HXContactListView.m
//  MDatabase
//
//  Created by hanxiaoqing on 2016/12/6.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "HXContactListView.h"
#import "NSTableView+Selection.h"
#import "HXPrefixHeader.h"
#import "NSImage+StackBlur.h"


#define cellColor [NSColor colorWithRed:215/255.0 green:232/255.0 blue:248/255.0 alpha:1.0]

@interface HXContactCell : NSTableCellView

@property (nonatomic,strong) NSTrackingArea *trackingArea;

@end

@implementation HXContactCell

- (NSTrackingArea *)trackingArea {
    if (!_trackingArea) {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
    }
    return _trackingArea;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.wantsLayer = YES;
    [self addTrackingArea:self.trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.layer.backgroundColor = cellColor.CGColor;
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
}

@end



@interface HXContactListView () <NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *contactListView;

@property (nonatomic,strong) NSTableRowView *lastSelectedRow;

@property (nonatomic,strong) id eventMonitor;

@end

@implementation HXContactListView

+ (HXContactListView *)loadXibContactListView
{
    NSArray *viewsArray;
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"HXContactListView" bundle:nil];
    [nib instantiateWithOwner:self topLevelObjects:&viewsArray];
    for (NSView *view in viewsArray) {
        if ([view isKindOfClass:[self class]]) {
            return (HXContactListView *)view;
        }
    }
    return nil;
}


- (void)awakeFromNib
{
    [super awakeFromNib];

    NSShadow *dropShadow = [[NSShadow alloc] init];
    [dropShadow setShadowColor:[NSColor grayColor]];
    [dropShadow setShadowOffset:NSMakeSize(0, -5.0)];
    [dropShadow setShadowBlurRadius:10.0];
    [self setShadow:dropShadow];
    
    self.contactListView.allowsTypeSelect = YES;
    self.contactListView.headerView = nil;
    self.contactListView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
    
//    static NSEvent *currentEvent;
//    self.eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^(NSEvent *_Nonnull theEvent) {
//        if (currentEvent != theEvent) {
//            NSLog(@"--currentEvent--%p---%p",currentEvent,theEvent);
//            [self.contactListView performSelector:@selector(keyDown:) withObject:theEvent afterDelay:0.0];
//            currentEvent = theEvent;
//        }
//        return theEvent;
//    }];
}


- (void)setContactsArray:(NSArray *)contactsArray {
    _contactsArray = contactsArray;
    [self.contactListView reloadData];
    [self.contactListView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:YES];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if (_contactsArray.count < 9) {
        [self setFrameSize:NSMakeSize(154, _contactsArray.count * 40)];
    } else {
        [self setFrameSize:NSMakeSize(154, 282)];
    }
    return _contactsArray.count;
}


- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    // 提取cell
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"abc" owner:self];
    // 设置cell
    cell.textField.stringValue = _contactsArray[row];
    cell.textField.textColor = [NSColor darkGrayColor];
    cell.imageView.image = [NSImage circleImageWithColor:HXRandomColor size:cell.imageView.frame.size text:cell.textField.stringValue font:[NSFont systemFontOfSize:11]];
    return cell;
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    self.lastSelectedRow.backgroundColor = [NSColor clearColor];
    
    // 当前选中cell
    NSTableRowView *row = [self.contactListView selectedRowView];
    row.backgroundColor = cellColor;
    
    self.lastSelectedRow = row;
    
    self.selectName = _contactsArray[self.contactListView.selectedRow];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
}



- (void)dealloc {
    [NSEvent removeMonitor:self.eventMonitor];
}

@end
