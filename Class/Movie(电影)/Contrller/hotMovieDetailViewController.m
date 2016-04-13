//
//  hotMovieDetailViewController.m
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15-12-24.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import "hotMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#define WIDTH    self.view.bounds.size.width
#define HEIGHT   self.view.bounds.size.height
@interface hotMovieDetailViewController (){
  
    UIImageView *_imageView;
    UILabel *_nameLable;

}

@end

@implementation hotMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];

//    hot.delegate = self;
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    
    [_imageView setImageWithURL:[NSURL URLWithString:self.hotModel.poster_url]];
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50/2, 10, 100, 50)];
    
    _nameLable.text = self.hotModel.name;
    _nameLable.font = [UIFont systemFontOfSize:20];
    _nameLable.textColor = [UIColor whiteColor];
    
    
    [self.view addSubview:_imageView];
    [self.view addSubview:_nameLable];
}



@end
