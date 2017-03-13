//
//  CourseViewController.m
//  schedule
//
//  Created by chenxxx on 16/9/4.
//  Copyright © 2016年 chenxxx. All rights reserved.
//

#import "CourseViewController.h"
#import <RESideMenu/RESideMenu.h>
#import "RootViewController.h"
#import "SideMenuViewController.h"
#import "TabBarViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <BmobSDK/Bmob.h>


@interface CourseViewController (){
    UIScrollView *tableScrowView;
    CGFloat  dayWidth;
    CGFloat  sectionHeight;
    NSDictionary *dataDict;
    UIImageView  *bgImageView;
}
- (IBAction)sideButton:(id)sender;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor=COLOR(227, 227, 227, 1);
    CGFloat startY=65;
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, startY+30, SCREEN_WIDTH-30, SCREEN_HEIGHT-startY-30-49)];
    bgImageView.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:bgImageView];
    self.title=@"课程表";
    
    
    //添加顶部星期背景
    UIView *headBg=[[UIView alloc]initWithFrame:CGRectMake(0, startY, SCREEN_WIDTH, 30)];
    
    headBg.backgroundColor=COLOR(52, 113, 165, 0.7);
    [self.view addSubview:headBg];// Do any additional setup after loading the view, typically from a nib.
    //定义基本宽高
    dayWidth=(CGFloat) (SCREEN_WIDTH-30)/5;
    sectionHeight=(CGFloat)(SCREEN_HEIGHT-(StatusBar_HEIGHT+NavigationBar_HEIGHT+TabBar_HEIGHT)-30)/8;
    
    
#pragma mark    添加ScrowView能左右滚动
    tableScrowView=[[UIScrollView alloc]init];
    tableScrowView.frame=CGRectMake(0, startY, SCREEN_WIDTH,sectionHeight*8+35);
    tableScrowView.contentSize =  CGSizeMake(dayWidth*7+30, 0);
    tableScrowView.bounces=NO;
    [self.view addSubview:tableScrowView];
    
    
#pragma mark  添加星期头部
    
    int i;
    NSString *weektitle[]={@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"};
    for(i =0; i<7;i++)
    {
        UIButton *buttonview = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //为button显示赋值
        
        [buttonview setTitle:weektitle[i] forState:UIControlStateNormal];
        [buttonview setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //设置button的大小
        buttonview.frame = CGRectMake( 30+i*dayWidth, 0, dayWidth, 30);
        [tableScrowView addSubview:buttonview];
        
    }
    
    
#pragma mark   添加左边节数 标示
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0,startY+ 30, 30, sectionHeight*8)];
    [self.view addSubview:sectionView];
    for(i =0; i<8;i++)
    {
        //新建一个button对象 button还有一些别的属性比如背景色
        NSString *title=[NSString stringWithFormat:@"%d",i+1];
        
        UILabel *numLabel=[[UILabel alloc]init];
        numLabel.backgroundColor=[UIColor lightGrayColor];
        if (i%2) {
            [numLabel setAlpha:0.5f];
        }else{
            [numLabel setAlpha:0.7f];
        }
        numLabel.text=title;
        numLabel.textColor=[UIColor whiteColor];
        numLabel.textAlignment=NSTextAlignmentCenter;
        numLabel.frame = CGRectMake(0, i*sectionHeight, 30, sectionHeight);
        [sectionView addSubview:numLabel];
        
    }
    
    [self addLesson];
}

-(void)addLesson{
    MBProgressHUD *hub=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText=@"查询中";
    hub.dimBackground=YES;

    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Course"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [hub hide:YES afterDelay:0];
        for (BmobObject *object in array) {
            CGFloat weekday = [[object objectForKey:@"weekday"]floatValue];
            CGFloat wave = [[object objectForKey:@"wave"]floatValue];
            NSString *name = [object objectForKey:@"name"];
            NSString *teacher = [object objectForKey:@"teacher"];
            UIButton *courseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            CGFloat lessonX=30+ dayWidth*(weekday-1);
            CGFloat lessonY=30+sectionHeight*(2*wave-2);
            CGFloat lessonH=2*sectionHeight;
            CGFloat lessonW=dayWidth;
            courseButton.layer.cornerRadius = 5.0f;
            courseButton.frame = CGRectMake( lessonX, lessonY, lessonW-2, lessonH-2);
            courseButton.titleLabel.numberOfLines=0;
            courseButton.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
            [courseButton setTitle:[NSString stringWithFormat:@"%@\n%@",name,teacher]
                          forState:UIControlStateNormal];
            courseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            courseButton.backgroundColor = [self randomColor];
            courseButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
            [tableScrowView addSubview:courseButton];
        }
    }];
        
        
    
    
}
- (UIColor *)randomColor
{
    
    UIColor *color1 = RGBColor(170, 226, 29, 0.6);
    UIColor *color2 = RGBColor(251, 136, 71, 0.6);
    UIColor *color3 = RGBColor(163, 77, 140, 0.6);
    UIColor *color4 = RGBColor(29, 111, 226, 0.6);
    UIColor *color5 = RGBColor(226, 131, 29, 0.6);
    UIColor *color6 = RGBColor(29, 226, 226, 0.6);
    NSArray *array = [[NSArray alloc] initWithObjects:color1,color2,color3,color4,color5,color6, nil];
    return [array objectAtIndex:arc4random()%6];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sideButton:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}
@end
