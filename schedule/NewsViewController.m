//
//  ScheduleViewController.m
//  schedule
//
//  Created by chenxxx on 16/9/4.
//  Copyright © 2016年 chenxxx. All rights reserved.
//

#import "NewsViewController.h"
#import <RESideMenu/RESideMenu.h>
#import "RootViewController.h"
#import "SideMenuViewController.h"
#import "TabBarViewController.h"
#import "MJRefresh.h"
#import "News.h"
#import "NewsDetailViewController.h"
#import "NewsCell.h"

@interface NewsViewController ()

- (IBAction)sideButton:(id)sender;
@property(nonatomic,strong)NSMutableArray *newsList;

@property(nonatomic)NSInteger index;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor=COLOR(255, 255, 255, 1);
    self.tableView.rowHeight=116;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
         [self.tableView.mj_header beginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(NSMutableArray *)newsList{
    if (_newsList==nil) {
        NSURL *url=[[NSBundle mainBundle] URLForResource:@"news" withExtension:@"plist"];
        _newsList =[NSMutableArray arrayWithContentsOfURL:url];
        
        NSMutableArray *arrM=[NSMutableArray array];
        
        for (NSDictionary *dict in  _newsList) {
           News *model=[News newsWithDict:dict];
            [arrM addObject:model];
            
        }
        _newsList=arrM;
        
    }
    
    return _newsList;
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell=[NewsCell cellWithTableView:tableView];
    cell.news=self.newsList[indexPath.row];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  
    self.index = indexPath.row;
    [self performSegueWithIdentifier:@"newsSegue" sender:self];
    
    
}


-(void)loadMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_newsList addObjectsFromArray:_newsList];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
   //     self.tableView.mj_footer.hidden = YES;
    });
    
}

-(void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [_newsList addObjectsFromArray:_newsList];
        [self.tableView reloadData];
        NSLog(@"2");
        [self.tableView.mj_header endRefreshing];
        //self.tableView.mj_header.hidden = YES;
    });

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        NewsDetailViewController *newsDetailVc=segue.destinationViewController;
        newsDetailVc.news=self.newsList[self.index];
    
}
- (IBAction)sideButton:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}
@end
