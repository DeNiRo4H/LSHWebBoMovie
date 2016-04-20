//
//  LSHMovieTool.m
//  LSHWebMovie
//
//  Created by kiki on 16/4/19.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "LSHMovieTool.h"
#import "AFNetworking.h"
#import "LSHHTTPTool.h"
#import "FilmListModel.h"
#import "FilmModel.h"


@interface LSHMovieTool()
@end

@implementation LSHMovieTool

- (instancetype)init{

    if (self = [super init]) {
        _page[0] = 1;
        _page[1] = 1;
        _page[2] = 1;
    }
    return self;
}

//下载 对应数据     是下一页还是  刷新
- (void)movieDataDownloadNext:(BOOL)ret complicate:(Complicate) complicate TYPE:(TitleType)type{
    NSString * urlStr = nil;
    switch (type) {
        case HotMovie:
        {
            urlStr =  FIRSTPAGE;
        }
            break;
        case Advance:
        {
            urlStr = SECONDPAGE;
        }
            break;
        case MovieList:
        {
            urlStr = THIRDPAGE;
        }
            break;
        default:
            break;
    }
    if (ret) {//如果是下一页
        _page[type] ++;
    }else{
        _page[type] = 1;
    }
    NSDictionary *dic = @{@"page":@(_page[type])};
    
    [LSHHTTPTool postWithURL:urlStr params:dic success:^(id json) {
    //解析
    switch (type) {
        case HotMovie:
        case Advance:
        {
            NSString * key = @[@"ranklist_hot",@"ranklist_coming"][type];
            NSArray * array = json[@"data"][key];
            NSMutableArray * models = [NSMutableArray arrayWithCapacity:array.count];
            
            for (NSDictionary * dic in array ) {
                FilmModel * model = [[FilmModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [models addObject:model];
            }
            complicate(YES,models);
        }
            break;
        case MovieList:
        {
            NSArray * array = json[@"data"][@"list"];
            NSMutableArray * models = [NSMutableArray arrayWithCapacity:array.count];
#pragma warming 使用的是KVC,待改
            for (NSDictionary * dic in array ) {
                FilmListModel  *model = [[FilmListModel alloc]initWithDictionary:dic error:nil];
//               FilmListModel  *model = [FilmListModel 
//                [model setValuesForKeysWithDictionary:dic];
//                model.user = [[UserModel alloc] init];
//                [model.user setValuesForKeysWithDictionary:dic[@"user"]];
                [models addObject:model];
            }
            complicate(YES,models);
        }
            break;
        default:
            break;
    }
    } failure:^(NSError *error) {
        
    }];

}

//获取影单
- (void)loadFilmListWithId:(NSString *)listID complicate:(Complicate)complicate{
    
    NSDictionary *dic = @{@"id":listID};
    [LSHHTTPTool postWithURL:FILMLIST params:dic success:^(id json) {
     
            NSArray * array = json[@"data"][@"list"];
            NSMutableArray * filmModels = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary * dic in array ) {
                FilmModel * model = [[FilmModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                //电影模型数组
                [filmModels addObject:model];
            }
            if (complicate) {
                complicate(YES,filmModels);
            }
        
    } failure:^(NSError *error) {
        LSHLog(@"%@",error);
    }];
    

}



@end
