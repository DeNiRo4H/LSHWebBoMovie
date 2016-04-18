//
//  LSHHotMovieViewController.m
//  LSHWebMovie
//
//  Created by kiki on 16/4/14.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "LSHHotMovieViewController.h"
#import "AFNetworking.h"
#import "HotMovieTableViewCell.h"
#import "AdvanceModel.h"
#import "AdvanceTableViewCell.h"
#import "FMDBManager.h"
#import "hotMovieDetailViewController.h"
#import "MovieListTableViewCell.h"
#import "Header.h"
#import "LSHSegmentView.h"

static const int tableViewTag = 90;
//头上的三个标题
typedef enum titleType{
    HotMovie = 0,
    Advance,
    MovieList,
}TitleType;


@interface LSHHotMovieViewController()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)NSMutableArray *dataSources;
@property(nonatomic, strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic, strong)LSHSegmentView *titleView;

@end

@implementation LSHHotMovieViewController
- (void)viewDidLoad{
    
    [self navigationTitleView];
    [self createScrollView];
    //加载数据(初始加载热门电影)
    [self loadDataWithType:HotMovie];

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



- (NSMutableArray *)dataSources{
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

#pragma mark 导航栏上的item
- (void)navigationTitleView{
 
    NSArray *titles = @[@"热映",@"预告",@"影单"];
    
    LSHSegmentView * titleView = [[LSHSegmentView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth-30, 44) titles:titles clickBlick:^(NSInteger index) {
        NSLog(@"---%ld",index);
        self.scrollView.contentOffset = CGPointMake((index-1) * WIDTH, 0);
        if ([self.dataSources[index-1]count] == 0) {
            [self loadDataWithType:(TitleType)index-1];
        }
    }];
    
    self.titleView = titleView;
    titleView.titleFont = [UIFont systemFontOfSize:18];
    titleView.titleNomalColor = [UIColor whiteColor];
    titleView.titleSelectColor = [UIColor colorWithRed:1.000f green:0.839f blue:0.267f alpha:1.00f];
    self.navigationItem.titleView = self.titleView;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.220f green:0.208f blue:0.314f alpha:1.00f];
    
    //定义搜索事件
    UIImage *searchImage = [UIImage imageNamed:@"weibo-movie_icon_min_search"];

    UIImage *originalImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithImage:originalImage style:UIBarButtonItemStyleDone target:self action:@selector(searchClick:)];
    self.navigationItem.rightBarButtonItem = searchItem;
    
}

//搜素事件
-(void)searchClick:(UIBarButtonItem *)searchItem{
    
    NSLog(@"点击了搜索");
    
}


/**
 *  创建scrollview
 */
-(void)createScrollView{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, KscreenWidth, KscreenHeight-49)];
    //翻页
    self.scrollView.pagingEnabled = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.scrollView.bounces = NO;
    
    //创建tableview
    [self createTableView];
    
    //设置scrollview的大小
    self.scrollView.contentSize = CGSizeMake(KscreenWidth*3, self.scrollView.frame.size.height);
    
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    
}

- (void)createTableView{

    for(int i = 0; i< 3;i++){
       
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        //将小数组添加到大数组
        [self.dataSources addObject:array];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
        
        tableView.tag = i + tableViewTag;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.rowHeight = 150;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.backgroundColor = [UIColor grayColor];
        
        [self.scrollView addSubview:tableView];

    }
    
}


#pragma mark - 加载dataSource
//根据类型(哪个tabview)来加载数据
-(void)loadDataWithType:(TitleType )type{
    
    NSString *baseUrl = @"http://ting.weibo.com/movieapp/rank/";
    NSString *URL = nil;
    if (type == HotMovie) {
        URL = [NSString stringWithFormat:@"%@%@",baseUrl,@"hot"];
    }else if (type == Advance){
       URL = [NSString stringWithFormat:@"%@%@",baseUrl,@"coming"];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@"1",@"number":@"5"}];
    
    [self.manager POST:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (type == HotMovie) {
            NSArray *array = responseObject[@"data"][@"ranklist_hot"];
            for(NSDictionary *key in array){
                FilmModel *model = [[FilmModel alloc]init];
                //属性一一对应
                [model setValuesForKeysWithDictionary:key];
                [self.dataSources[type] addObject:model];
            }
        }else if (type == Advance){
        
            NSArray *array = responseObject[@"data"][@"ranklist_coming"];
           
            for(NSDictionary *key in array){
              AdvanceModel *model = [[AdvanceModel alloc]init];
                //属性一一对应
                [model setValuesForKeysWithDictionary:key];
                [self.dataSources[type] addObject:model];
            }
        }
        
        //刷新tableview
        [[self tableViewWithType:type] reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        LSHLog(@"%@", error);
    }];
    

}

-(UITableView  *)tableViewWithType:(TitleType)type{
    return (UITableView *)[self.scrollView viewWithTag:
        type + tableViewTag];
}


#pragma mark - tableView 协议方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSources[tableView.tag - tableViewTag]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((tableView.tag - tableViewTag) == Advance) {
        AdvanceTableViewCell *cell = [AdvanceTableViewCell cellWithTableView:tableView];
        
        AdvanceModel *model = self.dataSources[tableView.tag - tableViewTag][indexPath.row];
        
        cell.model = model;
        
        return cell;
        
    }else if ((tableView.tag - tableViewTag) == HotMovie){
        HotMovieTableViewCell *cell = [HotMovieTableViewCell cellWithTableView:tableView];
        
        FilmModel *model = self.dataSources[tableView.tag - tableViewTag][indexPath.row];
        cell.model = model;
        return cell;
        
    }else{
        MovieListTableViewCell *cell = [MovieListTableViewCell cellWithTableView:tableView];
        return cell;
    }
    return nil;
    
}

#pragma mark - UIScrollview代理方法

#pragma mark - scrollviewdelegate协议方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.scrollView == scrollView) {
        
        NSInteger index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
       
        [self.titleView btnClick:self.titleView.btns[index]];
    }
    
}


@end
