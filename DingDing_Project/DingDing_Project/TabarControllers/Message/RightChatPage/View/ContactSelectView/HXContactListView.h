//
//  HXContactListView.h
//  MDatabase
//
//  Created by hanxiaoqing on 2016/12/6.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HXContactListView : NSView

+ (HXContactListView *)loadXibContactListView;

@property (nonatomic,strong) NSArray *contactsArray;

@property (nonatomic,copy) NSString *selectName;

@end
