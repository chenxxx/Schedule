//
//  NewsCell.m
//  schedule
//
//  Created by chenxxx on 16/9/4.
//  Copyright © 2016年 chenxxx. All rights reserved.
//


#import "NewsCell.h"
#import <UIKit+AFNetworking.h>
#import "News.h"

@interface NewsCell ()

@property (nonatomic, weak) UIImageView *picV;


@property (nonatomic, weak) UILabel *titleV;

@property (nonatomic, weak) UILabel *textV;


@property (nonatomic, weak) UILabel *footerV;






@end

@implementation NewsCell



+ (instancetype)cellWithTableView:(UITableView *)tableVeiw {
    static NSString *ID = @"News";
    NewsCell *cell = [tableVeiw dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

/** 重写自定义cell的初始化方法,让cell一创建出来就有它所需要的子控件 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell初始化自定义视图


        UIImageView *imageView=[[UIImageView alloc]init];

        [self.contentView addSubview:imageView];
        self.picV=imageView;

        UILabel *titleView=[[UILabel alloc]init];

        [self.contentView addSubview:titleView];
        self.titleV=titleView;
     

        UILabel *textV=[[UILabel alloc]init];
        textV.font=[UIFont systemFontOfSize:15];
        textV.textColor=COLOR(50, 50, 50, 1);
        [self.contentView addSubview:textV];
        self.textV=textV;


        UILabel *footerView=[[UILabel alloc]init];
        footerView.textAlignment=NSTextAlignmentRight;
        footerView.textColor=[UIColor lightGrayColor];
        self.footerV.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:footerView];
        self.footerV=footerView;
        self.backgroundColor=COLOR(255, 255, 255, 0.5);


    }
    return self;
}




-(void)setNews:(News *)news{
    _news=news;

    [self settingFrame];

    [self settingData];



}

-(void)settingData{
    NSURL *url=[NSURL URLWithString:_news.pic];
    [self.picV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"headImg"]];
    self.titleV.text=_news.title;


    self.textV.text=[_news.text substringToIndex:30];

    self.footerV.text=_news.time;



}


-(void)settingFrame{

    CGFloat picW=100;
    CGFloat picH=picW;
    self.picV.frame=CGRectMake(Margin, Margin, picW, picH);

    self.titleV.frame=CGRectMake(CGRectGetMaxX(self.picV.frame)+Margin, Margin, SCREEN_WIDTH-3*Margin-picW, 20);

    CGFloat textW=SCREEN_WIDTH-3*Margin-picW;
    NSDictionary *attr=@{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize textSize=   [[_news.text substringToIndex:30] boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    self.textV.frame=CGRectMake(CGRectGetMaxX(self.picV.frame)+Margin, Margin+20, textSize.width, textSize.height);
    self.textV.numberOfLines=0;


    self.footerV.frame=CGRectMake(108+Margin, CGRectGetMaxY(self.picV.frame)-25, SCREEN_WIDTH-3*Margin-picW, 20);
    


}

@end
