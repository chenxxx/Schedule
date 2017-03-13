//
//  LoginViewController.m
//  schedule
//
//  Created by chenxxx on 16/9/10.
//  Copyright © 2016年 chenxxx. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/Bmob.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *loginImage;
@property (weak, nonatomic) IBOutlet UITextField *uid;
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSubviews
{
    _uid.delegate = self;
    _pwd.delegate = self;
    
    [_uid addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_pwd addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (![_uid isFirstResponder] && ![_pwd isFirstResponder]) {
        return NO;
    }
    return YES;
}


#pragma mark - 键盘操作

- (void)hidenKeyboard
{
    [_uid resignFirstResponder];
    [_pwd resignFirstResponder];
}

- (void)returnOnKeyboard:(UITextField *)sender
{
    if (sender == _uid) {
        [_pwd becomeFirstResponder];
    } else if (sender == _pwd) {
        [self hidenKeyboard];
    }
}


- (IBAction)loginButton:(id)sender {
    
    MBProgressHUD *hub=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.label.text=@"登录中";
    hub.dimBackground=YES;
    
    
    [BmobUser loginWithUsernameInBackground:_uid.text
                                    password:_pwd.text
                                      block:^(BmobUser *user, NSError *error) {
            
            if (user) {
                [hub hide:YES afterDelay:0];
               [self performSegueWithIdentifier:@"loginSegue" sender:self];
            } else {
               hub.label.text=@"账号密码错误";
               hub.dimBackground=YES;
               [hub hide:YES afterDelay:2];
            }
    }];
}


@end
