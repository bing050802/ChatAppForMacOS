//
//  HXRightChatViewController.m
//  DingDing_Project
//
//  Created by han on 16/9/11.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXRightChatViewController.h"
#import "NFSplitViewController.h"
#import "HXPrefixHeader.h"
#import "HXMessage.h"
#import "HXBarButton.h"

#import "HXMsgDatailCell.h"
#import "HXMineMessageCell.h"

#import "JMModalOverlay.h"
#import "HXPersonalController.h"
#import "NSMutableAttributedString+AttachMent.h"

#import "MLPopupWindowManager.h"
#import "HXFacialSelectionPanel.h"

#import "HXInputToolView.h"


@interface HXRightChatViewController () <NSTableViewDelegate,NSTableViewDataSource,InputToolViewDelegate>

@property (weak) IBOutlet NSView *topView;

@property (weak) IBOutlet NSImageView *iconImage;
@property (weak) IBOutlet NSTextField *nameLabel;

// 聊天 记录的上传文件
@property (weak) IBOutlet HXBarButton *chatFilesBtn;
// 添加成员
@property (weak) IBOutlet HXBarButton *addMemberBtn;
// 拨打钉钉电话
@property (weak) IBOutlet HXBarButton *callBtn;
// 个人简介
@property (weak) IBOutlet HXBarButton *personalBtn;

@property (nonatomic,strong) JMModalOverlay *modalOverlay;

@property (nonatomic,strong) NSMutableArray *msgArray;
@property (nonatomic,strong) NSMutableArray *msgDatialArray;

@property (weak) IBOutlet NSTableView *datailTableView;
@property (weak) IBOutlet NSView *bgView;


@property (nonatomic,strong)  HXInputToolView *inputView;

@property (nonatomic,strong) HXFacialSelectionPanel *facialPanel;

@end

@implementation HXRightChatViewController

static NSString *datilCellID = @"datilCellID";
static NSString *mineCellID = @"mineCellID";


- (HXInputToolView *)inputView {
    if (!_inputView) {
        _inputView = [HXInputToolView loadXibInputView];
        [self.view addSubview:_inputView];
        _inputView.delegate = self;
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [_inputView autoSetDimension:ALDimensionHeight toSize:110];
    }
    return _inputView;
}


- (HXFacialSelectionPanel *)facialPanel {
    if (!_facialPanel) {
        _facialPanel = [[HXFacialSelectionPanel alloc] init];
        [self.view addSubview:_facialPanel];
        [_facialPanel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
        [_facialPanel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:115];
        [_facialPanel autoSetDimension:ALDimensionHeight toSize:300];
        [_facialPanel autoSetDimension:ALDimensionWidth toSize:430];
    }
    return _facialPanel;
}


- (NSMutableArray *)msgArray  {
    if (!_msgArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"more_topics.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        _msgArray = [HXMessage mj_objectArrayWithKeyValuesArray:dict[@"list"]];
    }
    return _msgArray;
}

- (NSMutableArray *)msgDatialArray  {
    if (!_msgDatialArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"new_topics.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        _msgDatialArray = [HXMessage mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        [_msgDatialArray addObjectsFromArray:self.msgArray];
    }
    return _msgDatialArray;
}


- (JMModalOverlay *)modalOverlay {
    if (!_modalOverlay) {
        _modalOverlay = [[JMModalOverlay alloc] init];
        _modalOverlay.animates = NO;
        _modalOverlay.animationDirection = JMModalOverlayDirectionBottom;
        _modalOverlay.shouldOverlayTitleBar = YES;
        //_modalOverlay.shouldCloseWhenClickOnBackground = NO;
        _modalOverlay.appearance = [NSAppearance appearanceNamed:NSAppearanceNameLightContent];
        //_modalOverlay.backgroundColor = [NSColor blackColor];
    }
    return _modalOverlay;
}

- (void)buttonsSetting {
    [self settingWithImageName:@"chatFile" btn:self.chatFilesBtn];
    [self settingWithImageName:@"addMember" btn:self.addMemberBtn];
    [self settingWithImageName:@"callDing" btn:self.callBtn];
    [self settingWithImageName:@"personal" btn:self.personalBtn];
}

- (void)settingWithImageName:(NSString *)name btn:(HXBarButton *)btn {
    btn.trackingEabled = YES;
    btn.cell.highlightsBy = NSNoCellMask;
    [btn setImage:[NSImage imageNamed:name] forState:ButtonStateNormal];
    [btn setImage:[NSImage imageNamed:[NSString stringWithFormat:@"%@_entered",name]] forState:ButtonStateMouseIn];
}




- (void)loadView {
    [super loadView];
    
    // 背景色
    [self.view backGroundColor:HXColor(248, 251, 255)];
    self.topView.hidden = YES;
    [self.topView backGroundColor:HXColor(246, 250, 255)];
    
    // 工具栏右侧 按钮设置trackingImage
    [self buttonsSetting];
    
    //inputView 先hidden
    self.inputView.hidden = YES;
    
    // 消息详情列表
    self.datailTableView.headerView = nil;
    [self.datailTableView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([HXMsgDatailCell class]) bundle:nil]  forIdentifier:datilCellID];
    [self.datailTableView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([HXMineMessageCell class]) bundle:nil]  forIdentifier:mineCellID];
    self.datailTableView.backgroundColor = HXColor(248, 251, 255);
    self.datailTableView.enclosingScrollView.hidden = YES;
    self.datailTableView.usesStaticContents = YES;
    
    [NotificationCenter addObserver:self selector:@selector(middleTabelViewSelected:)
                               name:NSTableViewSelectionDidChangeNotification object:nil];
    
    [NotificationCenter addObserver:self selector:@selector(windowClicked:)
                               name:NSWindowClickedNotification object:nil];
    
}

- (void)middleTabelViewSelected:(NSNotification *)noti {
    NSTableView *middleTableView = noti.object;
     // 通知若是来自 本控制器tableView 返回不处理
    if (middleTableView == self.datailTableView) return;
    
    // 中间的cell选中 顶部工具栏 展示对应的消息用户头像 名字
    NSInteger row = middleTableView.selectedRow;
    HXMessage *message = self.msgArray[row];
    [self.iconImage sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
    
    // 选中之后 背景bgView隐藏，inputView datailTableView 显示
    self.bgView.hidden = YES;
    self.inputView.hidden = NO;
    self.topView.hidden = NO;
    self.datailTableView.enclosingScrollView.hidden = NO;

}


- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    //      NSLog(@"viewForTableColumn-- %zd",row);
    HXMessage *msg = self.msgDatialArray[row];
    if (msg.isMine) {
        HXMineMessageCell *cell = [tableView makeViewWithIdentifier:mineCellID owner:self];
        cell.message = msg;
        return cell;
    } else {
        HXMsgDatailCell *cell = [tableView makeViewWithIdentifier:datilCellID owner:self];
        cell.message = msg;
        return cell;
    }
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
//    NSLog(@"heightOfRow-- %zd",row);
    HXMessage *message = self.msgDatialArray[row];
    NSMutableAttributedString *mattString = [NSMutableAttributedString parseFaceWordFromString:message.text];
    [mattString setLineSpacing:5];
    CGFloat realheight = [mattString mlineSize].height;
    return realheight + 75;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.msgDatialArray.count;
}




- (IBAction)showChatFiles:(id)sender {
    self.modalOverlay.contentViewController = [[HXPersonalController alloc] init];
    [self.modalOverlay showInWindow:self.view.window];
}


- (IBAction)addMember:(id)sender {
    [self.datailTableView reloadData];
}


- (IBAction)callDingding:(id)sender {
    
}


- (IBAction)showPersonal:(id)sender {
    
}


- (void)inputCompleteToSend:(NSTextView *)textView {
    
    // 创建消息对象
    HXMessage *msg = [[HXMessage alloc] init];
    msg.isMine = YES;
    msg.name = @"我";
    msg.create_time = @"11-11 03:00:00";
    msg.text = textView.string;
    
    // inser row
    [self.datailTableView beginUpdates];
    [self.msgDatialArray addObject:msg];
    [self.datailTableView  insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.msgDatialArray.count-1] withAnimation:NSTableViewAnimationEffectNone];
    [self.datailTableView endUpdates];
    
    // 文字清空
    textView.string = @"";
    
    // 滑动到最新的消息位置
    [self.datailTableView scrollRowToVisible:self.msgDatialArray.count - 1];
    
    // 隐藏表情键盘
    self.facialPanel.hidden = YES;
    self.facialPanel = nil;
}


- (void)toolViewSelect:(NSInteger)tag {
    if (tag == 101) { // 表情
        self.facialPanel.wantsLayer = YES;
        NSShadow *dropShadow = [[NSShadow alloc] init];
        [dropShadow setShadowColor:[NSColor grayColor]];
        [dropShadow setShadowOffset:NSMakeSize(0, -5.0)];
        [dropShadow setShadowBlurRadius:10.0];
        [self.facialPanel setShadow:dropShadow];
    }
}


// window 整个区域被点击通知
- (void)windowClicked:(NSNotification *)noti {
    if (_facialPanel) {
        NSEvent *event = noti.object;
        NSRect panelRect = [self.facialPanel convertRect:self.facialPanel.bounds toView:nil];
        if (!CGRectContainsPoint(panelRect, event.locationInWindow)) {
            self.facialPanel.hidden = YES;
            self.facialPanel = nil;
        }
    }
}

- (CGFloat)minimumLengthInSplitViewController:(NFSplitViewController*)splitViewController {
    return 625;
}


@end
