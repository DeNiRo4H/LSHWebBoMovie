//
//  ListCollectionViewCell.h
//  LSHWebMovie
//
//  Created by kiki on 16/4/19.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilmModel;

@interface ListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *FilmImage;
@property (weak, nonatomic) IBOutlet UILabel *filmName;

@property(nonatomic,strong)FilmModel * model;


@end
