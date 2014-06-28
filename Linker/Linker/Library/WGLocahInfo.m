//
//  WGHttpHelper.m
//  LiHu
//
//  Created by 王刚 on 14-1-20.
//  Copyright (c) 2014年 王刚. All rights reserved.
//

#import "WGLocahInfo.h"

@implementation WGLocahInfo

+ (NSString *)getLocalIPAddress{
    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    
    struct ifaddrs* addrs;
    
    //获取en0, lo0的ip地址
    BOOL success = (getifaddrs(&addrs) == 0);
    if (success) {
        const struct ifaddrs* cursor = addrs;
        while (cursor != NULL) {
            NSMutableString* ip;
            if (cursor->ifa_addr->sa_family == AF_INET) {
                const struct sockaddr_in* dlAddr = (const struct sockaddr_in*)cursor->ifa_addr;
                const uint8_t* base = (const uint8_t*)&dlAddr->sin_addr;
                ip = [[NSMutableString new] autorelease];
                for (int i = 0; i < 4; i++) {
                    if (i != 0) {
                        [ip appendFormat:@"."];
                    }
                    [ip appendFormat:@"%d", base[i]];
                }
                [result setObject:(NSString*)ip forKey:[NSString stringWithFormat:@"%s", cursor->ifa_name]];
            }
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
    
//    NSLog(@"IP addresses: %@", [result objectForKey:@"en0"]);
    /*
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalhostAdressesResolved" object:result];
     */
    
    NSString *ip =  [NSString stringWithFormat:@"%@",[result objectForKey:@"en0"]];
    
    return ip;
    [pool release];
    
    
}

// 输出如下：
//IP addresses: {
//    en0 = "10.202.201.16";
//    lo0 = "127.0.0.1";
//}

@end
