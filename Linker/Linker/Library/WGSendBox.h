//
//  WGSendBox.h
//  LiHu
//
//  Created by 王刚 on 13-12-22.
//  Copyright (c) 2013年 王刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGSinglton.h"

@interface WGSendBox : NSObject


@property (nonatomic, readonly) NSString *	appPath;
@property (nonatomic, readonly) NSString *	docPath;
@property (nonatomic, readonly) NSString *	libPrefPath;
@property (nonatomic, readonly) NSString *	libCachePath;
@property (nonatomic, readonly) NSString *	tmpPath;

AS_SINGLETON( WGSendBox )

+ (NSString *)appPath;		// 程序目录，不能存任何东西
+ (NSString *)docPath;		// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;	// 配置目录，配置文件存这里
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;		// 缓存目录，APP退出后，系统可能会删除这里的内容

+ (BOOL)touch:(NSString *)path;
+ (BOOL)touchFile:(NSString *)file;

//对CachedDownloads.dic的操作
- (BOOL)cacheDicRemoveObjectForKey:(NSString *)url;
//计算文件夹大小
-(long)fileSizeForDir:(NSString*)path;
//删除文件夹下的内容
- (BOOL)removeAllFilesInDoc;
//存储图片到doc
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;



//newlifox
//计算缓存，图片和mk请求
- (long)cacheSize;

- (BOOL)removeCache;


@end
