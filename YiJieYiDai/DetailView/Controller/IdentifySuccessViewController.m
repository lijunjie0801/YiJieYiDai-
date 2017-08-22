//
//  IdentifySuccessViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "IdentifySuccessViewController.h"

@interface IdentifySuccessViewController ()<BackBtnDelegate>

@end

@implementation IdentifySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    [self.rdv_tabBarController setTabBarHidden:YES];
    [self setUI];
}
-(void)goback{
    [self closeClick];
}
-(void)setUI{
    UIImageView *successView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width/3, 100, kScreen_Width/3, kScreen_Width/3*1.35)];
    successView.image=[UIImage imageNamed:@"success"];
    [self.view addSubview:successView];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:16];
    NSString *str;
    if ([self.type integerValue]==0) {
        str = @"恭喜您，你的信息认证数据已提交成功！e捷金服的客服会尽快验证信息，届时会致电通知您，谢谢您对我们工作的支持！";
    }else{
        str = @"恭喜您，你的身份认证信息已提交成功！e捷金服的客服会尽快审核信息，请你耐心等待，并及时关注！";
    }
    textLabel.text = str;
    textLabel.textColor = [UIColor grayColor];
    [UILabel changeLineSpaceForLabel:textLabel WithSpace:5.0];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreen_Width-60, 9999);
    [self.view addSubview:textLabel];
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [textLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:successView withOffset:80];
    [textLabel autoSetDimension:ALDimensionHeight toSize:expectSize.height];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.layer.cornerRadius = 6.0;
    [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [self.view addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn autoSetDimension:ALDimensionHeight toSize:40];
    [closeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [closeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [closeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textLabel withOffset:50];

}
-(void)closeClick{
    if ([self.type integerValue]==2) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate backMe];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }
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
