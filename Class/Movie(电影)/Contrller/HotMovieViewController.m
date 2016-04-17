//
//  HotMovieViewController.m
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15-12-19.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import "HotMovieViewController.h"
#import "AFNetworking.h"
#import "HotMovieTableViewCell.h"
#import "AdvanceModel.h"
#import "AdvanceTableViewCell.h"
#import "FMDBManager.h"
#import "hotMovieDetailViewController.h"
#import "MovieListTableViewCell.h"


#define WIDTH  self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

static NSString *hotID =@"hotID";
static NSString *advanceID =@"advanceID";
static NSString *movieListID =@"movieListID";

@interface HotMovieViewController ()<UITableViewDataSource,UITableViewDelegate,hotMovieTableViewCellDelegate,UIScrollViewDelegate>

//创建数据的数据
@property(nonatomic ,strong)NSMutableArray *hotDataArray;
@property(nonatomic,strong)NSMutableArray *advanceDataArray;
@property(nonatomic, strong)NSMutableArray *movieListDataArray;

//三个tableView
@property(nonatomic ,strong)UITableView *advanceTableView;

@property(nonatomic, strong)UITableView *hotTableView;

@property(nonatomic, strong)UITableView *movieListTableView;

@property(nonatomic, strong)AFHTTPRequestOperationManager *manager;

@property(nonatomic, strong)HotMovieTableViewCell *request;

//button
@property(nonatomic, strong)UIButton *hotButton;

@property(nonatomic, strong)UIButton *advanceButton;

@property(nonatomic, strong)UIButton  *movieListButton;

@property(nonatomic, strong)UIButton *sliderButton;

@property(nonatomic, strong)FilmModel *hotModel;


@end

@implementation HotMovieViewController{

    UIScrollView *_scrollView;

}


- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.263f green:0.290f blue:0.322f alpha:1.00f];     //创建上方的切换按钮
    [self navigationBarSetting];
    //得到缓存数据
    [self GetcacheDataSource];
    //创建数据源
    [self createDataSource];
     //创建滚动视图
    [self createScrollView];
    
}
/*
 懒加载方式
 */
//热门数组
-(NSMutableArray *)hotDataArray {
    
    if(_hotDataArray == nil){
        
        _hotDataArray = [NSMutableArray array];
    }
    return _hotDataArray;
}
//预告数组
-(NSMutableArray *)advanceDataArray{

    if(!_advanceDataArray){
        _advanceDataArray = [[NSMutableArray alloc]init];
    }
    return _advanceDataArray;

}

//影单数组
-(NSMutableArray *)movieListDataArray{
    
    if (!_advanceDataArray) {
        _advanceDataArray = [[NSMutableArray alloc]init];
    }
    return _advanceDataArray;

}

//预告tableView
-(UITableView *)advanceTableView{
    
    if(_advanceTableView == nil){
        
        _advanceTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH,0, WIDTH, HEIGHT) style:UITableViewStylePlain];
        //建立代理关系
        _advanceTableView.dataSource = self;
        //注册
        [_advanceTableView registerClass:[AdvanceTableViewCell class] forCellReuseIdentifier:advanceID];
        //行高
        _advanceTableView.rowHeight = 150;
        //self表示scrollView
        [self.view addSubview:_advanceTableView];

    }
    return _advanceTableView;
}


//热门tableView
-(UITableView *)hotTableView{
    
    if(_hotTableView == nil){
        
        _hotTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //建立代理关系
        _hotTableView.dataSource = self;
        //注册
        [_hotTableView registerClass:[HotMovieTableViewCell class] forCellReuseIdentifier:hotID];
        //行高
        _hotTableView.rowHeight = 150;
        //self表示scrollView
        [self.view addSubview:_hotTableView];
        
    }
    return _hotTableView;
}
//影单
-(UITableView *)movieListTableView{

    if (_movieListTableView == nil) {
        _movieListTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
        _movieListTableView.dataSource = self;
        _movieListTableView.delegate = self;
        //注册
        [_movieListTableView registerClass:[MovieListTableViewCell class] forCellReuseIdentifier:movieListID];
        //设置行高
        _movieListTableView.rowHeight = 200;
        [self.view addSubview:_movieListTableView];
    }
    return _movieListTableView;
}


-(AFHTTPRequestOperationManager *)manager{
    
    if(_manager == nil){
        
        _manager = [AFHTTPRequestOperationManager manager];
        
        //设置成json解析器(第三方解析)
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    }
    return _manager;
}



#pragma mark - 通过数据库得到缓存数据
-(void)GetcacheDataSource{

    NSArray *models = [[FMDBManager manager]searchWithFilm:@"select * from t_film;"];
    self.hotDataArray = [NSMutableArray arrayWithArray:models];
    //刷新tableView
    [self.hotTableView reloadData];

}





#pragma mark - 创建滚动视图
- (void)createScrollView{

    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled = YES;
    
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.view.bounds.size.height *6);
    //朝着一个方向滑动之后不能向其他地方滑动
    _scrollView.directionalLockEnabled = YES;
    
    
    //创建scrollView的协议代理
    _scrollView.delegate = self;
    
//
//    _scrollView.bounces = NO;//不能超过contentSize
//    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    _scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_scrollView];
    //self.tableView 调用get方法
    [_scrollView addSubview:self.hotTableView];
    [_scrollView addSubview:self.advanceTableView];
    [_scrollView addSubview:self.movieListTableView];
    


}




#pragma mark - 创建数据源

-(void)createDataSource{
    
    [self.manager POST:@"http://ting.weibo.com/movieapp/rank/hot" parameters:@{@"page":@"1",@"number":@"5"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@", responseObject);
        NSArray *array = responseObject[@"data"][@"ranklist_hot"];
        
        //在请求数据回来之后,清空之前的数据
        [self.hotDataArray removeAllObjects];
        
        
        for(NSDictionary *key in array){
            
            FilmModel *model = [[FilmModel alloc]init];
            //属性一一对应
            [model setValuesForKeysWithDictionary:key];
            
            //写入数据库
            [[FMDBManager manager]insertWithFilm:model];
            
            [self.hotDataArray addObject:model];
        }
        [self.hotTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    [self.manager POST:@"http://ting.weibo.com/movieapp/rank/coming" parameters:@{@"page":@"1",@"number":@"5"} success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *array = responseObject[@"data"][@"ranklist_coming"];
        for(NSDictionary *key in array){
            
            AdvanceModel *model = [[AdvanceModel alloc]init];

            [model setValuesForKeysWithDictionary:key];
            
            [self.advanceDataArray addObject:model];
        }
        
        //刷新
        [self.advanceTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

    
    
    
    
    
}

#pragma mark - 创建上方的导航栏

-(void)navigationBarSetting{
    
    //得到navigation控制器
    UINavigationController *nc = self.navigationController;
    //改变条的颜色
    nc.navigationBar.barTintColor = [UIColor colorWithRed:0.220f green:0.208f blue:0.314f alpha:1.00f];
    //设置为不透明,默认是透明的
    nc.navigationBar.translucent =  NO;
    
    //搜索
    UIImage *searchImage = [UIImage imageNamed:@"sousuo"];
    UIImage *lsearchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //定义搜索事件
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithImage:lsearchImage style:UIBarButtonItemStyleDone target:self action:@selector(searchClick:)];
    //设置标题视图
    self.navigationItem.titleView = [self SwitchButton];
    //设置右视图
    self.navigationItem.rightBarButtonItem = searchItem;
}

/*--------切换按钮---------*/
-(UIView *)SwitchButton{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 230, 44)];
    //创建button
    //热点
    _hotButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 40, 40)];
    
    _hotButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
   
    [_hotButton setTitle:@"热映" forState:UIControlStateNormal];
   
    //添加hot点击事件
    [_hotButton addTarget:self action:@selector(hotButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //预告
    _advanceButton = [[UIButton alloc]initWithFrame:CGRectMake(95, 0, 40, 40)];

    [_advanceButton setTitle:@"预告" forState:UIControlStateNormal];
    //添加预告点击事件
    [_advanceButton addTarget:self action:@selector(advanceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //影单
    _movieListButton = [[UIButton alloc]initWithFrame:CGRectMake(175, 0, 40, 40)];
    _movieListButton.tag = 3;
    [_movieListButton setTitle:@"影单" forState:UIControlStateNormal];
    //添加影单的点击事件
    [_movieListButton addTarget:self action:@selector(movieListButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //滑条
    _sliderButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 42, 65, 3)];
    _sliderButton.backgroundColor = [UIColor yellowColor];
   
    
    [view addSubview:_hotButton];
    [view addSubview:_advanceButton];
    [view addSubview:_movieListButton];
    [view addSubview:_sliderButton];
    return view;
}

//点击预告
-(void)advanceButtonClick:(UIButton *)advanceButton{
    
    NSLog(@"点击了预告");
    
    //增大预告的字体
    advanceButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //缩小热门的字体
    self.hotButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //缩小影单的字体
    self.movieListButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderButton.frame = CGRectMake(0+80, 42, 65, 3);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        //改变滚动偏移量
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }];
    

}

//点击热点
-(void)hotButtonClick:(UIButton *)hotButton{
    
    NSLog(@"点击了热点");
    [hotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //增大热点的字体
//    [hotButton setFont:[UIFont boldSystemFontOfSize:20]];
    //缩小预告的字体
    hotButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    [self.advanceButton setFont:[UIFont systemFontOfSize:18]];
    self.advanceButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //缩小影单的字体
//    [self.movieListButton setFont:[UIFont systemFontOfSize:18]];
    self.movieListButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    //改变滑条的位置
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderButton.frame = CGRectMake(0, 42, 65, 3);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        //改变滚动偏移量
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
    
}

//点击影单
-(void)movieListButtonClick:(UIButton *)movieListButton{
  
    NSLog(@"点击了影单");
    //影单的字体变大

    movieListButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //缩小预告的字体

    self.advanceButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //缩小热门的字体

    self.hotButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderButton.frame = CGRectMake(0+80+80, 42, 65, 3);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        //改变滚动偏移量
        _scrollView.contentOffset = CGPointMake(WIDTH*2, 0);
    }];

}


//搜素事件
-(void)searchClick:(UIBarButtonItem *)searchItem{
    
    NSLog(@"点击了搜索");

}









#pragma mark - tableViewDataSource协议方法
//返回每组多少行
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.hotTableView){
    return self.hotDataArray.count;
    }else if (tableView == self.advanceTableView){
        return self.advanceDataArray.count;
    }else if(tableView == self.movieListTableView){
    
        return self.movieListDataArray.count;
    }
    return 0;
}
//创建cell后刷新
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.hotTableView) {
        HotMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotID forIndexPath:indexPath];
        
        FilmModel *model = self.hotDataArray[indexPath.row];
        
        cell.model = model;
    
        //获得当前行的值(不能对应上相应的cell)
//        self.hotModel = self.hotDataArray[indexPath.row];
        
        cell.delegate = self;
        
        return cell;
    }else if (tableView == self.advanceTableView){
        AdvanceTableViewCell *advanceCell = [tableView dequeueReusableCellWithIdentifier:advanceID forIndexPath:indexPath];
        
        AdvanceModel *model = self.advanceDataArray[indexPath.row];
        
        advanceCell.model = model;
        
        return advanceCell;
    }else if(tableView == self.movieListTableView){
       
        MovieListTableViewCell *movieListCell = [tableView dequeueReusableCellWithIdentifier:movieListID forIndexPath:indexPath];
        
        
        //------设置模型---------//
        movieListCell.textLabel.text = @"DAIXIE";
        
        return movieListCell;
    }
    
   
    return nil;
}


#pragma mark - 自定义的cell协议方法
-(void)jumpToAnotherPage:(FilmModel *)model{
    
    hotMovieDetailViewController *detail = [[hotMovieDetailViewController alloc]init];
    
    detail.hotModel = model;
    
//    if ([self.delegate respondsToSelector:@selector(receiveWithModel:)]) {
//        
//        [self.delegate receiveWithModel:self.hotModel];
//    }
    
    [self.navigationController pushViewController:detail animated:YES];
    
}


#pragma mark - UISrollViewdelegate协议方法

//已经结束滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point = _scrollView.contentOffset;
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderButton.frame = CGRectMake(point.x/WIDTH * 80, 42, 65, 3);
    }];

}



@end
