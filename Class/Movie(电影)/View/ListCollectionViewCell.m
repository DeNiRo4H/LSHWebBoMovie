//
//  ListCollectionViewCell.m
//  LSHWebMovie
//
//  Created by kiki on 16/4/19.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "ListCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "FilmModel.h"

@implementation ListCollectionViewCell
- (void)setModel:(FilmModel *)model{
    _model = model;
    [_FilmImage sd_setImageWithURL:[NSURL URLWithString:model.poster_url] placeholderImage:[UIImage imageNamed:@"weibo_movie_empty_"]];
    _filmName.text = model.name;

}


- (void)awakeFromNib {
    // Initialization code
}

@end
