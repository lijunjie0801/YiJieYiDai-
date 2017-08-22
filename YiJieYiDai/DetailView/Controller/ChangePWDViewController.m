//
//  ChangePWDViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/5.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ChangePWDViewController.h"

@interface ChangePWDViewController ()<BackBtnDelegate>
@property(nonatomic,strong)UITextField *phoneNumText;
@property(nonatomic,strong)UITextField *passwordText;
@property(nonatomic,strong)UITextField *vertifiText;
@end

@implementation ChangePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"修改密码";
    [self setForgetView];
    
}
-(void)setForgetView{
    UIImageView *phoneImage=[[UIImageView alloc]init];
    [self.view addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"pwd"];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneNumText=phoneText;
    phoneText.secureTextEntry=YES;
    //phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入原登录密码";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    UIImageView *yzmImage=[[UIImageView alloc]init];
    [self.view addSubview:yzmImage];
    yzmImage.image=[UIImage imageNamed:@"pwd"];
    [yzmImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    [yzmImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [yzmImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *yzmText = [[UITextField alloc]init];
    self.vertifiText=yzmText;
    yzmText.secureTextEntry=YES;
    yzmText.keyboardType = UIKeyboardTypeASCIICapable;
    yzmText.delegate=self;
    [self.view addSubview:yzmText];
    yzmText.backgroundColor = [UIColor whiteColor];
    yzmText.layer.cornerRadius = 6.0;
    yzmText.placeholder = @"请输入新登录密码";
    yzmText.leftViewMode = UITextFieldViewModeAlways;
    [yzmText autoSetDimension:ALDimensionHeight toSize:30];
    [yzmText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [yzmText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:145];
    [yzmText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];

    
    
    UIView *yzmline=[[UIView alloc]init];
    yzmline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [yzmText addSubview:yzmline];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-110];
    [yzmline autoSetDimension:ALDimensionHeight toSize:1];
    
    UIImageView *pwdImage=[[UIImageView alloc]init];
    [self.view addSubview:pwdImage];
    pwdImage.image=[UIImage imageNamed:@"pwd"];
    [pwdImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:yzmImage withOffset:30];
    [pwdImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [pwdImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *pwdText = [[UITextField alloc]init];
    self.passwordText=pwdText;
    pwdText.secureTextEntry=YES;
    pwdText.delegate=self;
    [self.view addSubview:pwdText];
    pwdText.backgroundColor = [UIColor whiteColor];
    pwdText.layer.cornerRadius = 6.0;
    pwdText.placeholder = @"请重复输入新密码";
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    [pwdText autoSetDimension:ALDimensionHeight toSize:30];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [pwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:yzmImage withOffset:30];
    
    UIView *Pwdline=[[UIView alloc]init];
    Pwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [pwdText addSubview:Pwdline];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [Pwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    /*登录按钮*/
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdImage withOffset:50];
    
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
}
-(void)resetClick{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        [JRToast showWithText:@"请输入原密码" duration:1.0];
        return;
    }else if ([self.vertifiText.text isEqualToString:@""]){
        [JRToast showWithText:@"请输入密码" duration:1.0];
        return;
    }else if ([self.passwordText.text isEqualToString:@""]){
        [JRToast showWithText:@"请输入密码" duration:1.0];
        return;
    }
    if (self.passwordText.text.length<6) {
        [JRToast showWithText:@"请输入6-20位字符密码" duration:1.0];
        return;
    }
    if (![self.vertifiText.text isEqualToString:self.passwordText.text]) {
        [JRToast showWithText:@"两次密码不同" duration:1.0];
        return;
    }
    [kNetManager changePassword:[DEFAULTS objectForKey:@"userId"] oldPass:self.phoneNumText.text newPass:self.passwordText.text Success:^(id responseObject) {
        NSLog(@"修改密码%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [JRToast showWithText:@"修改密码成功" duration:1.0];
            [self.navigationController popViewControllerAnimated:NO];
        }
    } Failure:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (textField == self.phoneNumText) {
        if (string.length == 0)
            return YES;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
        
    }else{
        if (existedLength - selectedLength + replaceLength > 20) {
            return NO;
        }
        
    }
    return YES;
}

@end
