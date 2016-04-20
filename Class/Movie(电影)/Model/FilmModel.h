//
//  FilmModel.h
//  LSHWebMovie
//
//  Created by kiki on 15/12/20.
//  Copyright © 2015年 LSH. All rights reserved.
//

/*
 film_id : "178840"
 name : "猎神:冬日之战"
 directors
 actors
 release_time : "2016-04-22"
 item_type : "0"
 genre : "剧情 / 动作 / 奇幻 / 冒险"
 intro : "　　故事将聚焦于克里斯·海姆斯沃斯饰演的猎人和查理兹·塞隆饰演的王后在遇到白雪公主之前的故事，而在第一部中饰演白雪公主的克里斯汀·斯图尔特将不会出演这部续作。 "
 released : 0
 card_type : "ranklist_coming"
 release_date : "后天"
 video_url : ""
 poster_url : "http://weiyinyue.music.sina.com.cn/movie_cover/178840_big.jpg"
 large_poster_url : "http://mu1.sinaimg.cn/frame.750x1080/weiyinyue.music.sina.com.cn/movie_cover/178840_big.jpg"
 score : "6.1"
 score_count : 1742
 user_score : 0
 can_wanttosee : 1
 wanttosee : 1322
 is_wanttosee : 0
 */

#import <Foundation/Foundation.h>

@interface FilmModel : NSObject

@property(nonatomic,copy)NSString *  name;

@property(nonatomic,copy)NSString *  poster_url;

@property(nonatomic,copy)NSString *  score;
@property(nonatomic,assign)NSNumber *  score_count;
@property(nonatomic,copy)NSString * large_poster_url;
@property (nonatomic,assign) NSInteger film_id;

@property(nonatomic,copy)NSString *release_date;

@property(nonatomic,assign)NSNumber *wanttosee;

@property(nonatomic, copy)NSString *card_type;


@end

/*
 film_id : "179204"
 name : "冰河追凶"
 directors
 actors
 release_time : "2016-04-15"
 item_type : "0"
 genre : "犯罪 / 悬疑"
 intro : "犯罪警匪电影《冰河追凶》由徐伟执导，梁家辉、佟大为、周冬雨、邓家佳、魏晨等主演。讲述 “追凶者”深入零下40度极寒之地，追查真凶寻找真相的故事。暗藏杀机的冰河，牵一发而动全身，每个人都无法避免被卷入一场场错综复杂的事件，成为“追凶”成员。而冰河下最终真相却颠覆所有人的想象。"
 released : 1
 card_type : "ranklist_hot"
 release_date : "2016.04.15"
 video_url : ""
 poster_url : "http://weiyinyue.music.sina.com.cn/movie_cover/179204_big.jpg"
 large_poster_url : "http://mu1.sinaimg.cn/frame.750x1080/weiyinyue.music.sina.com.cn/movie_cover/179204_big.jpg"
 score : "7.9"
 score_count : 20173
 user_score : 0
 can_wanttosee : 1
 wanttosee : 12462
 is_wanttosee : 0
 
 */
