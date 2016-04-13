//
//  FilmModel.h
//  LSHWebMovie
//
//  Created by kiki on 15/12/20.
//  Copyright © 2015年 LSH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilmModel : NSObject

@property(nonatomic,copy)NSString *  name;

@property(nonatomic,copy)NSString *  poster_url;

@property(nonatomic,copy)NSString *  score;

@property (nonatomic,assign) NSInteger film_id;

@end
