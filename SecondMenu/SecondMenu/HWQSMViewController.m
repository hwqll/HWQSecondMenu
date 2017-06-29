//
//  HWQSMViewController.m
//  SecondMenu
//
//  Created by 黄伟强 on 2016/6/28.
//  Copyright © 2016年 hwq. All rights reserved.
//

#import "HWQSMViewController.h"
#import "DetailViewController.h"

@interface HWQSMViewController ()
{
    BOOL status[6];//记录一级菜单状态 默认no闭合
    NSMutableArray *firstName;//一级菜单名
    NSMutableArray *secondName;//二级菜单
   
}

@end

@implementation HWQSMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //这里菜单可以根据自己需要设定或从后台载入数据
    firstName = [[NSMutableArray alloc]initWithObjects:@"菜单1",@"菜单2",@"菜单3",@"菜单4",@"菜单5",@"菜单6", nil];
    secondName = [[NSMutableArray alloc]initWithObjects:@"测试1",@"测试2",@"测试3",nil];
    
    self.navigationItem.title  =@"二级菜单展示";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //节数即为一级菜单个数
    return firstName.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //现实项目中可以根据每节设定单元数
    BOOL closeOrOpen = status[section] ;
    //关闭显示为0行
    if (closeOrOpen == NO) {
        return 0;
    }else {
        return secondName.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = secondName[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    DetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:detail animated:true];
}
//自定义节
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIControl *sectionView = [[UIControl alloc] initWithFrame:CGRectZero];
    sectionView.tag = section;
    sectionView.backgroundColor = [UIColor whiteColor];
    [sectionView addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 30)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:15];
    title.text = [NSString stringWithFormat:@"%@", firstName[section]];
    [title sizeToFit];
    [sectionView addSubview:title];
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.9 , 15, 10, 10)];
    // firstImageView.backgroundColor = [UIColor redColor];
    if (!status[section]) {
        ImageView.image = [UIImage imageNamed:@"btn_right.png"];
    }else {
        ImageView.image = [UIImage imageNamed:@"show_attachments.png"];
    }
    
    [sectionView addSubview:ImageView];
    
    return sectionView;

}
//
- (void)sectionAction:(UIControl *)control {
   
    NSInteger section = control.tag;
    if (!status[section]){
        status[section] = true;
        
    }else {
        status[section] = false;
    }
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    //刷新指定单元格
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];


}
//section的header view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}


@end
