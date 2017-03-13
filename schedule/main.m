//
//  main.m
//  schedule
//
//  Created by chenxxx on 16/9/10.
//  Copyright © 2016年 chenxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appKey = @"93d087819310b1df768ba38a9b0c61d8";
        [Bmob registerWithAppKey:appKey];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
