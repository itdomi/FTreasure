//
//  AddressViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAddressViewController.h"
#import "CreateAddressViewController.h"
#import "AddressCell.h"

@interface AddressViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) BaseTableView *tableView;

@end

@implementation AddressViewController

- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        }) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 66;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = UIColorHex(0xeeeeee);
    }
    return _tableView;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地址列表";
    [self setRightItemTitle:@"添加地址" action:@selector(addAddress)];
    [self.view addSubview:self.tableView];
    [self getAddressData];
}

- (void)getAddressData {
    for (int i=0; i<1; i++) {
        AddressModel *model = [[AddressModel alloc]init];
        [self.datasource addObject:model];
    }
    if (_datasource.count==0) {
        [self setupAddbutton];
        return;
    }
    [_tableView reloadData];
}

- (void)setupAddbutton {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = ({
        CGRect rect = {10,10,kScreenWidth-10*2,40};
        rect;
    });
    addButton.layer.cornerRadius = 4.0;
    addButton.titleLabel.font = SYSTEM_FONT(15);
    addButton.backgroundColor = kDefaultColor;
    [addButton setTitle:@"添加地址" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:addButton];
}

- (void)addAddress {
    CreateAddressViewController *vc = [[CreateAddressViewController alloc]init];
    vc.isSigned = NO;
    [self hideBottomBarPush:vc];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [AddressCell cellWithTableView:tableView];
    cell.model = _datasource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CreateAddressViewController *vc = [[CreateAddressViewController alloc]init];
    vc.model = _datasource[indexPath.row];
    vc.isSigned = NO;
    [self hideBottomBarPush:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
