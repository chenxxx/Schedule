//
//  NewsDetailViewController.m
//  schedule
//
//  Created by chenxxx on 16/9/4.
//  Copyright © 2016年 chenxxx. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;

@property (weak, nonatomic) IBOutlet UILabel *newsTime;

@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

@property (weak, nonatomic) IBOutlet UILabel *newsText;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor=COLOR(255, 255, 255, 0.7);
    
    self.newsTitle.numberOfLines = 0;
    self.newsText.numberOfLines = 0;
    
    _newsTitle.text=_news.title;
    _newsTitle.font = [UIFont systemFontOfSize: 20.0];
    
    NSURL * imageurl = [NSURL URLWithString:_news.pic];
    NSData * imagedata = [NSData dataWithContentsOfURL:imageurl];
    
    _newsImage.image = [UIImage imageWithData:imagedata];
  
    _newsText.text=_news.text;
    self.title=@" ";
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
