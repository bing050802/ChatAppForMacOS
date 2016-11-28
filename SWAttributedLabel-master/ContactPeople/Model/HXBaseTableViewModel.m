//
//  HXBaseTableViewModel.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/28.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "HXBaseTableViewModel.h"

#import "HXStaffCell.h"
#import "HXDepartmentCell.h"

@interface HXBaseTableViewModel ()

@property (nonatomic, strong) NSTableView *take_overTableView;
@property (nonatomic, strong) id modelData;

@property (nonatomic, strong) NSMutableArray *gropList;

@end

@implementation HXBaseTableViewModel


- (NSMutableArray  *)gropList {
    if (!_gropList) {
        _gropList = [[NSMutableArray alloc] init];
        [_gropList addObject:@"营销部"];
        [_gropList addObject:@"运营部"];
        [_gropList addObject:@"商务部"];
        [_gropList addObject:@"技术平台部门"];
        [_gropList addObject:@"客服部"];
    }
    return _gropList;
}


+ (instancetype)viewModelWithTableView:(NSTableView *)tableView {
    return [[self alloc] initWithTableView:tableView];
}


- (instancetype)initWithTableView:(NSTableView *)tableView {
    self = [super init];
    if (self) {
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerNib:[[NSNib alloc] initWithNibNamed:@"HXDepartmentCell" bundle:nil] forIdentifier:@"a"];
        [tableView registerNib:[[NSNib alloc] initWithNibNamed:@"HXStaffCell" bundle:nil] forIdentifier:@"b"];
        tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
        tableView.backgroundColor = [NSColor clearColor];
        tableView.headerView = nil;
        tableView.rowHeight = 60;
        self.take_overTableView = tableView;
    }
    return self;
}

- (void)relaodDataWithModel:(id)model {
    // 请求网络数据 json -- > model
    [self.take_overTableView reloadData];
    
    // [model class];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.gropList.count;
}



- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    // 提取cell
    HXDepartmentCell *cell = [tableView makeViewWithIdentifier:@"a" owner:self];
    
    // 设置cell
    cell.departName = self.gropList[row];
    cell.departCount = [NSString stringWithFormat:@"%d人",arc4random_uniform(30)];
    
    return cell;

}


@end
