//
//  AddFriendViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "AddFriendViewController.h"
#import "SearchViewController.h"
@interface AddFriendViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
// searchTableView
@property (strong, nonatomic)  UITableView *searchTableView;
// 搜索按钮
@property (nonatomic, strong) UIButton *searchButton;
// 存放所有数据的数组
@property (nonatomic, strong) NSMutableArray *allDataArray;
// 存放搜索出结果的数组
@property (nonatomic, strong) NSArray *searchResultDataArray;
// 搜索控制器
@property (nonatomic, strong) UISearchController *searchController;
// 搜索使用的表示图控制器
@property (nonatomic, strong) SearchViewController *searchTVC;
// 搜索框输入的东西
@property (nonatomic, copy) NSString *inputText;

@end

@implementation AddFriendViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    //自身的tableview
    self.searchTableView = [[UITableView alloc] init];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:_searchTableView];
    // 创建出搜索使用的表示图控制器
    self.searchTVC = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // 使用表示图控制器创建出搜索控制器
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_searchTVC];
    
    // 搜索框检测代理
    //（这个需要遵守的协议是 <UISearchResultsUpdating> ，这个协议中只有一个方法，当搜索框中的值发生变化的时候，代理方法就会被调用）
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    _searchController.searchBar.placeholder = @"随便搜索";
    _searchController.searchBar.delegate = self;
    
    self.searchTableView.tableHeaderView = self.searchController.searchBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    NSLog(@"***********************************************");
//        NSLog(@"搜索控制器 = %@---自己的tableView = %@----自己的View = %@",self.searchTVC,self.searchTableView,self.view);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchController.searchBar resignFirstResponder];
    self.searchController.active = NO;
}

#pragma mark Lazy
- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
        for (NSInteger i =0; i<10; i++) {
            NSString *tempStr = [NSString stringWithFormat:@"第%ld行行行行",i];
            [_allDataArray addObject:tempStr];
        }
        [_allDataArray addObject:[EMClient sharedClient].currentUsername];
        [_allDataArray addObject:@"heeepjdf"];
    }
    return _allDataArray;
}


#pragma mark UITableViewDelegate, UITableViewDataSource


//3.监听输入的关键字, 把输入的关键字,传到接口处去请求数据
#pragma mark - UISearchResultsUpdating Method
#pragma mark 监听者搜索框中的值的变化
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 1. 获取输入的值
    self.inputText = searchController.searchBar.text;
    //发送请求

    [self getFriend];
}

//4. 请求数据并解析
#warning 由用户体系的用户，需要添加方法在已有的用户体系中查询符合填写内容的用户
#warning 以下代码为测试代码，默认用户体系中有一个符合要求的同名用户
- (void)getFriend
{
    //手动过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",self.inputText];
    self.searchResultDataArray =  [[NSArray alloc] initWithArray:[self.allDataArray filteredArrayUsingPredicate:predicate]];
    self.searchTVC.dataArray = [NSMutableArray arrayWithArray:_searchResultDataArray];
    [self.searchTVC.tableView reloadData];
    _searchResultDataArray = nil;
}



#pragma mark UITableViewDelegate,UITableViewDataSource
// 设置搜索tableView cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allDataArray.count;
}

// 设置搜索tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"indenfy";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.allDataArray[indexPath.row];

    return cell;
}


// 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//6. 设置搜索tableView 点击进入搜索结果
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 跳转操作
}

#pragma mark UISearchBarDelegate
//- (v)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    
//}
#pragma mark UISearchBarDelegate
//2. 触发方法,创建searchController
// searchBar的代理方法,当searchBar的textField开始编辑的时候调用,包含空
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    NSLog(@"================================================");
//    NSLog(@"搜索控制器 = %@---自己的tableView = %@----自己的View = %@",self.searchTVC,self.searchTableView,self.view);
//    NSLog(@"searchBar.text = %@",searchBar.text);
}


//(3) 取消按钮触发方法, 点击取消后,self.bar和self.view显示出来
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

@end
