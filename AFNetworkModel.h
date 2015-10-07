//
//  AFNetworkModel.h
//  UITableView-waterfall
//
//  Created by HGDQ on 15/10/7.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  声明一个协议
 */
@protocol AFNetworkDownloadDelegat <NSObject>

- (void)getDownloadData:(NSData *)downloadData withAFNetworking:(id)AFNetwork;

@end



@interface AFNetworkModel : NSObject


@property (nonatomic,copy)NSString * identity;

@property (nonatomic,strong)id<AFNetworkDownloadDelegat>delegate;

- (void)downloadDataFromURLString:(NSString *)URLString;


@end
