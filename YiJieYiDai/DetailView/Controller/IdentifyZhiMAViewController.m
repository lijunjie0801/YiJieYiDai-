//
//  IdentifyZhiMAViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/5.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "IdentifyZhiMAViewController.h"
#import "IdentifySuccessViewController.h"
@interface IdentifyZhiMAViewController ()<BackBtnDelegate,WebViewDelegate>
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UITextField *nameText;
@property(nonatomic,strong)UITextField *cardText;
@end

@implementation IdentifyZhiMAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"芝麻信用";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];

    [self setBottomView];
}
-(void)setBottomView{
    UIImageView *phoneImage=[[UIImageView alloc]init];
    [self.view addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"people"];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.nameText=phoneText;
//    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入真实姓名";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    UIImageView *yzmImage=[[UIImageView alloc]init];
    [self.view addSubview:yzmImage];
    yzmImage.image=[UIImage imageNamed:@"sf"];
    [yzmImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    [yzmImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [yzmImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *yzmText = [[UITextField alloc]init];
    self.cardText=yzmText;
    yzmText.keyboardType = UIKeyboardTypeASCIICapable;
    yzmText.delegate=self;
    [self.view addSubview:yzmText];
    yzmText.backgroundColor = [UIColor whiteColor];
    yzmText.layer.cornerRadius = 6.0;
    yzmText.placeholder = @"请输入身份证号";
    yzmText.leftViewMode = UITextFieldViewModeAlways;
    [yzmText autoSetDimension:ALDimensionHeight toSize:30];
    [yzmText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [yzmText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [yzmText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    
    
       UIView *yzmline=[[UIView alloc]init];
    yzmline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [yzmText addSubview:yzmline];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-110];
    [yzmline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    /*登录按钮*/
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:yzmline withOffset:50];
    
    UIButton *selectBtn=[[UIButton alloc]init];
    [selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    selectBtn.selected=YES;
    [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    [selectBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:20];
    self.selectBtn=selectBtn;
    [selectBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [selectBtn autoSetDimensionsToSize:CGSizeMake(20, 20)];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"我同意《芝麻分信用信息授权协议》"];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"0x4481fe"]
                       range:NSMakeRange(3, 13)];
    UILabel *bottomLab=[[UILabel alloc]init];
    bottomLab.font=[UIFont systemFontOfSize:14];
    bottomLab.attributedText=attrString;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agree:)];
    singleTap.numberOfTapsRequired=1;
    [bottomLab addGestureRecognizer:singleTap];
    bottomLab.userInteractionEnabled=YES;
    [self.view addSubview:bottomLab];
    [bottomLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:20];
    [bottomLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [bottomLab autoSetDimensionsToSize:CGSizeMake(250, 20)];
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
-(void)selectClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        [sender setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
}
-(void)agree:(id)sender{
    DTCustomeWebViewController *DV=[[DTCustomeWebViewController alloc]init];
    DV.webUrl=[NSString stringWithFormat:@"%@/api.php/index/zhimaProtocal",kUrl];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:DV];
    [self presentViewController:nav_third animated:NO completion:nil];
}

-(void)submitClick{
    if (self.selectBtn.selected==NO) {
        showAlert(@"请同意");
        return;
    }
    if (self.nameText.text.length==0||self.cardText.text.length==0) {
        showAlert(@"姓名和身份证号不能为空");
        return;
    }
    [kNetManager toZhiMaIdentify:[DEFAULTS objectForKey:@"userId"] truename:self.nameText.text idcard:self.cardText.text Success:^(id responseObject) {
        NSLog(@"芝麻认证结果:%@",responseObject);
        if ([responseObject[@"status"] intValue]==100) {
            NSString *url=responseObject[@"datas"][@"zhimaRealCheck"][@"url"];
            DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
            webVC.delegate=self;
            webVC.webUrl=url;
            UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
            [self presentViewController:nav_third animated:NO completion:nil];

//            [JRToast showWithText:@"提交成功" duration:2.0];
//            IdentifySuccessViewController *IV=[[IdentifySuccessViewController alloc]init];
//            IV.type=@"1";
//            [self.navigationController pushViewController:IV animated:NO];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2.0];
        }

    } Failure:^(NSError *error) {
        
    }];
}
-(void)twoback{
     [self.navigationController popViewControllerAnimated:NO];
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSInteger existedLength = textField.text.length;
//    NSInteger selectedLength = range.length;
//    NSInteger replaceLength = string.length;
//    
//    if (textField == self.) {
//        if (string.length == 0)
//            return YES;
//        if (existedLength - selectedLength + replaceLength > 11) {
//            return NO;
//        }
//        
//    }else{
//        if (existedLength - selectedLength + replaceLength > 15) {
//            return NO;
//        }
//        
//    }
//    return YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
