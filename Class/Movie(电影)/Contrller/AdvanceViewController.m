//
//  AdvanceViewController.m
//  LSHWebMovie
//
//  Created by DeNiRo4H on 15-12-21.
//  Copyright (c) 2015年 LSH. All rights reserved.
//

#import "AdvanceViewController.h"
#import "AFHTTPRequestOperation.h"

@interface AdvanceViewController ()<UITableViewDataSource>

@property(nonatomic,strong)UITableView *advanceTable;

@property(nonatomic, strong)AFHTTPRequestOperation *manager;

@end

@implementation AdvanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

/*
 懒加载
 */
//-(UITableView *)advanceTable{
//
//    if(_advanceTable == nil){
//        
//    }
//
//}







-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
