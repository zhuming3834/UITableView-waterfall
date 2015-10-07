//
//  BaseModel.h
//  瀑布流
//
//  Created by HGDQ on 15/10/6.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic,copy)NSString *brand_name;
@property (nonatomic,copy)NSNumber *height;
@property (nonatomic,copy)NSNumber *width;
@property (nonatomic,copy)NSString *pic_url_d;
@property (nonatomic,copy)NSString *pic_url_x;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *title;


- (NSArray *)setBaseModelWithDictionary:(NSDictionary *)dice;









@end






















