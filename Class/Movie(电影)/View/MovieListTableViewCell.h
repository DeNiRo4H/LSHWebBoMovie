//
//  MovieListTableViewCell.h
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15/12/25.
//  Copyright © 2015年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilmListModel;

@interface MovieListTableViewCell : UITableViewCell<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *rand;

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong) FilmListModel *model;

@property(nonatomic,weak)id<UICollectionViewDelegate>delegate;


+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
