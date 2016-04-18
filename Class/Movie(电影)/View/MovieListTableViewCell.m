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
#import "ListCollectionViewCell.h"
static NSString *cellID = @"cellID";
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self setUpTopView]
    }
    return self;
}

- (void)setModel:(FilmListModel *)model{

    _name.text = model.name;
    _rand.text = [model.follow_count stringValue];
    //self.delegate 表示cell的代理就是控制器
    self.collectionView.delegate = self.delegate;
    
    [self.collectionView reloadData];
}

//懒加载

-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 170);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 35, KscreenWidth-10, 200) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self.delegate;
        
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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
