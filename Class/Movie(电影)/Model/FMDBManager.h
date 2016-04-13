//
//  FMDBManager.h
//  LSHSqlite_FMDB
//
//  Created by DeNiRo4H on 15-12-21.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilmModel.h"

@interface FMDBManager : NSObject
//创建单例
+ (instancetype)manager;

//插入数据
- (void)insertWithFilm:(FilmModel *)film;

//更新学生数据
- (void)updateFilm:(FilmModel *)film;

//删除
- (void)deleteFilm:(FilmModel *)film;


//查询
- (NSArray *)searchWithFilm:(NSString *)sql;




@end
