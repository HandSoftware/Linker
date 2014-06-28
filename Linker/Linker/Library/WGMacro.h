//
//  WGMacro.c
//  lifox
//
//  Created by 王刚 on 14/6/13.
//  Copyright (c) 2014年 王刚. All rights reserved.
//

#ifndef WGMacro_h
#define WGMacro_h


#define HOSTNAME [NSString stringWithFormat:@"lifox.net"]
//115.182.21.75/lifox

#define UMeng_ApplicationKey @"52dbf39756240b493312699c"

#define WeChat_ApplicationKey @"wx9c1d5e01e5c5df9c"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define NavigationColor UIColorFromRGB(0xbf2c41)

#endif

