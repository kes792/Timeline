//
//  ViewController.m
//  Timeline
//
//  Created by Jim on 2019/3/30.
//  Copyright © 2019 Jim. All rights reserved.
//
#import "UIImageView+WebCache.h"

#import "ViewController.h"
#import <MJRefresh.h>
#import "MMomentDatamanager.h"
#import "MUser.h"
#import "MMoment.h"
#import "MomentCell.h"

#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define STATUS_HEIGHT         [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT         self.navigationController.navigationBar.frame.size.height
#define ALLTOP_HEIGHT         (STATUS_HEIGHT + NAVBAR_HEIGHT)

#define LOAD_PAGE 5

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MomentCellDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    SDWebImageManager *manager  = [SDWebImageManager sharedManager];
    //manager.
    

    [super viewDidLoad];
    //
    [self configData];
    // 导航
    [self setNavigationbar];
    // UI
    [self configUILayout];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setNavigationbar
{
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    [navBar setBackgroundImage:[UIImage new]
                 forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    [navBar setTranslucent:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                           target:self
                                                                                           action:@selector(addMoment:)];
    UIView *textView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    textView1.backgroundColor=[UIColor clearColor];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:textView1.frame];
    [titleLable setText:@"朋友圈"];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [textView1 addSubview:titleLable];
    [self.navigationItem setTitleView:textView1];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void) configUILayout
{
    // 表格
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                             -ALLTOP_HEIGHT,
                                                             SCREEN_WIDTH,
                                                             SCREEN_HEIGHT)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //_tableView.estimatedRowHeight = 0;
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_WIDTH)];
    [headerView setBackgroundColor:[UIColor redColor]];
    _tableView.tableHeaderView = headerView;
    _tableView.tableFooterView = [UIView new];
    [self scrollViewDidScroll:_tableView];
    [self.view addSubview: _tableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSArray *array = [[MMomentDatamanager sharedKit] getMomentList:(int)[self.momentList count]
                                                            pageNumber:LOAD_PAGE];
        [self.momentList addObjectsFromArray: array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
    [footer.arrowView setImage:[UIImage imageNamed:@"refresh_pull.png"]];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松手加载更多" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载"     forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已加载全部"   forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    _tableView.mj_footer = footer;
}

#pragma mark - Data
-(void) configData
{
    self.momentList = [[NSMutableArray alloc] init];
    
    __weak ViewController *weakSelf = self;
    [[MMomentDatamanager sharedKit] getALLMomentData:weakSelf completion:^(NSError *error) {
        if(error){
            NSLog(@"error:\n%@",error);
        }
        else{
            [self.momentList addObjectsFromArray: [[MMomentDatamanager sharedKit] getMomentList:0
                                                                                     pageNumber:LOAD_PAGE]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    }];
}

#pragma mark - MomentCellDelegate
- (void)didOperateMoment:(MomentCell *)cell operateType:(int)operateType{
    
    switch (operateType)
    {
        case 0:// 全文/ 折疊
        {
            NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
            if (indexPath) {
                [UIView performWithoutAnimation:^{
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                          withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                //[self.tableView reloadData];
            }
            break;
        }
        case 1:// menu: like|comment 收起其他的 menuView
        {
            /*
            NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
            if (indexPath) {
                [UIView performWithoutAnimation:^{
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                          withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                //[self.tableView reloadData];
            }
            */
            
            break;
        }
            break;
    }
}

#pragma mark - Button
- (IBAction)addMoment:(id)sender
{
    NSLog(@"新增");
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MMoment *moment = (MMoment *)[self.momentList objectAtIndex:[indexPath row]];
    //NSLog(@"%f", moment.rowHeight);
    return moment.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMoment *moment = (MMoment *)[self.momentList objectAtIndex:[indexPath row]];
    return moment.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.momentList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"MomentCell";

    MomentCell *cell = nil;
    if (!cell) {
        cell = [[MomentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.moment = (MMoment *)[self.momentList objectAtIndex:[indexPath row]];
    cell.delegate = self;
    //[cell.moreButton addTarget:self action:(nonnull SEL) forControlEvents:<#(UIControlEvents)#>

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    CGFloat alpha = 0;
    CGFloat offset = scrollView.contentOffset.y ;
    
    //TODO: 滑到封面相片的一半再開始算，可再優化，用三角函數讓透明度更更圓滑
    int half_coverImageHeiht = (SCREEN_WIDTH ) / 2;//231

    if(offset > half_coverImageHeiht)
        alpha  = (offset - half_coverImageHeiht) / half_coverImageHeiht;
    else
        alpha = 0;
    
    //NSLog(@"offset - half_coverImageHeiht=%4f, offset=%4f, alpha = %4f",
    //offset - half_coverImageHeiht, offset, alpha);
    if (alpha >= 1) {
        alpha = 1;
        [self.navigationController.navigationBar setTranslucent:NO];
        [self setWhiteTheme:NO];
    }
    else{
        if(alpha >= 0.55)
            [self setWhiteTheme:NO];
        else
            [self setWhiteTheme:YES];

        if (alpha >= 0.65)
            [self.navigationController.navigationBar setTranslucent:NO];
        else
            [self.navigationController.navigationBar setTranslucent:YES];
        
    }
    UILabel *titleL = (UILabel *)self.navigationItem.titleView;
    [titleL setAlpha:alpha];
    
    UIColor *alphaColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:alpha];
    UIImage *alphaImage = [self imageWithColor:alphaColor];
    [self.navigationController.navigationBar setBackgroundImage:alphaImage
                                                  forBarMetrics:UIBarMetricsDefault];
    //NSLog(@"contentOffset.y=%4f, offset=%4f, alpha = %4f",scrollView.contentOffset.y, offset , alpha);
}

#pragma mark -  Tool Method
-(void) setWhiteTheme:(BOOL) flag{
    if(flag){
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    else{
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    return theImage;
}

@end
