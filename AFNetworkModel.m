//
//  AFNetworkModel.m
//  UITableView-waterfall
//
//  Created by HGDQ on 15/10/7.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "AFNetworkModel.h"
#import "AFNetworking.h"

@implementation AFNetworkModel

/**
 *  AFNetwork类下载数据
 *
 *  @param URLString 下载地址的URLString
 */
- (void)downloadDataFromURLString:(NSString *)URLString{
	
	NSURL * url = [NSURL URLWithString:URLString];
#pragma mark - 监听网络状态
	AFHTTPRequestOperationManager * manage = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
	[manage.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
		if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
			
			UIAlertView * netStatusAl = [[UIAlertView alloc] initWithTitle:@"服务器连接失败" message:@"请检查网络连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
			[netStatusAl show];  //请检查网络连接
		}
	}];
	//开始监听
	[manage.reachabilityManager startMonitoring];
	
#pragma mark - AFHTTP异步下载后 解析Json数据  代理
	manage.responseSerializer = [AFHTTPResponseSerializer serializer];
	[manage GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
		//		NSLog(@"responseObject = %@",responseObject);
		[self.delegate getDownloadData:responseObject withAFNetworking:self];
		
	}failure:^(AFHTTPRequestOperation *operation, NSError *error){
		//		NSLog(@"error = %@",error);
		//1.服务器连接失败
		//2.断网
		UIAlertView * netStatusAl = [[UIAlertView alloc] initWithTitle:@"服务器连接失败" message:@"请检查网络连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
		[netStatusAl show];  //请检查网络连接
	}];
}


@end
