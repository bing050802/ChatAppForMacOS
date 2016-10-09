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

#import "JMModalOverlay.h"
#import "HXPersonalController.h"


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


@end

@implementation HXRightChatViewController

static NSString *cellID = @"msgDatilCell";

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

- (void)loadView {
    [super loadView];
    
    [self.view backGroundColor:[NSColor whiteColor]];
    [self.topView backGroundColor:HXColor(246, 250, 255)];
    self.nameLabel.selectable = YES;
    
    [self buttonsSetting];
    
    self.datailTableView.headerView = nil;
    [self.datailTableView registerNib:[[NSNib alloc] initWithNibNamed:NSStringFromClass([HXMsgDatailCell class]) bundle:nil]  forIdentifier:cellID];
//    self.datailTable;
    
    [self.datailTableView reloadData];
    
    [NotificationCenter addObserver:self selector:@selector(middleTabelViewSelected:)
                               name:NSTableViewSelectionDidChangeNotification object:nil];
    
    
    
    
}

- (void)middleTabelViewSelected:(NSNotification *)noti {
    NSTableView *middleTableView = noti.object;
    if (middleTableView == self.datailTableView) return;
    NSInteger row = middleTableView.selectedRow;
    HXMessage *message = self.msgArray[row];
    [self.iconImage sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
}


- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    HXMsgDatailCell *cell = [tableView makeViewWithIdentifier:cellID owner:self];
        cell.message = self.msgDatialArray[row];
    return cell;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 100;
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






- (CGFloat)minimumLengthInSplitViewController:(NFSplitViewController*)splitViewController {
    return 625;
}



@end
