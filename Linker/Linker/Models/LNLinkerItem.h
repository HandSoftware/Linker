//
//  LNLinkerItem.h
//  Linker
//
//  Created by jimmylee on 6/28/14.
//  Copyright (c) 2014 Handos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNLinkerItem : NSObject
//链接Id
@property (nonatomic, assign) NSString *linkId;
//链接资源地址
@property (nonatomic, assign) NSString *linkeSourcePath;
//父链接的id
@property (nonatomic,assign) NSString *pLinkId;
//用户id
@property (nonatomic,assign) NSString *userId;
@end
