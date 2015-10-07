//
//  ViewController.m
//  UITableView-waterfall
//
//  Created by HGDQ on 15/10/7.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "ViewController.h"
#import "BaseModel.h"
#import "AFNetworkModel.h"
#import "MyTableViewCell.h"
#import "UIImageView+WebCache.h"

#define URLSTRING1   @"http://itugo.com/client/ios/api/getpiclist?_version=20140117.2.5.1&_req_from=oc&_source=ios&type=&_uuid=efe47094e00109db8c28cf0ae9b607b9&max=&tag=&_promotion_channel=App%20Store&_platform=iPhone&sort=new&from=tag&_uiid=2FF998CF0D2A40E7AF6F8FAFB8F57538&_net=wifi&min=0"

#define URLSTRING2   @"http://itugo.com/client/ios/api/getpiclist?_version=20140117.2.5.1&_req_from=oc&_source=ios&type=accessary&_uuid=efe47094e00109db8c28cf0ae9b607b9&max=&tag=&_promotion_channel=App%20Store&_platform=iPhone&sort=new&from=tag&_uiid=2FF998CF0D2A40E7AF6F8FAFB8F57538&_net=wifi&min=0"

#define URLSTRING3   @"http://itugo.com/client/ios/api/getpiclist?_version=20140117.2.5.1&_req_from=oc&_source=ios&type=shoes&_uuid=efe47094e00109db8c28cf0ae9b607b9&max=&tag=&_promotion_channel=App%20Store&_platform=iPhone&sort=new&from=tag&_uiid=2FF998CF0D2A40E7AF6F8FAFB8F57538&_net=wifi&min=0"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,AFNetworkDownloadDelegat>

@property (nonatomic,strong)NSArray *URLArray;
@property (nonatomic,strong)NSArray *tableViewArr1;
@property (nonatomic,strong)NSArray *tableViewArr2;
@property (nonatomic,strong)NSArray *tableViewArr3;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor grayColor];
	
	[self getURLArray];
	[self startDownload];
	
	[self setMainView];
	
	// Do any additional setup after loading the view, typically from a nib.
}
/**
 *  新建主界面的三个tableView
 */
- (void)setMainView{
	for (int i = 0; i < self.URLArray.count; i ++) {
		UITableView *tableView = [[UITableView alloc] init];
		tableView.frame = CGRectMake(5*(i + 1) + 100*i, 0, 100, 568);
		tableView.tag = 100 + i;
		tableView.delegate = self;
		tableView.dataSource = self;
		[self.view addSubview:tableView];
		
		tableView.bounces = NO;
		tableView.showsVerticalScrollIndicator = NO;
		
		[tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
	}
}
/**
 *  设置每个tableView里面显示的cell的个数
 *
 *  @param tableView tableView本身
 *  @param section   第几个section
 *
 *  @return 需要设置的个数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger tag = tableView.tag;
	if (tag == 100) {
		return self.tableViewArr1.count;
	}
	if (tag == 101) {
		return self.tableViewArr2.count;
	}
	if (tag == 102) {
		return self.tableViewArr3.count;
	}
	return 0;
}
/**
 *  设置cell的高度
 *
 *  @param tableView tableView本身
 *  @param indexPath cell的位置
 *
 *  @return 设置的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger tag = tableView.tag;
	if (tag == 100) {
		BaseModel *model = (BaseModel *)self.tableViewArr1[indexPath.row];
		float height = model.height.floatValue;
		return height/2.0;
	}
	if (tag == 101) {
		BaseModel *model = (BaseModel *)self.tableViewArr2[indexPath.row];
		float height = model.height.floatValue;
		return height/2.0;
	}
	if (tag == 102) {
		BaseModel *model = (BaseModel *)self.tableViewArr3[indexPath.row];
		float height = model.height.floatValue;
		return height/2.0;
	}
	return 0;
}
/**
 *  tableView加载cell
 *
 *  @param tableView tableView 本身
 *  @param indexPath cell的位置
 *
 *  @return cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger tag = tableView.tag;
	static NSString * identify = @"Cell";
	MyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:self options:nil] firstObject];
	}
	if (tag == 100) {
		BaseModel *model = (BaseModel *)self.tableViewArr1[indexPath.row];
		[cell.backImageView setImageWithURL:[NSURL URLWithString:model.pic_url_d]];
		return cell;
	}
	if (tag == 101) {
		BaseModel *model = (BaseModel *)self.tableViewArr2[indexPath.row];
		[cell.backImageView setImageWithURL:[NSURL URLWithString:model.pic_url_d]];
		return cell;
	}
	if (tag == 102) {
		BaseModel *model = (BaseModel *)self.tableViewArr3[indexPath.row];
		[cell.backImageView setImageWithURL:[NSURL URLWithString:model.pic_url_d]];
		return cell;
	}
	return nil;
}
/**
 *  tableView滚动的协议方法
 *
 *  @param scrollView scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	UITableView *tableView1 = (UITableView *)[self.view viewWithTag:100];
	UITableView *tableView2 = (UITableView *)[self.view viewWithTag:101];
	UITableView *tableView3 = (UITableView *)[self.view viewWithTag:102];
	
	if (scrollView == tableView1) {
		[tableView2 setContentOffset:tableView1.contentOffset];
		[tableView3 setContentOffset:tableView1.contentOffset];
	}
	if (scrollView == tableView2) {
		[tableView1 setContentOffset:tableView2.contentOffset];
		[tableView3 setContentOffset:tableView2.contentOffset];
	}
	if (scrollView == tableView3) {
		[tableView2 setContentOffset:tableView3.contentOffset];
		[tableView1 setContentOffset:tableView3.contentOffset];
	}
}
/**
 *  把下载链接存进数组
 */
- (void)getURLArray{
	self.URLArray = @[URLSTRING1,URLSTRING2,URLSTRING3];
}
/**
 *  开始下载数据
 */
- (void)startDownload{
	for (int i = 0; i < self.URLArray.count; i ++) {
		AFNetworkModel *model = [[AFNetworkModel alloc] init];
		model.identity = [NSString stringWithFormat:@"%d",i];
		model.delegate = self;
		[model downloadDataFromURLString:self.URLArray[i]];
	}
}
/**
 *  下载数据协议方法
 *
 *  @param downloadData 下载成功后返回的数据
 *  @param AFNetwork    AFNetworkModel本质
 */
- (void)getDownloadData:(NSData *)downloadData withAFNetworking:(id)AFNetwork{
	AFNetworkModel *model = (AFNetworkModel *)AFNetwork;
	//得到AFNetworkModel的identity
	NSString *identify = model.identity;
	//解析下载后的数据
	NSDictionary *dice = [NSJSONSerialization JSONObjectWithData:downloadData options:NSJSONReadingMutableContainers error:nil];
	if ([identify isEqualToString:@"0"]) {
		UITableView *tableView = (UITableView *)[self.view viewWithTag:100];
		BaseModel *dataModel = [[BaseModel alloc] init];
		self.tableViewArr1 = [dataModel setBaseModelWithDictionary:dice];
		[tableView reloadData];
	}
	if ([identify isEqualToString:@"1"]) {
		UITableView *tableView = (UITableView *)[self.view viewWithTag:101];
		BaseModel *dataModel = [[BaseModel alloc] init];
		self.tableViewArr2 = [dataModel setBaseModelWithDictionary:dice];
		[tableView reloadData];
	}
	if ([identify isEqualToString:@"2"]) {
		UITableView *tableView = (UITableView *)[self.view viewWithTag:102];
		BaseModel *dataModel = [[BaseModel alloc] init];
		self.tableViewArr3 = [dataModel setBaseModelWithDictionary:dice];
		[tableView reloadData];
	}
}










- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end



























































