//
//  LSHTabBarViewController.m
//  LSHWebMovie
//
//  Created by kiki on 16/4/12.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "LSHTabBarViewController.h"
#import "LSHNavigationViewController.h"
#import "LSHTabBar.h"
#import "HotMovieViewController.h"
#import "FilmReviewViewController.h"
#import "AddViewController.h"
#import "BuyTicketViewController.h"
#import "IndividualCenterViewController.h"

@interface LSHTabBarViewController ()<LSHTabBarDelegate>

@property(nonatomic,strong)LSHTabBar *customTabBar;

@end

@implementation LSHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBar];
    [self setupAllChildViewControllers];
}
/*
 设置自定义tabBar,添加到系统的tabbar
*/
- (void)setUpTabBar{
    LSHTabBar *customTabBar = [[LSHTabBar alloc]init];
   customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
   self.customTabBar = customTabBar;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //删除系统的tabBar
    for(UIView *child in self.tabBar.subviews){
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    
    //1 电影
    HotMovieViewController *hot = [[HotMovieViewController alloc]init];
    [self setupChildViewController:hot title:@"电影" imageName:@"label_bar_movie_normal" selectedImageName:@"label_bar_movie_selected"];
    
    //2 影评
    FilmReviewViewController *review = [[FilmReviewViewController alloc]init];
    [self setupChildViewController:review title:@"消息" imageName:@"label_bar_film_critic_normal" selectedImageName:@"label_bar_film_critic_selected"];
    
    //3 添加
//    AddViewController *add = [[AddViewController alloc]init];
//    [self setupChildViewController:add title:@"" imageName:@"label_bar_add" selectedImageName:@""];
////
    //4 购票
    BuyTicketViewController *ticket =[[BuyTicketViewController alloc]init];
   [self setupChildViewController:ticket title:@"购票" imageName:@"label_bar_tickets_normal" selectedImageName:@"label_bar_tickets_selected"];
    
    //5 我的个人中心
    IndividualCenterViewController *individual = [[IndividualCenterViewController alloc]init];
    

    [self setupChildViewController:individual title:@"我的" imageName:@"label_bar_my_normal" selectedImageName:@"label_bar_my_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;

    
    // 2.包装一个导航控制器
    LSHNavigationViewController *nav = [[LSHNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(LSHTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

- (void)tabBarDidClickedPlusButton:(LSHTabBar *)tabBar
{
    AddViewController *add = [[AddViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:add];
    [self presentViewController:nav animated:YES completion:nil];
}



@end
