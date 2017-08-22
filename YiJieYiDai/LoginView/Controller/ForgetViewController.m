//
//  ForgetViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()<BackBtnDelegate>
@property(nonatomic,strong)UITextField *phoneNumText;
@property(nonatomic,strong)UITextField *passwordText;
@property(nonatomic,strong)UITextField *vertifiText;
@property(nonatomic,strong)NSString *sendCond;
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"找回密码";
    [self setForgetView];
    
}
-(void)setForgetView{
    UIImageView *phoneImage=[[UIImageView alloc]init];
    [self.view addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"phone"];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneNumText=phoneText;
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入手机号";
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
    yzmImage.image=[UIImage imageNamed:@"yanzhengma"];
    [yzmImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    [yzmImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [yzmImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *yzmText = [[UITextField alloc]init];
    self.vertifiText=yzmText;
    yzmText.keyboardType = UIKeyboardTypeASCIICapable;
    yzmText.delegate=self;
    [self.view addSubview:yzmText];
    yzmText.backgroundColor = [UIColor whiteColor];
    yzmText.layer.cornerRadius = 6.0;
    yzmText.placeholder = @"请输入验证码";
    yzmText.leftViewMode = UITextFieldViewModeAlways;
    [yzmText autoSetDimension:ALDimensionHeight toSize:30];
    [yzmText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [yzmText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:145];
    [yzmText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    
    //获取验证码
    UIButton *VerifiBtn = [[UIButton alloc]init];
    [VerifiBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [VerifiBtn setTitle:@"立即获取" forState:UIControlStateNormal];
    [VerifiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    VerifiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:VerifiBtn];
    VerifiBtn.layer.cornerRadius = 6.0;
    [VerifiBtn addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    [VerifiBtn autoSetDimension:ALDimensionHeight toSize:40];
    [VerifiBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [VerifiBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:yzmText withOffset:0];
    [VerifiBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:20];

    
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
    pwdText.placeholder = @"请输入新密码";
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
        [JRToast showWithText:@"请输入手机号" duration:1.0];
        return;
    }else if (![Check checkMobileNumber:self.phoneNumText.text]){
        [JRToast showWithText:@"请输入正确手机号" duration:1.0];
        return;
    }else if ([self.vertifiText.text isEqualToString:@""]){
        [JRToast showWithText:@"请输入验证码" duration:1.0];
        return;
    }else if ([self.passwordText.text isEqualToString:@""]){
        [JRToast showWithText:@"请输入密码" duration:1.0];
        return;
    }
    if (self.passwordText.text.length<6) {
        [JRToast showWithText:@"请输入6-20位字符密码" duration:1.0];
        return;
    }
//    [kNetManager forgetPassword:self.phoneNumText.text code:self.vertifiText.text password:self.passwordText.text basecode:self.sendCond Success:^(id responseObject) {
//        NSLog(@"忘记密码%@",responseObject);
//        if ([responseObject[@"result"] integerValue]==100) {
//            [JRToast showWithText:@"找回密码成功" duration:1.0];
//            [self.navigationController popViewControllerAnimated:NO];
//        }
//    } Failure:^(NSError *error) {
//        
//    }];
    [kNetManager forgetPassword:self.phoneNumText.text code:self.vertifiText.text userPwd:self.passwordText.text sendCode:self.sendCond Success:^(id responseObject) {
         NSLog(@"忘记密码%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [JRToast showWithText:@"找回密码成功" duration:1.0];
            [self.navigationController popViewControllerAnimated:NO];
        }

    } Failure:^(NSError *error) {
        
    }];

}
-(void)sendClick:(UIButton *)sender{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        [JRToast showWithText:@"请输入手机号" duration:1.0];
        return;
    }else if (![Check checkMobileNumber:self.phoneNumText.text]){
        [JRToast showWithText:@"请输入正确手机号" duration:1.0];
        return;
    }//
    [kNetManager getVerficode:self.phoneNumText.text type:@"2" Success:^(id responseObject) {
            NSLog(@"获取验证码成功,%@",responseObject);
        self.sendCond=responseObject[@"datas"][@"sendCode"][@"sendCode"];
        [JRToast showWithText:@"获取验证码成功" duration:1.0];
    } Failure:^(NSError *error) {
        
    }];
   
    sender.userInteractionEnabled=NO;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            //int seconds = timeout % 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
                //  sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
@end
