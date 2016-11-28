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

@property (nonatomic, strong) NSMutableArray *peopleList;

@end

@implementation HXBaseTableViewModel
/*
 宋晓茶 韩衾祁 殷小室 殷小柠 秦采桑 伊弄巧 伊醒沙 栾离莹 汪诗敏 殷紫原 韩紫柳 沐厝
 
 菊悠箬 菊乱晓 秦问言 秦不语 秦小荷 秦琉璃 秦青画 娇语络 柳笙絮 戚晓来 凌画柳 韩草
 
 秦傲楼 姚琐涵 殷雨恨 徐南心 全南夏 林羡楠 燕瑶雨 葛恫声 易楚亭 连雪婵 楼歌晓 米岸
 
 殷雪鱼 伊浅潆 龙袭渔 宇元蓝   伊守蓝 原舒羽  俞醒薇 叶叔颖 沈漱儿 俞心庭 元亚
 
 周浩林 欧千洛 晴川沐 晴川铭 晴川林 晴川柏 乔沐枫  易默昀 易默野 卓均彦 吴尔
 
      展血岩
 */

- (NSMutableArray *)peopleList {
    if (!_peopleList) {
        _peopleList = [[NSMutableArray alloc] init];
        [_peopleList addObject:@"张三"];
        [_peopleList addObject:@"李红"];
        [_peopleList addObject:@"李红"];
        [_peopleList addObject:@"玄知枫"];
        [_peopleList addObject:@"李小将"];
        [_peopleList addObject:@"沐君勒"];
        [_peopleList addObject:@"吴原"];
        [_peopleList addObject:@"沐连勒"];
        [_peopleList addObject:@"庄雪涯"];
        [_peopleList addObject:@"叶振一"];
        [_peopleList addObject:@"乔汜廉"];
        [_peopleList addObject:@"纳智杭"];
        [_peopleList addObject:@"彤圣杭"];
        [_peopleList addObject:@"刑牧一"];
        [_peopleList addObject:@"宇凌司"];
        [_peopleList addObject:@"苏献宁"];
        [_peopleList addObject:@"乔汜枫"];
    }
    return _peopleList;
}

- (NSMutableArray  *)gropList {
    if (!_gropList) {
        _gropList = [[NSMutableArray alloc] init];
        [_gropList addObject:@"营销部"];
        [_gropList addObject:@"运营部"];
        [_gropList addObject:@"商务部"];
        [_gropList addObject:@"技术平台部门"];
        [_gropList addObject:@"客服部"];
        [_gropList addObject:@"海外运营部"];
        [_gropList addObject:@"创意部"];
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
    return self.gropList.count + self.peopleList.count;
}



- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    // 提取cell
    if(row < self.gropList.count) {
        HXDepartmentCell *cell = [tableView makeViewWithIdentifier:@"a" owner:self];
        cell.departName = self.gropList[row];
        cell.departCount = [NSString stringWithFormat:@"%d人",arc4random_uniform(30)];
        return cell;
    }
    else {
        HXStaffCell *cell = [tableView makeViewWithIdentifier:@"b" owner:self];
        cell.peopleName = self.peopleList[row - self.gropList.count];
        return cell;
    }

    return nil;
}


@end
