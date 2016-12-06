//
//  HXContactListView.m
//  MDatabase
//
//  Created by hanxiaoqing on 2016/12/6.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import "HXContactListView.h"

@interface HXContactListView () <NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *contactListView;

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


- (void)awakeFromNib {
    [super awakeFromNib];

    
    self.contactListView.allowsTypeSelect = NO;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 5;
}


- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    // NSTableColumn的identifier可在xib里面设置，如果不设置系统会有一个默认的命名
    NSString *identifiy = tableColumn.identifier;
    
    // 提取cell
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifiy owner:self];
    if (!cell) cell = [[NSTableCellView alloc] init];
    
    // 设置cell
    cell.textField.stringValue = @"dfadf";
    cell.textField.textColor = [NSColor darkGrayColor];
    
    return cell;
}


- (void)keyDown:(NSEvent *)event {
    
    NSLog(@"keyDown");
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
  
}


- (nullable NSString *)tableView:(NSTableView *)tableView typeSelectStringForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    
    
    return @"";
}

//- (NSInteger)tableView:(NSTableView *)tableView nextTypeSelectMatchFromRow:(NSInteger)startRow toRow:(NSInteger)endRow forString:(NSString *)searchString {
//    
//    
//}


- (BOOL)tableView:(NSTableView *)tableView shouldTypeSelectForEvent:(NSEvent *)event withCurrentSearchString:(nullable NSString *)searchString {
    
    
    NSLog(@"--%@",searchString);
    
    return YES;
    
}




@end
