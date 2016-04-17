//
//  HotMovieTableViewCell.h
//  LSHWebMovie
//
//  Created by kiki on 15/12/20.
//  Copyright © 2015年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmModel.h"
#import "UIImageView+AFNetworking.h"

@protocol hotMovieTableViewCellDelegate <NSObject>

- (void)jumpToAnotherPage:(FilmModel *)model;

@end


@interface HotMovieTableViewCell : UITableViewCell

@property(nonatomic, weak)id<hotMovieTableViewCellDelegate>delegate;

//@property(nonatomic, strong)UIImageView *headImage;

@property(nonatomic , strong)FilmModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
