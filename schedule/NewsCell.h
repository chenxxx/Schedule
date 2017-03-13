//
//  NewsCell.h
//  schedule
//
//  Created by chenxxx on 16/9/4.
//  Copyright © 2016年 chenxxx. All rights reserved.
//


#import <UIKit/UIKit.h>
@class News;

@interface NewsCell : UITableViewCell


@property (nonatomic, strong) News *news;


+ (instancetype)cellWithTableView:(UITableView *)tableVeiw ;
@end
