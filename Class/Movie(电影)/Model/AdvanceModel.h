//
//  AdvanceModel.h
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15-12-21.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvanceModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *release_date;

@property(nonatomic,assign)NSInteger wanttosee;

@property(nonatomic,copy)NSString *poster_url;

/*
 "film_id": "177323",
 "name": "\u8001\u70ae\u513f",
 "directors": [
 
 ],
 "actors": [
 
 ],
 "release_time": "2015-12-24",
 "item_type": "0",
 "genre": "\u5267\u60c5 \/ \u52a8\u4f5c",
 "intro": "\u66fe\u7ecf\ud...",
 "released": 0,
 "card_type": "ranklist_coming",
 "release_date": "2015.12.24",
 "video_url": "",
 "poster_url": "http:\/\/mu1.sinaimg.cn\/original\/weiyinyue.music.sina.com.cn\/movie_cover\/177323_big.jpg",
 "large_poster_url": "http:\/\/mu1.sinaimg.cn\/frame.750x1080\/weiyinyue.music.sina.com.cn\/movie_cover\/177323_big.jpg",
 "score": "8.5",
 "score_count": 189586,
 "user_score": 0,
 "can_wanttosee": 1,
 "wanttosee": 75757,
 "is_wanttosee": 0
 */
@end
