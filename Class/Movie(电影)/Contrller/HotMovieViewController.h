//
//  HotMovieViewController.h
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15-12-19.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmModel.h"

@protocol hotMovieTableViewDelegate <NSObject>

- (void)receiveWithModel:(FilmModel *)model;

@end

@interface HotMovieViewController : UIViewController


@property(nonatomic, weak)id<hotMovieTableViewDelegate>delegate;



@end
