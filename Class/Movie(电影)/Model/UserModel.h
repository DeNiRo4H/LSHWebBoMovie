//
//  UserModel.h
//  LSHWebMovie
//
//  Created by kiki on 16/4/21.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSHBaseModel.h"
/*
 pagelist_id : "7814384"
 name : "历届柏林电影节金熊奖电影（1990-）"
 user
 id : 1691294102
 name : "孤飞的蓬"
 avatar_large : "http://tp3.sinaimg.cn/1691294102/180/40002773102/0"
 movie_count : 25
 follow_count : 42
 */
//用户
@interface UserModel :LSHBaseModel

@property(nonatomic,copy)NSString * avatar_large;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * name;

@end
