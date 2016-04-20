//
//  LSHFilmCell.h
//  LSHWebMovie
//
//  Created by meng on 16/4/20.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilmModel;

@interface LSHFilmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *filmName;
@property (weak, nonatomic) IBOutlet UIImageView *loveIcon;
@property (weak, nonatomic) IBOutlet UILabel *wantoSee;
@property (weak, nonatomic) IBOutlet UIImageView *dateIcon;
@property (weak, nonatomic) IBOutlet UILabel *release_date;
@property (weak, nonatomic) IBOutlet UIButton *loveBtn;

@property(nonatomic, strong)FilmModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
