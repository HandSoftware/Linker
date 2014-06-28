//
//  WGSendBox.m
//  LiHu
//
//  Created by 王刚 on 13-12-22.
//  Copyright (c) 2013年 王刚. All rights reserved.
//

#import "WGSendBox.h"

@interface WGSendBox()
{
	NSString *	_appPath;
	NSString *	_docPath;
	NSString *	_libPrefPath;
	NSString *	_libCachePath;
	NSString *	_tmpPath;
}

- (BOOL)touch:(NSString *)path;
- (BOOL)touchFile:(NSString *)path;
- (BOOL)cacheDicRemoveObjectForKey:(NSString *)url;

@end

@implementation WGSendBox
DEF_SINGLETON( WGSendBox )

@dynamic appPath;
@dynamic docPath;
@dynamic libPrefPath;
@dynamic libCachePath;
@dynamic tmpPath;

+ (NSString *)appPath
{
	return [[WGSendBox sharedInstance] appPath];
}

- (NSString *)appPath
{
	if ( nil == _appPath )
	{
		NSError * error = nil;
		NSArray * paths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:NSHomeDirectory() error:&error];
        
		for ( NSString * path in paths )
		{
			if ( [path hasSuffix:@".app"] )
			{
				_appPath = [[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), path] retain];
				break;
			}
		}
	}
    
	return _appPath;
}

+ (NSString *)docPath
{
	return [[WGSendBox sharedInstance] docPath];
}

- (NSString *)docPath
{
	if ( nil == _docPath )
	{
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		_docPath = [[paths objectAtIndex:0] retain];
	}
	
	return _docPath;
}

+ (NSString *)libPrefPath
{
	return [[WGSendBox sharedInstance] libPrefPath];
}

- (NSString *)libPrefPath
{
	if ( nil == _libPrefPath )
	{
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
		
		[self touch:path];
        
		_libPrefPath = [path retain];
	}
    
	return _libPrefPath;
}

+ (NSString *)libCachePath
{
	return [[WGSendBox sharedInstance] libCachePath];
}

- (NSString *)libCachePath
{
	if ( nil == _libCachePath )
	{
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
        
		[self touch:path];
		
		_libCachePath = [path retain];
	}
	
	return _libCachePath;
}

+ (NSString *)tmpPath
{
	return [[WGSendBox sharedInstance] tmpPath];
}

- (NSString *)tmpPath
{
	if ( nil == _tmpPath )
	{
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
		
		[self touch:path];
        
		_tmpPath = [path retain];
	}
    
	return _tmpPath;
}

+ (BOOL)touch:(NSString *)path
{
	return [[WGSendBox sharedInstance] touch:path];
}

- (BOOL)touch:(NSString *)path
{
	if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
	{
		return [[NSFileManager defaultManager] createDirectoryAtPath:path
										 withIntermediateDirectories:YES
														  attributes:nil
															   error:NULL];
	}
	
	return YES;
}

+ (BOOL)touchFile:(NSString *)file
{
	return [[WGSendBox sharedInstance] touchFile:file];
}

- (BOOL)touchFile:(NSString *)file
{
	if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:file] )
	{
		return [[NSFileManager defaultManager] createFileAtPath:file
													   contents:[NSData data]
													 attributes:nil];
	}
	
	return YES;
}



+ (BOOL)cacheDicRemoveObjectForKey:(NSString *)url {
    return [[WGSendBox sharedInstance] cacheDicRemoveObjectForKey:url];
}


- (BOOL)cacheDicRemoveObjectForKey:(NSString *)url {
    
    NSString *localURL = [url
                          stringByAddingPercentEscapesUsingEncoding:
                          NSUTF8StringEncoding];
    
    
    
    NSString *doc = [[WGSendBox sharedInstance]docPath];
    NSString *cacheDictionaryPath = [doc stringByAppendingPathComponent:@"CachedDownloads.dic"];
    
    //创建一个NSFileManager实例
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    //判断是否存在缓存字典的数据
    if ([fileManager fileExistsAtPath:cacheDictionaryPath] == YES){
        
        //加载缓存字典中的数据
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:cacheDictionaryPath];
        NSMutableDictionary *cacheDic = [dictionary mutableCopy];
     
       [cacheDic removeObjectForKey:localURL];
    }
    
    //移除对应文件
    
    localURL = [localURL stringByReplacingOccurrencesOfString:@"://"
                                                   withString:@""];
    localURL = [localURL stringByReplacingOccurrencesOfString:@"/"
                                                   withString:@"{1}quot;"];
    localURL = [localURL stringByAppendingPathExtension:@"cache"];
    
    localURL = [doc stringByAppendingPathComponent:localURL];
    
    NSError *error;
    if ([fileManager fileExistsAtPath:localURL] == YES) {
        [fileManager removeItemAtPath:localURL error:&error];
        if (error)
            return YES;
        return NO;
    }else {
        return YES;
    }
}


-(long)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小

{
    long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    for(int i = 0; i<[array count]; i++){
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) ){
            NSDictionary *fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize;
        }else{
            [self fileSizeForDir:fullPath];
        }
    }
    
    [fileManager release];
    
    return size;
    
}

- (BOOL)removeAllFilesInDoc {
    //Document内缓存
    NSString *doc = [[WGSendBox sharedInstance]docPath];
    BOOL result = [self removeFile:doc];
    
    
    //照片缓存
    NSString *cache = [[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"ImageCache"];
    
    result = [self removeFile:cache];
    
//    if ([fileManager removeItemAtPath:cache error:nil]) {
//        BOOL isDir = NO;
//        BOOL existed = [fileManager fileExistsAtPath:cache isDirectory:&isDir];
//        if ( !(isDir == YES && existed == YES) )
//        {
//            flag = [fileManager createDirectoryAtPath:cache withIntermediateDirectories:YES attributes:nil error:nil];
//        }
//    }
    //请求缓存
    NSString *requestCache = [[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"ASIHTTPRequestCache"];
    
    result = [self removeFile:requestCache];
    
    
    //AFNetWorking缓存
    NSString *afCache = [[[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"com.ccidnet.LiHu"] stringByAppendingPathComponent:@"fsCachedData"];
    result = [self removeFile:afCache];
    
    NSString *afCacheIPAD = [[[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"com.ccidnet.LiHuIPAD"] stringByAppendingPathComponent:@"fsCachedData"];
    result = [self removeFile:afCacheIPAD];
    
    return result;

}

- (BOOL)removeFile:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL flag = NO;
    if ([fileManager removeItemAtPath:path error:nil]) {
        BOOL isDir = NO;
        BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
        if ( !(isDir == YES && existed == YES) )
        {
            flag = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            flag = NO;
        }
    }
    return flag;
}



- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    
    NSString *docPath = [WGSendBox docPath];
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSString* fullPathToFile = [docPath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}


- (long)cacheSize {
    NSString *cache = [[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"ArticalImages"];
    NSString *cache2 = [[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"MKNetworkKitCache"];
    
    long size = [self fileSizeForDir:cache] + [self fileSizeForDir:cache2];
    
    return size;
    
}

- (BOOL)removeCache {
    
    NSString *cache = [[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"ArticalImages"];
    NSString *cache2 = [[[WGSendBox sharedInstance]libCachePath]stringByAppendingPathComponent:@"MKNetworkKitCache"];
    
    BOOL result = [self removeFile:cache];
    
    result = [self removeFile:cache2];
    
    return result;
}

@end
