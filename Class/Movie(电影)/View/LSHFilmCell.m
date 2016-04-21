//
//  LSHFilmCell.m
//  LSHWebMovie
//
//  Created by meng on 16/4/20.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "LSHFilmCell.h"
#import "FilmModel.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface LSHFilmCell()
@property(nonatomic, strong)UIImageView *bgView;
@property(nonatomic, strong)UIView *view;

@end

@implementation LSHFilmCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cellID";
    LSHFilmCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = (LSHFilmCell *)[[[NSBundle mainBundle]loadNibNamed:@"LSHFilmCell" owner:self options:nil] lastObject];
    }
    return cell;
}


- (void)setModel:(FilmModel *)model{

    _model = model;
    
    [self.bgView sd_setImageWithURL:[NSURL URLWithString:model.large_poster_url] placeholderImage:[UIImage imageNamed:@"movie_images_zhezhao"]];
     self.score.text = model.score;
     self.filmName.text = model.name;
    
    if ([model.card_type isEqualToString:@"ranklist_hot"]) {
        self.loveIcon.image = [UIImage imageNamed:@"home_comment"];
        self.wantoSee.text = [NSString stringWithFormat:@"%@人点评",model.score_count];
    }else{
        self.wantoSee.text = [model.wanttosee stringValue];
        self.release_date.text = model.release_date;
        self.dateIcon.image = [UIImage imageNamed:@"weibo-movie_icon_time"];
        self.loveIcon.image = [UIImage imageNamed:@"home_interest"];
    }

}

- (void)awakeFromNib {

    self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    self.score.textColor = [UIColor colorWithRed:1.000f green:0.839f blue:0.267f alpha:1.00f];
    self.bgView.alpha = 0.9;
    
    [self.loveBtn setBackgroundImage:[UIImage imageNamed:@"home_interested_normal"] forState:UIControlStateNormal];
    [self setBackgroundView:self.bgView];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
