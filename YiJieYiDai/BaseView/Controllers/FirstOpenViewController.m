//
//  FirstOpenViewController.m
//  BaseProject
//
//  Created by lijunjie on 2017/5/21.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FirstOpenViewController.h"
#import "CYRootTabViewController.h"
@interface FirstOpenViewController ()

@end

@implementation FirstOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //得到图片的路径
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"yindaotu"];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    UIButton *btn=[[UIButton alloc]initWithFrame:self.view.bounds];
    [btn addTarget:self action:@selector(toAppHome) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
}
-(void)toAppHome{
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
