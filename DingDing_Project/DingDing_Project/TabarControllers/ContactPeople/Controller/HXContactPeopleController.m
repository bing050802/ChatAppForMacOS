//
//  HXContactPeopleController.m
//  SWAttributedLabel
//
//  Created by hanxiaoqing on 2016/11/22.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import "HXContactPeopleController.h"
#import "NSTableView+Selection.h"
#import "HXButton.h"
#import "HXBaseTableViewModel.h"
#import "NSView+RBLAnimationAdditions.h"
#import "HXClickView.h"

static BOOL stateSelect = NO;

@interface HXContactPeopleController () <NSTableViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet HXClickView *HeadView;

@property (weak) IBOutlet NSTableView *organizeTableView;
@property (nonatomic,strong) NSMutableArray *architectures;

@property (nonatomic,strong) NSTableCellView *lastSelectedCell;

@property (weak) IBOutlet HXButton *IndicateBtn;

@property (nonatomic,strong) HXBaseTableViewModel *gropViewModel;


@property (weak) IBOutlet NSTableView *gropDatail;
@property (weak) IBOutlet NSLayoutConstraint *leftScrollViewHeight;

@end

@implementation HXContactPeopleController

- (HXBaseTableViewModel *)gropViewModel {
    if (!_gropViewModel) {
        _gropViewModel = [HXBaseTableViewModel viewModelWithTableView:self.gropDatail];
    }
    return _gropViewModel;
}

- (NSMutableArray *)architectures {
    if (!_architectures) {
        _architectures = [[NSMutableArray alloc] init];
        [_architectures addObject:@"组织架构"];
        [_architectures addObject:@"发行中心"];
        [_architectures addObject:@"技术平台部门"];
        [_architectures addObject:@"手游接入组"];
        [_architectures addObject:@"外部联系人"];
    }
    return _architectures;
}


- (void)downList:(NSGestureRecognizer *)ges {
    if (stateSelect) {
        self.leftScrollViewHeight.constant = 0;
        stateSelect = NO;
    } else {
        self.leftScrollViewHeight.constant = 190;
        stateSelect = YES;
    }
}


- (void)loadView
{
    [super loadView];

    NSClickGestureRecognizer *ges = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(downList:)];
    [self.HeadView addGestureRecognizer:ges];
    [self downList:nil];
    
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor colorWithRed:242/255.0 green:247/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    // tableView设置颜色:scrollView drawBackGround = NO
    // clipView drawBackGround = NO（clipView在xib默认就是no）
    self.organizeTableView.backgroundColor = [NSColor clearColor];
    self.organizeTableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
    //    NSTableCellView
    self.organizeTableView.headerView = nil;
//    [self.organizeTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    
    
    [self.IndicateBtn setTitleColor:[NSColor colorWithRed:37/255.0 green:140/255.0 blue:240/255.0 alpha:1.0] forState:NSControlStateNormal];
    [self.IndicateBtn setTitle:@"北京巴别时代科技有限公司" forState:0];
    [self.gropViewModel relaodDataWithModel:nil];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.architectures.count;
}



- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    // NSTableColumn的identifier可在xib里面设置，如果不设置系统会有一个默认的命名
    NSString *identifiy = tableColumn.identifier;
    
    // 提取cell
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifiy owner:self];
    if (!cell) cell = [[NSTableCellView alloc] init];
    
    // 设置cell
    cell.textField.stringValue = self.architectures[row];
    cell.textField.textColor = [NSColor darkGrayColor];
    
    return cell;
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    // 上次选中cell回复原有文字颜色
    if ([self.lastSelectedCell respondsToSelector:@selector(textField)]) {
        self.lastSelectedCell.textField.textColor = [NSColor darkGrayColor];
    }
    
    // 当前选中cell
    NSTableCellView *cell = [self.organizeTableView selectedCellViews][0];
    
    // 文字颜色选中色
    if ([cell respondsToSelector:@selector(textField)]) {
        cell.textField.textColor = [NSColor colorWithRed:37/255.0 green:140/255.0 blue:240/255.0 alpha:1.0];
    }
    
    self.lastSelectedCell = cell;
}


@end
