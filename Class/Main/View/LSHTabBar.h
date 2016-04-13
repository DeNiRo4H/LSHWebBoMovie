//
//  LSHTabBar.h
//  LSHWebMovie
//
//  Created by kiki on 16/4/12.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSHTabBar;

@protocol LSHTabBarDelegate <NSObject>

@optional
- (void)tabBar:(LSHTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

- (void)tabBarDidClickedPlusButton:(LSHTabBar *)tabBar;

@end

@interface LSHTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<LSHTabBarDelegate> delegate;

@end
