//
//  HomeViewController.h
//  Refresh
//
//  Created by user on 12-11-2.
//  Copyright (c) 2012年 zyuq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,
EGORefreshTableHeaderDelegate>
{
    BOOL isflage;
    IBOutlet UITableView* myTableView;
    EGORefreshTableHeaderView* _refreshHeaderView;
    BOOL _reloading;
}
@property(nonatomic,retain)UITableView* myTableView;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
