//
//  LNStoreEngine.h
//  Linker
//
//  Created by jimmylee on 6/28/14.
//  Copyright (c) 2014 Handos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNLinkerItem.h"
@interface LNStoreEngine : NSObject


-(void)addMessage;




//通过ID来获取连链条
-(NSMutableArray *)getLink:(NSInteger *)linkId;

//添加链接一个节点
-(Boolean *)addLinkItem:(LNLinkerItem *)linkItem;

//获取一个Link链条
-(NSMutableArray *)getRandomLink;



@end
