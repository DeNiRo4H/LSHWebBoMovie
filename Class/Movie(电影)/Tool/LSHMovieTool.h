//
//  LSHMovieTool.h
//  LSHWebMovie
//
//  Created by kiki on 16/4/19.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>


#define FIRSTPAGE @"http://ting.weibo.com/movieapp/rank/hot"
#define SECONDPAGE @"http://ting.weibo.com/movieapp/rank/coming"
#define THIRDPAGE @"http://ting.weibo.com/movieapp/pagelist/recommend"
#define FILMLIST  @"http://ting.weibo.com/movieapp/pagelist/recommendmovie"

//首页热映
//@"http://ting.weibo.com/movieapp/rank/hot"

//预告
//@"http://ting.weibo.com/movieapp/rank/coming"

//某电影详情  必须参数 id  为某电影的 id
//@"http://ting.weibo.com/movieapp/page/base" @{@"id":@""}

//影单
//http://ting.weibo.com/movieapp/pagelist/recommend

//影单.推荐 必须参数  id 为推荐单的 id
//@"http://ting.weibo.com/movieapp/pagelist/recommendmovie" @{@"id":@""}

//影单.热议榜
//@"http://ting.weibo.com/movieapp/pagelist/hotpoll"

//影单.想看榜
//http://ting.weibo.com/movieapp/pagelist/willpoll

//不知道是什么 自己试一试
//@"http://ting.weibo.com/movieapp/Pagelist/square"






//给block起 别名
//类型 void(^)(BOOL success , id data)
//别名是 Complicate

//枚举
//typedef NS_ENUM(NSInteger, TABLE_TYPE) {
//    
//    HOT,//热映
//    COMING,//推荐
//    LIST,//第三页
//};
typedef NS_ENUM(NSInteger, TitleType){
    HotMovie = 0,//热映
    Advance,//推荐
    MovieList,//第三页
};
typedef void(^Complicate)(BOOL success , id data);

@interface LSHMovieTool : NSObject
//存放三种页码
{
    NSInteger _page[3];
}

//下载 对应数据     是下一页还是  刷新
- (void)movieDataDownloadNext:(BOOL)ret complicate:(Complicate) complicate TYPE:(TitleType)type;

//获取影单
- (void)loadFilmListWithId:(NSString *)listID complicate:(Complicate)complicate ;


@end
