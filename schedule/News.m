//
//  News.m
//  schedule
//
//  Created by chenxxx on 16/9/4.
//  Copyright © 2016年 chenxxx. All rights reserved.
//

#import "News.h"

@implementation News


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
       
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}




+(instancetype)newsWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}


@end
