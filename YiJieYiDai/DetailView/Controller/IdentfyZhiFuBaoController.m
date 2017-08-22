//
//  IdentfyZhiFuBaoController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/29.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "IdentfyZhiFuBaoController.h"

@interface IdentfyZhiFuBaoController ()<BackBtnDelegate>
@property(nonatomic,strong)UITextField *phoneNumText;
@property(nonatomic,strong)UITextField *passwordText;

@end

@implementation IdentfyZhiFuBaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rdv_tabBarController setTabBarHidden:YES];

    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"登录";
    
    [self setUI];

}
-(void)setUI{
    UIImageView *topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width*0.35, 40, kScreen_Width*0.3,kScreen_Width*0.3 )];
    topImageView.image=[UIImage imageNamed:@"zfb"];
    [self.view addSubview:topImageView];
    
    UIImageView *phoneImage=[[UIImageView alloc]init];
    [self.view addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"gr"];
    [phoneImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topImageView withOffset:50];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(20, 25)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneNumText=phoneText;
     phoneText.keyboardType = UIKeyboardTypeASCIICapable;
//    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入支付宝账号";
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
    pwdImage.image=[UIImage imageNamed:@"mm"];
    [pwdImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    [pwdImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [pwdImage autoSetDimensionsToSize:CGSizeMake(20, 25)];
    
    
    UITextField *pwdText = [[UITextField alloc]init];
    pwdText.keyboardType = UIKeyboardTypeASCIICapable;
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
    [loginBtn setTitle:@"授权" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(shouquanClick) forControlEvents:UIControlEventTouchUpInside];
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
-(void)shouquanClick{
    [kNetManager submitZhifubaoIdentify:[DEFAULTS objectForKey:@"userId"] aliPayName:self.phoneNumText.text aliPayPwd:self.passwordText.text Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] intValue]==100) {
            [JRToast showWithText:@"授权成功" duration:1.0];
            [self.navigationController popViewControllerAnimated:NO];
        }
    } Failure:^(NSError *error) {
        
    }];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
