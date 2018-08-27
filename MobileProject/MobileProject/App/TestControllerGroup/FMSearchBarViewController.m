//
//  FMSearchBarViewController.m
//  MobileProject
//
//  Created by Mingoy on 16/10/11.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMSearchBarViewController.h"

@interface FMSearchBarViewController ()<FMSearchBarDelegate>
@property(strong,nonatomic)FMSearchBar *myFMSearchBar;
@end

@implementation FMSearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_myFMSearchBar) {
        self.myFMSearchBar = [[FMSearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
        self.myFMSearchBar.delegate=self;
        self.myFMSearchBar.placeholder = @"请输入当前城市";
        self.myFMSearchBar.placeholderColor = [UIColor purpleColor];
        
        self.myFMSearchBar.backgroundColor = [UIColor yellowColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        view.backgroundColor = [UIColor redColor];
        self.myFMSearchBar.keyboardType=UIKeyboardTypeDefault;
        //self.myFMSearchBar.inputAccessoryView =view;
        [self.myFMSearchBar.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.view addSubview:self.myFMSearchBar];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark FMSearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(FMSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
}
- (void)searchBarTextDidBeginEditing:(FMSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (BOOL)searchBarShouldEndEditing:(FMSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
}
- (void)searchBarTextDidEndEditing:(FMSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBar:(FMSearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (BOOL)searchBar:(FMSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
    
}
- (void)searchBarSearchButtonClicked:(FMSearchBar *)searchBar{
    NSLog(@"输出的内容：%@",searchBar.text);
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBarCancelButtonClicked:(FMSearchBar *)searchBar{
    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}

@end
