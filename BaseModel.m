//
//  BaseModel.m
//  瀑布流
//
//  Created by HGDQ on 15/10/6.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

/**
 *  把封装的数据模型存入数组
 *
 *  @param dice 需要分装的字典
 *
 *  @return 模型数组
 */
- (NSArray *)setBaseModelWithDictionary:(NSDictionary *)dice{
	NSMutableArray *baseModelArr = [[NSMutableArray alloc] init];
	NSArray *dataArr = dice[@"data"][@"data"];
	for (NSDictionary *dic in dataArr) {
		BaseModel *model = [BaseModel setModelWithDictionary:dic];
		[baseModelArr addObject:model];
	}
	return baseModelArr;
}
/**
 *  数据模型的封装
 *
 *  @param dice 需要封装的字典数据
 *
 *  @return 返回一个封装好的数据模型
 */
+ (BaseModel *)setModelWithDictionary:(NSDictionary *)dice{
	BaseModel *model = [[BaseModel alloc] init];
	//由于数据存在以new开头的字段，这里重新声明了属性 选取关键数据单个封装
	[model setValue:dice[@"brand_name"] forKey:@"brand_name"];
	[model setValue:dice[@"new_height"] forKey:@"height"];
	[model setValue:dice[@"new_width"] forKey:@"width"];
	[model setValue:dice[@"pic_url_d"] forKey:@"pic_url_d"];
	[model setValue:dice[@"pic_url_x"] forKey:@"pic_url_x"];
	[model setValue:dice[@"price"] forKey:@"price"];
	[model setValue:dice[@"title"] forKey:@"title"];
	return model;
}

@end





























