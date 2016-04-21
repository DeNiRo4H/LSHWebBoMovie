//
//  LSHFilmDetailVC.m
//  LSHWebMovie
//
//  Created by kiki on 16/4/22.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "LSHFilmDetailVC.h"
#import "Header.h"
#import "FilmModel.h"
#import "UIImageView+WebCache.h"
#import "ParallaxHeaderView.h"

 static NSString *cellID = @"cellID";
@interface LSHFilmDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@end

@implementation LSHFilmDetailVC

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource= self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight =200;
    UIImageView *imageview = [[UIImageView alloc]init];
    [imageview sd_setImageWithURL:[NSURL URLWithString:self.model.large_poster_url] ];

    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:imageview.image forSize:CGSizeMake(self.tableView.frame.size.width, 300)];

    headerView.headerTitleLabel.text = self.model.name;
    
    [self.tableView setTableHeaderView:headerView];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
