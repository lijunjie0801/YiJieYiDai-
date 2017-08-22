//
//  LoginViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/3.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "LoginViewController.h"
#import "RigstViewController.h"
#import "ForgetViewController.h"
@interface LoginViewController ()<BackBtnDelegate>
@property(nonatomic,strong)UITextField *phoneNumText;
@property(nonatomic,strong)UITextField *passwordText;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"登录";

    [self setUI];
}
-(void)setUI{
    UIImageView *topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width*0.3, 40, kScreen_Width*0.4,kScreen_Width*0.4 )];
    topImageView.image=[UIImage imageNamed:@"appLogo"];
    [self.view addSubview:topImageView];
    
    UIImageView *phoneImage=[[UIImageView alloc]init];
    [self.view addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"phone"];
    [phoneImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topImageView withOffset:50];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneNumText=phoneText;
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入手机号码";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topImageView withOffset:50];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    
    
    UIImageView *pwdImage=[[UIImageView alloc]init];
    [self.view addSubview:pwdImage];
    pwdImage.image=[UIImage imageNamed:@"pwd"];
    [pwdImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    [pwdImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [pwdImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *pwdText = [[UITextField alloc]init];
    self.passwordText=pwdText;
     pwdText.secureTextEntry = YES;
    pwdText.delegate=self;
    [self.view addSubview:pwdText];
    pwdText.backgroundColor = [UIColor whiteColor];
    pwdText.layer.cornerRadius = 6.0;
    pwdText.placeholder = @"请输入密码";
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    [pwdText autoSetDimension:ALDimensionHeight toSize:30];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [pwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    
    UIView *Pwdline=[[UIView alloc]init];
    Pwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [pwdText addSubview:Pwdline];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [Pwdline autoSetDimension:ALDimensionHeight toSize:1];
    

    
    /*登录按钮*/
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:pwdImage withOffset:50];
    
    /*注册*/
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    [registerBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [registerBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:20];
    /*找回密码*/
    UIButton *backPasswordBtn = [[UIButton alloc]init];
    [backPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [backPasswordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    backPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    backPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:backPasswordBtn];
    [backPasswordBtn addTarget:self action:@selector(backPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [backPasswordBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    [backPasswordBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [backPasswordBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:20];
    

    
    
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    

}
-(void)loginClick{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        [JRToast showWithText:@"请输入手机号" duration:1.0];
        return;
    }else if (![Check checkMobileNumber:self.phoneNumText.text]){
        [JRToast showWithText:@"请输入正确手机号" duration:1.0];
        return;
    }else if ([self.passwordText.text isEqualToString:@""]){
        [JRToast showWithText:@"请输入密码" duration:1.0];
        return;
    }
      if (self.passwordText.text.length<6) {
       [JRToast showWithText:@"请输入6-20位字符密码" duration:1.0];
        return;
    }
    NSString *reId=[DEFAULTS objectForKey:@"registrationID"];
    [kNetManager getLogin:self.phoneNumText.text password:[self md5:self.passwordText.text] deviceId:reId Success:^(id responseObject) {
        NSLog(@"登录成功%@",responseObject);
        if([responseObject[@"status"] integerValue]==100){
            [DEFAULTS setObject:responseObject[@"datas"][@"nameLogin"][@"appKey"] forKey:@"userId"];
            CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
            [self presentViewController:rootVC animated:NO completion:nil];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }

    } Failure:^(NSError *error) {
        
    }];

}
-(void)backPasswordClick{
    ForgetViewController *FV=[[ForgetViewController alloc]init];
    [self.navigationController pushViewController:FV animated:NO];
}
-(void)registerClick{
    RigstViewController *RV=[[RigstViewController alloc]init];
   [self.navigationController pushViewController:RV animated:NO];

}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goback{
    [self dismissViewControllerAnimated:NO completion:nil];
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
- (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
