//
//  SideMenuViewController.m
//  schedule
//
//  Created by chenxxx on 16/9/3.
//  Copyright © 2016年 chenxxx. All rights reserved.
//

#import "SideMenuViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <BmobSDK/Bmob.h>

@interface SideMenuViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userNumber;
@property (weak, nonatomic) IBOutlet UILabel *userClass;
@property (weak, nonatomic) IBOutlet UILabel *userMajor;



@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MBProgressHUD *hub=[MBProgressHUD showHUDAddedTo:self.view animated:YES];

    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        [hub hide:YES afterDelay:0];
        _userName.text = [@"姓名：" stringByAppendingString:[bUser objectForKey:@"user_name"]];
        _userNumber.text = [@"学号："stringByAppendingString:[bUser objectForKey:@"user_number"]];
        _userClass.text = [@"班级：" stringByAppendingString:[bUser objectForKey:@"user_class"]];
        _userMajor.text = [@"专业：" stringByAppendingString:[bUser objectForKey:@"user_major"]];
        NSURL * imageurl = [NSURL URLWithString:[bUser objectForKey:@"user_url"]];
        NSData * imagedata = [NSData dataWithContentsOfURL:imageurl];
        _userImage.image = [UIImage imageWithData:imagedata];

        _userName.font = [UIFont systemFontOfSize: 16.0];
        _userNumber.font = [UIFont systemFontOfSize: 14.0];
        _userClass.font = [UIFont systemFontOfSize: 14.0];
        _userMajor.font = [UIFont systemFontOfSize: 14.0];
      
    }else{
        hub.labelText=@"网络连接出错";
        [hub hide:YES afterDelay:2];
    }
    
        // Do any additional setup after loading the view.
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
