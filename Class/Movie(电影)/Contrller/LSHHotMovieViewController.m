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
#import "LSHMovieTool.h"
#import "FilmListModel.h"

static const int tableViewTag = 90;
//头上的三个标题

@interface LSHHotMovieViewController()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)NSMutableArray *dataSources;
@property(nonatomic, strong)LSHSegmentView *titleView;
@property(nonatomic, strong)LSHMovieTool *movieTool;
@end

@implementation LSHHotMovieViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self navigationTitleView];
    [self createScrollView];
    
    //加载数据(初始加载热门电影)
    [self loadMovieDataComplicate:nil type:HotMovie next:NO];

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
        
        self.scrollView.contentOffset = CGPointMake((index-1) * WIDTH, 0);
        if ([self.dataSources[index-1]count] == 0) {
            [self loadMovieDataComplicate:nil type:(TitleType)index-1 next:NO];
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
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.backgroundColor = [UIColor grayColor];
        
        [self.scrollView addSubview:tableView];

    }
    
}

//加载数据 重新加载数据
-(void)loadMovieDataComplicate:(void(^)())complicate type:(TitleType)type next:(BOOL)isNext{
    if (self.movieTool == nil) {
        self.movieTool = [[LSHMovieTool alloc]init];
    }
    
    [self.movieTool movieDataDownloadNext:isNext complicate:^(BOOL success, id data) {
        if (isNext) {
            [self.dataSources[type] addObjectsFromArray:data];
        }else{
            //第一页
            [self.dataSources[type] removeAllObjects];
            [self.dataSources[type] addObjectsFromArray:data];
            
        }
        [[self tableViewWithType:type]reloadData];

    } TYPE:type];
    
}


-(UITableView  *)tableViewWithType:(TitleType)type{
    return (UITableView *)[self.scrollView viewWithTag:
        type + tableViewTag];
}


#pragma mark - tableView 协议方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleType type = tableView.tag - tableViewTag;
    if (type == MovieList) {
        return 250;
    }
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSources[tableView.tag - tableViewTag]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TitleType type = tableView.tag - tableViewTag;
    if (type == Advance) {
        AdvanceTableViewCell *cell = [AdvanceTableViewCell cellWithTableView:tableView];
        
        AdvanceModel *model = self.dataSources[tableView.tag - tableViewTag][indexPath.row];
        
        cell.model = model;
        
        return cell;
        
    }else if (type == HotMovie){
        HotMovieTableViewCell *cell = [HotMovieTableViewCell cellWithTableView:tableView];
        
        FilmModel *model = self.dataSources[tableView.tag - tableViewTag][indexPath.row];
        cell.model = model;
        return cell;
        
    }else if(type == MovieList){
        MovieListTableViewCell *cell = [MovieListTableViewCell cellWithTableView:tableView];
        FilmListModel *model = self.dataSources[tableView.tag - tableViewTag][indexPath.row];
        
        cell.model = model;
        
        cell.delegate = self;
        //cell 需要请求数据 cell中显示的电影需要网络请求
        
        if (model.films.count == 0) {
            
            [self.movieTool loadFilmListWithId:cell.model.pagelist_id complicate:^(BOOL success, id data) {
                if (success) {
                    if (cell.model == model) {//请求到数据刷新
                        cell.model.films = [NSMutableArray arrayWithArray:data];
                        [cell.collectionView reloadData];
                        
                    }
                }
                
            }];
            
        }
        
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
