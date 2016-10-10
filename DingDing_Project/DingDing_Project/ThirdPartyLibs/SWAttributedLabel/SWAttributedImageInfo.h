//
//  SWAttributedImageInfo.h
//  SWAttributedLabel
//
//  Created by mxc235 on 16/8/31.
//  Copyright © 2016年 mxc235. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 同一行文图混搭时，图片相对于同一行的文字的对齐模式，包含（上、中、下对齐）
 */
typedef NS_ENUM(NSInteger, SWImageAlignment){
    SWImageAlignmentTop = 0,
    SWImageAlignmentCenter,
    SWImageAlignmentBottom,
};

/**
 显示的类型，包括普通图片和动图(GIF)
 */
typedef NS_ENUM(NSInteger, SWImageType){
    SWImageNormalType = 0,
    SWImageGIFType,
};

/**
 文件的来源,包括项目内文件和本地下载以及网络上的
 */
typedef NS_ENUM(NSInteger, SWImageFrom){
    SWImageLocalType = 0,
    SWImageDownLoadType,
    SWImageNetType,
};

/**
 *  Label中的图片模型
 */

@interface SWAttributedImageInfo : NSObject

@property (nonatomic, copy) NSString *imageName;  // 图片名字

@property (nonatomic, copy) NSString *imagePath;  // 图片的路径地址

@property (nonatomic, assign) CGSize imageSize;     // 图片大小

@property (nonatomic, assign) CTFontRef fontRef;    // 文字字体

@property (nonatomic, assign)  NSEdgeInsets imageMargin;        // 图片与文字之间的间距

@property (nonatomic, assign) SWImageAlignment imageAlignment;  // 图片相对于文字的排版样式

@property (nonatomic, assign) SWImageType imageType;   // 类型（UIImage或者UIView）

@property (nonatomic, assign) SWImageFrom imageFrom;   // 来源类型（本地,数据库,远程）

@end
