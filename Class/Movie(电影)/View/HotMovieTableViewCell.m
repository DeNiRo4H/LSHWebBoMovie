//
//  HotMovieTableViewCell.m
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15/12/20.
//  Copyright © 2015年 LSH. All rights reserved.
//

#import "HotMovieTableViewCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
@implementation HotMovieTableViewCell
{
    UILabel *_nameLabel;
    UILabel *_scoreLabel;
    UIImageView *_headImage;
    UIButton *_button;
}
#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cellID";
    HotMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HotMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self createSubView];
    }
    
    return self;
    
}

-(void)createSubView{
  
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,KscreenWidth, 150)];
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 30)];
    _scoreLabel.textColor = [UIColor yellowColor];
    _scoreLabel.font = [UIFont boldSystemFontOfSize:30];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 105, 150, 30)];
    _nameLabel.font = [UIFont boldSystemFontOfSize:20];
    _nameLabel.textColor = [UIColor whiteColor];
    
    //创建cell上的点击button
    _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_headImage];
    [self.contentView addSubview:_scoreLabel];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_button];
}

//重写set方法
-(void)setModel:(FilmModel *)model{
    
    _nameLabel.text = model.name;
    _scoreLabel.text = model.score;
    
     _model = model;
    
    /*------不用在这里显示图片()-------*/
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.poster_url] placeholderImage:[UIImage imageNamed:@"movie_images_zhezhao"]];
    
}


-(void)clickButton:(UIButton *)button{

    if([self.delegate respondsToSelector:@selector(jumpToAnotherPage:)]){
    
        [self.delegate jumpToAnotherPage:self.model];
    }

}



//如果cell是xib 创建的时候走这个跟方法
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
