//
//  WGHttpHelper.h
//  LiHu
//
//  Created by 王刚 on 14-1-20.
//  Copyright (c) 2014年 王刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <netinet/in.h>
#import <sys/socket.h>

@interface WGLocahInfo : NSObject

+ (NSString *)getLocalIPAddress;

@end
