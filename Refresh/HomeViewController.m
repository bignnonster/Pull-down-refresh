//
//  HomeViewController.m
//  Refresh
//
//  Created by user on 12-11-2.
//  Copyright (c) 2012年 zyuq. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    if (_refreshHeaderView==nil) {
        EGORefreshTableHeaderView* view1=[[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 10-self.myTableView.bounds.size.height, self.myTableView.frame.size.width, self.view.bounds.size.height)];
        view1.delegate=self;
        [self.myTableView addSubview:view1];
        _refreshHeaderView=view1;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)reloadTableViewDataSource
{
   
    NSLog(@"==开始加载数据");
    _reloading=YES;
    //加载数据的操作在这个方法里实现
     //[self.myTableView reloadData];
    
}
- (void)doneLoadingTableViewData
{
    NSLog(@"==加载万数据");
    _reloading=NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
}
#pragma mark –
#pragma mark onClick
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isflage=!isflage;
    [super.navigationController setNavigationBarHidden:isflage animated:TRUE];
    [super.navigationController setToolbarHidden:isflage animated:TRUE];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"diyici");
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tag"];
    if (cell==nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:@"tag"] autorelease];
    }
    //表格设计
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    NSLog(@"scrollViewdidscroller");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    NSLog(@"scrollViewdidscroller11111111");
}
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

@end
