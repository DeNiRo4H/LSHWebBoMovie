//
//  MovieListTableViewCell.m
//  LSHWebMovie
//
//  Created by 宋成博 on 15/12/25.
//  Copyright © 2015年 LSH. All rights reserved.
//

#import "MovieListTableViewCell.h"
#import "FilmListModel.h"
#import "Header.h"
#import "UIImage+MJ.h"
#import "ListCollectionViewCell.h"
static const CGFloat LSHListCellBoder = 5;
static NSString *cellID = @"cellID";

@interface MovieListTableViewCell()

@end
@implementation MovieListTableViewCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cellID";
    
  [tableView registerNib:[UINib nibWithNibName:@"MovieListTableViewCell"  bundle:nil] forCellReuseIdentifier:ID];
    
    MovieListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[MovieListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//    
//    }
//    return self;
//}

- (void)setModel:(FilmListModel *)model{
    
    _model = model;
    self.name.text = model.name;
    self.rand.text = [NSString stringWithFormat:@"%@部",[model.movie_count stringValue]];
    
    self.nameAndPerson.text = [NSString stringWithFormat:@"%@创建/%@人关注影单",model.user.name,[model.follow_count stringValue]] ;
    
    //self.delegate 表示cell的代理就是控制器
    self.collectionView.delegate = self.delegate;
    
//    [self.collectionView reloadData];


}

//懒加载

-(UICollectionView *)collectionView{
  
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(KscreenWidth / 4 -10, 162);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
        CGFloat collecY = CGRectGetMaxY(self.nameAndPerson.frame);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(LSHListCellBoder, collecY, KscreenWidth - 2 * LSHListCellBoder -3 , 200) collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        //collection 的代理设置为tableViewcell的代理，也是控制器。
        _collectionView.delegate = self.delegate;
        
        //注册collectionView
        [_collectionView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _model.films.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.model = _model.films[indexPath.row];
    
    return cell;
    
}




- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
