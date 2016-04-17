//
//  MovieListTableViewCell.m
//  LSHWebMovie
//
//  Created by 宋成博 on 15/12/25.
//  Copyright © 2015年 LSH. All rights reserved.
//

#import "MovieListTableViewCell.h"

@implementation MovieListTableViewCell



#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cellID";
    MovieListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MovieListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
