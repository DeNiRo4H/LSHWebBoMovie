//
//  FMDBManager.m
//  LSHSqlite_FMDB
//
//  Created by DeNiRo4H on 15-12-21.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDB.h"


static NSString *sqlTable = @"create table if not exists t_film (film_id integer primary key autoincrement , name text ,score text,poster_url text);";

@implementation FMDBManager{
    
    FMDatabase *_db;
    NSMutableArray *_filmDataArray;

}

//创建单例
+ (instancetype)manager{
    static FMDBManager *manager = nil;
    if(manager == nil){
    
        manager = [[FMDBManager alloc]init];
    
    }
    return manager;
}

-(instancetype)init{
    
    if(self = [super init]){
       
        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/weiboHotMovie.sqlite"];
        
        NSLog(@"%@", filePath);
        //创建数据库管理器
        _db = [FMDatabase databaseWithPath:filePath];
        //打开数据库
        int ret= [_db open];
        
        if(ret){
        
            BOOL success = [_db executeUpdate:sqlTable];
            if (success) {
                NSLog(@"创建表成功");
            }else{
                NSLog(@"创建表失败");
            }
        }
        
    }
    return self;
}



//插入数据
-(void)insertWithFilm:(FilmModel *)film{

    NSString *sql = @"insert into t_film values(?,?,?,?)";
    
     int ret = [_db executeUpdate:sql,@(film.film_id),film.name,film.score,film.poster_url];
  
    if(ret){
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
}


//更新
-(void)updateFilm:(FilmModel *)film{
    
    
    NSString * sql = @"update t_film set name = ? ,score = ? , poster_url = ? where film_id = ?";
    
    
    BOOL success = [_db executeUpdate:sql,film.name,film.score,film.poster_url,@(film.film_id)];
    
    if (success) {
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败");
    }
    
}

//删除某个学生
-(void)deleteFilm:(FilmModel *)film{
    
    NSString * deleteSql = @"delete from t_film where film_id = ?";
    
    [_db executeUpdate:deleteSql,@(film.film_id)];
    
}





//查询
-(NSArray *)searchWithFilm:(NSString *)sql{

    _filmDataArray = [[NSMutableArray alloc]init];
    
    FMResultSet *result = [_db executeQuery:sql];
    
    while([result next]){
        
//        Student *student = [[Student alloc]init];
//        student.name = [result stringForColumnIndex:1];
//         student.studentID = [result intForColumnIndex:0];
//        student.age = [result intForColumnIndex:2];
//        [_studentDataArray addObject:student];
        FilmModel *film = [[FilmModel alloc]init];
        film.film_id = [result intForColumn:@"film_id"];
        film.name = [result stringForColumn:@"name"];
        film.score = [result stringForColumn:@"score"];
        film.poster_url = [result stringForColumn:@"poster_url"];
        
        [_filmDataArray addObject:film];
    }
    
    return _filmDataArray;

}



@end
