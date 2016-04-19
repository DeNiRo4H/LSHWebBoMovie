//
//  AdvanceTableViewCell.m
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15-12-21.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import "AdvanceTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"

@implementation AdvanceTableViewCell
{
    UILabel *_nameLabel;
    UILabel *_wanttoseeLabel;
    UILabel *_release_dateLabel;
    UIImageView *_headImage;
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cellID";
    AdvanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[AdvanceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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

    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,  90, 180, 30)];
    _nameLabel.font = [UIFont boldSystemFontOfSize:20];
    _nameLabel.textColor = [UIColor whiteColor];
    
    _wanttoseeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 100, 30)];
    _wanttoseeLabel.font = [UIFont boldSystemFontOfSize:13];
    _wanttoseeLabel.textColor = [UIColor whiteColor];
    
    _release_dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 120, 100, 30)];
    _release_dateLabel.font = [UIFont boldSystemFontOfSize:13];
    _release_dateLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_headImage];
    [self.contentView addSubview:_wanttoseeLabel];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_release_dateLabel];
}

//重写set方法
-(void)setModel:(AdvanceModel *)model{
    
    _nameLabel.text = model.name;
    _wanttoseeLabel.text =
    [NSString stringWithFormat:@"%ld",model.wanttosee];
    
    _release_dateLabel.text = model.release_date;
    /*------不用在这里显示图片()-------*/
 
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.poster_url] placeholderImage:[UIImage imageNamed:@"movie_images_zhezhao"]];
    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
