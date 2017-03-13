//
//  News.h
//  schedule
//
//  Created by chenxxx on 16/9/4.
//  Copyright © 2016年 chenxxx. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;



-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)newsWithDict:(NSDictionary *)dict;
@end
