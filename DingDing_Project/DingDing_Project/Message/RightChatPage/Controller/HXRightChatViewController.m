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
#import "SWAttributedLabel.h"


@interface HXRightChatViewController () <NSTableViewDelegate,NSTableViewDataSource>

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


@property (weak) IBOutlet HXBarButton *attchBtn;
@property (weak) IBOutlet HXBarButton *faceBtn;
@property (weak) IBOutlet HXBarButton *aiteBtn;
@property (weak) IBOutlet HXBarButton *dingFileBtn;
@property (weak) IBOutlet HXBarButton *cutBtn;
@property (weak) IBOutlet HXBarButton *mingPianBtn;
@property (weak) IBOutlet HXBarButton *zanBtn;

@property (unsafe_unretained) IBOutlet HXTextView *inputTextView;
@property (weak) IBOutlet NSView *inputBgView;

@end

@implementation HXRightChatViewController

static NSString *datilCellID = @"datilCellID";
static NSString *mineCellID = @"mineCellID";

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
//        [_msgDatialArray addObjectsFromArray:self.msgArray];
    }
    return _msgDatialArray;
}


-(JMModalOverlay *)modalOverlay {
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
    
    self.chatFilesBtn.trackingEabled = YES;
    self.chatFilesBtn.cell.highlightsBy = NSNoCellMask;
    [self.chatFilesBtn setImage:[NSImage imageNamed:@"chatFile"] forState:ButtonStateNormal];
    [self.chatFilesBtn setImage:[NSImage imageNamed:@"chatFile_entered"] forState:ButtonStateMouseIn];
    
    self.addMemberBtn.trackingEabled = YES;
    self.addMemberBtn.cell.highlightsBy = NSNoCellMask;
    [self.addMemberBtn setImage:[NSImage imageNamed:@"addMember"] forState:ButtonStateNormal];
    [self.addMemberBtn setImage:[NSImage imageNamed:@"addMember_entered"] forState:ButtonStateMouseIn];
    
    self.callBtn.trackingEabled = YES;
    self.callBtn.cell.highlightsBy = NSNoCellMask;
    [self.callBtn setImage:[NSImage imageNamed:@"callDing"] forState:ButtonStateNormal];
    [self.callBtn setImage:[NSImage imageNamed:@"callDing_entered"] forState:ButtonStateMouseIn];
    
    self.personalBtn.trackingEabled = YES;
    self.personalBtn.cell.highlightsBy = NSNoCellMask;
    [self.personalBtn setImage:[NSImage imageNamed:@"personal"] forState:ButtonStateNormal];
    [self.personalBtn setImage:[NSImage imageNamed:@"personal_entered"] forState:ButtonStateMouseIn];
    
    

}

- (void)inputViewButtonsSetting {
    
    self.attchBtn.trackingEabled = YES;
    self.attchBtn.cell.highlightsBy = NSNoCellMask;
    [self.attchBtn setImage:[NSImage imageNamed:@"attach"] forState:ButtonStateNormal];
    [self.attchBtn setImage:[NSImage imageNamed:@"attach_entered"] forState:ButtonStateMouseIn];
    
    self.faceBtn.trackingEabled = YES;
    self.faceBtn.cell.highlightsBy = NSNoCellMask;
    [self.faceBtn setImage:[NSImage imageNamed:@"face"] forState:ButtonStateNormal];
    [self.faceBtn setImage:[NSImage imageNamed:@"face_entered"] forState:ButtonStateMouseIn];
    
    self.aiteBtn.trackingEabled = YES;
    self.aiteBtn.cell.highlightsBy = NSNoCellMask;
    [self.aiteBtn setImage:[NSImage imageNamed:@"aite"] forState:ButtonStateNormal];
    [self.aiteBtn setImage:[NSImage imageNamed:@"aite_entered"] forState:ButtonStateMouseIn];
    
    
    self.dingFileBtn.trackingEabled = YES;
    self.dingFileBtn.cell.highlightsBy = NSNoCellMask;
    [self.dingFileBtn setImage:[NSImage imageNamed:@"file"] forState:ButtonStateNormal];
    [self.dingFileBtn setImage:[NSImage imageNamed:@"file_entered"] forState:ButtonStateMouseIn];
    
    self.cutBtn.trackingEabled = YES;
    self.cutBtn.cell.highlightsBy = NSNoCellMask;
    [self.cutBtn setImage:[NSImage imageNamed:@"cut"] forState:ButtonStateNormal];
    [self.cutBtn setImage:[NSImage imageNamed:@"cut_entered"] forState:ButtonStateMouseIn];
    
    self.mingPianBtn.trackingEabled = YES;
    self.mingPianBtn.cell.highlightsBy = NSNoCellMask;
    [self.mingPianBtn setImage:[NSImage imageNamed:@"mingPian"] forState:ButtonStateNormal];
    [self.mingPianBtn setImage:[NSImage imageNamed:@"mingPian_entered"] forState:ButtonStateMouseIn];
    
    self.zanBtn.trackingEabled = YES;
    self.zanBtn.cell.highlightsBy = NSNoCellMask;
    [self.zanBtn setImage:[NSImage imageNamed:@"zan"] forState:ButtonStateNormal];
    [self.zanBtn setImage:[NSImage imageNamed:@"zan_entered"] forState:ButtonStateMouseIn];
    
}

- (void)loadView {
    [super loadView];
    
    [self.view backGroundColor:HXColor(248, 251, 255)];
    
    // 顶部 工具栏
    [self.topView backGroundColor:HXColor(246, 250, 255)];
    self.topView.hidden = YES;
    
    // 名字可选中复制
    self.nameLabel.selectable = YES;
    
    // 工具栏右侧 按钮设置trackingImage
    [self buttonsSetting];
    
    [self inputViewButtonsSetting];
    
    [self.inputBgView backGroundColor:HXColor(245, 249, 255)];
    self.inputTextView.drawsBackground = NO;
    self.inputTextView.borderWidth = 0;
    self.inputTextView.textViewBgColor = [NSColor clearColor];
    self.inputTextView.font = [NSFont systemFontOfSize:14.0];
    self.inputTextView.textColor = HXColor(70, 70, 70);
    
    
    // 消息详情列表
    self.datailTableView.headerView = nil;
    [self.datailTableView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([HXMsgDatailCell class]) bundle:nil]  forIdentifier:datilCellID];
    [self.datailTableView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([HXMineMessageCell class]) bundle:nil]  forIdentifier:mineCellID];
    
    
     [self.datailTableView.superview.superview setHidden:YES];
//    HXColor(248, 251, 255)  [NSColor colorWithRed:248 green:251 blue:255 alpha:1.0]
    self.datailTableView.backgroundColor = HXColor(248, 251, 255);
    
//    self.datailTableView.rowHeight
    
    [NotificationCenter addObserver:self selector:@selector(middleTabelViewSelected:)
                               name:NSTableViewSelectionDidChangeNotification object:nil];
    
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
    
    // 选中之后 背景bgView隐藏，topview datailTableView显示
    self.bgView.hidden = YES;
    self.topView.hidden = NO;
    [self.datailTableView.superview.superview setHidden:NO];
}


- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    HXMsgDatailCell *cell = [tableView makeViewWithIdentifier:datilCellID owner:self];
    cell.message = self.msgDatialArray[row];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    HXMessage *message = self.msgDatialArray[row];
    
    
    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
    attCell.attachImage = [NSImage imageNamed:@"haha@2x"];
    attCell.attachSize = CGSizeMake(30, 30);
    
    NSMutableAttributedString *mattString = [[NSMutableAttributedString alloc] initWithString:message.text];
    [mattString apppendAttachmentCell:attCell];
    
    
    [mattString setFont:[NSFont systemFontOfSize:messageTextFont]];
    [mattString setFont:[NSFont systemFontOfSize:30] range:NSMakeRange(mattString.length - 1, 1)];
    [mattString setLineSpacing:5];
    
    CGFloat realheight = [mattString realityHeightForWidth:310];
    return realheight + 75;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  
    return self.msgDatialArray.count;
}



- (void)tableViewSelectionDidChange:(NSNotification *)notification {

    
}




- (IBAction)showChatFiles:(id)sender {
    self.modalOverlay.contentViewController = [[HXPersonalController alloc] init];
    [self.modalOverlay showInWindow:self.view.window];
}


- (IBAction)addMember:(id)sender {
    
}


- (IBAction)callDingding:(id)sender {
    
}


- (IBAction)showPersonal:(id)sender {
    
}





- (IBAction)showAttch:(id)sender {
    
    NSLog(@"%s",__func__);
}


- (IBAction)showFaces:(id)sender {
    NSLog(@"%s",__func__);
}


- (IBAction)showAite:(id)sender {
    NSLog(@"%s",__func__);
}


- (IBAction)showDingPanFile:(id)sender {
    NSLog(@"%s",__func__);
}

- (IBAction)cutScreen:(id)sender {
    NSLog(@"%s",__func__);
}


- (IBAction)sendMingPian:(id)sender {
    NSLog(@"%s",__func__);
}

- (IBAction)dianZan:(id)sender {
    NSLog(@"%s",__func__);

}



- (CGFloat)minimumLengthInSplitViewController:(NFSplitViewController*)splitViewController {
    return 625;
}



@end
