//
//  IdentfyPhoneViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/5.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "IdentfyPhoneViewController.h"
#import "MQVerCodeImageView.h"
#import "IdentifySuccessViewController.h"
@interface IdentfyPhoneViewController ()<BackBtnDelegate,UITextFieldDelegate>{
    __block NSString *_imageCodeStr;
}
@property (nonatomic, strong) MQVerCodeImageView *codeImageView;
@property (nonatomic, strong)UILabel *phoneINLab;
@property (nonatomic, strong)UILabel *YYSINLab;
@property (nonatomic, strong)UITextField *codeText;
@property (nonatomic, strong)UITextField *phoneText;
@property(nonatomic,strong)UITextField *nameText;
@property(nonatomic,strong)UITextField *cardText;

@end

@implementation IdentfyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];

    [self.rdv_tabBarController setTabBarHidden:YES];
    self.title=@"手机认证";
    
    [self setUI];
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated{
    [self getData];
}
-(void)getData{
    [kNetManager toPhoneIdentify:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"手机认证:%@",responseObject);
        if ([responseObject[@"status"] intValue]==100) {
            self.YYSINLab.text=responseObject[@"datas"][@"phoneReal"][@"phoneOperator"];
            self.phoneINLab.text=responseObject[@"datas"][@"phoneReal"][@"userPhone"];
        }
    } Failure:^(NSError *error) {
        
    }];
}
-(void)setUI{
    
     CGSize size = [@"您的手机号:" boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    UILabel *phoneTLab=[[UILabel alloc]initWithFrame:CGRectMake(30, 20, size.width, 20)];
    
    phoneTLab.textColor=[UIColor grayColor];
    phoneTLab.text=@"您的手机号:";
    phoneTLab.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:phoneTLab];
    
    UILabel *phoneINLab=[[UILabel alloc]initWithFrame:CGRectMake(50+size.width, 20,150, 20)];
    self.phoneINLab=phoneINLab;
    phoneINLab.textColor=[UIColor colorWithHexString:@"0x4481fe"];
    phoneINLab.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:phoneINLab];


    UILabel *YYSTLab=[[UILabel alloc]initWithFrame:CGRectMake(30, 60, size.width, 20)];
    YYSTLab.textColor=[UIColor grayColor];
    YYSTLab.text=@"所属运营商:";
    YYSTLab.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:YYSTLab];
    
    UILabel *YYSINLab=[[UILabel alloc]initWithFrame:CGRectMake(50+size.width, 60,150, 20)];
    self.YYSINLab=YYSINLab;
    YYSINLab.textColor=[UIColor colorWithHexString:@"0x4481fe"];
    YYSINLab.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:YYSINLab];
    
    UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreen_Width, 20)];
    sepView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [self.view addSubview:sepView];
    
    [self setBottomView];
    
}
-(void)setBottomView{
    
    UIImageView *nameImage=[[UIImageView alloc]init];
    [self.view addSubview:nameImage];
    nameImage.image=[UIImage imageNamed:@"people"];
    [nameImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150];
    [nameImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [nameImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *nameText = [[UITextField alloc]init];
    self.nameText=nameText;
    //    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    nameText.delegate=self;
    [self.view addSubview:nameText];
    nameText.backgroundColor = [UIColor whiteColor];
    nameText.layer.cornerRadius = 6.0;
    nameText.placeholder = @"请输入真实姓名";
    nameText.leftViewMode = UITextFieldViewModeAlways;
    [nameText autoSetDimension:ALDimensionHeight toSize:30];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150];
    
    UIView *nameline=[[UIView alloc]init];
    nameline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [nameText addSubview:nameline];
    [nameline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [nameline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [nameline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [nameline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    UIImageView *cardImage=[[UIImageView alloc]init];
    [self.view addSubview:cardImage];
    cardImage.image=[UIImage imageNamed:@"sf"];
    [cardImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameImage withOffset:30];
    [cardImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [cardImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *cardText = [[UITextField alloc]init];
    self.cardText=cardText;
    cardText.keyboardType = UIKeyboardTypeASCIICapable;
    cardText.delegate=self;
    [self.view addSubview:cardText];
    cardText.backgroundColor = [UIColor whiteColor];
    cardText.layer.cornerRadius = 6.0;
    cardText.placeholder = @"请输入身份证号";
    cardText.leftViewMode = UITextFieldViewModeAlways;
    [cardText autoSetDimension:ALDimensionHeight toSize:30];
    [cardText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [cardText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [cardText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameImage withOffset:30];
    
    
    UIView *cardline=[[UIView alloc]init];
    cardline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [cardText addSubview:cardline];
    [cardline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [cardline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [cardline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-110];
    [cardline autoSetDimension:ALDimensionHeight toSize:1];
    

    UIImageView *phoneImage=[[UIImageView alloc]init];
    [self.view addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"phone"];
    [phoneImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cardImage withOffset:30];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneText=phoneText;
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入手机运营商服务密码";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cardImage withOffset:30];
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
    self.codeText=yzmText;
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
 
    
    _codeImageView = [[MQVerCodeImageView alloc] initWithFrame:CGRectMake(100, 220, 80, 35)];
    [self.view addSubview: _codeImageView];
    _codeImageView.bolck = ^(NSString *imageCodeStr){
      
      //  self.imageCodeStr=imageCodeStr;
        _imageCodeStr=imageCodeStr;
        
    };
    [_codeImageView autoSetDimension:ALDimensionHeight toSize:40];
    [_codeImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [_codeImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:yzmText withOffset:30];
    [_codeImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:20];
    _codeImageView.isRotation = NO;
    [_codeImageView freshVerCode];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_codeImageView addGestureRecognizer:tap];
    
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
    [loginBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:yzmline withOffset:50];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:14];
    NSString *str = @"备注:移动手机认证获取需要1~5分钟,因为移动客户端原因，需二次认证，请耐心等待";
    textLabel.text = str;
    textLabel.textColor = [UIColor colorWithHexString:@"0xfe8644"];
    [UILabel changeLineSpaceForLabel:textLabel WithSpace:5.0];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreen_Width-60, 9999);
        [self.view addSubview:textLabel];
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [textLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:10];
    [textLabel autoSetDimension:ALDimensionHeight toSize:expectSize.height];
    
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
-(void)submit{
    NSLog(@"imageCodeStr = %@",_imageCodeStr);
    BOOL result = [self.codeText.text compare:_imageCodeStr
                            options:NSCaseInsensitiveSearch |NSNumericSearch] ==NSOrderedSame;
    if (result==NO) {
        showAlert(@"请输入正确验证码");
        return;
    }
    if (self.phoneText.text.length==0) {
        showAlert(@"请输入服务密码");
        return;

    }
    if (self.nameText.text.length==0) {
        showAlert(@"请输入姓名");
        return;
        
    }
    if (self.cardText.text.length==0) {
        showAlert(@"请输入身份证号");
        return;
        
    }
    [kNetManager submitPhoneIdentify:[DEFAULTS objectForKey:@"userId"] userName:self.nameText.text userCard:self.cardText.text operatorPwd:self.phoneText.text Success:^(id responseObject) {
        NSLog(@"提交手机认证%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            IdentifySuccessViewController *IV=[[IdentifySuccessViewController alloc]init];
            IV.type=@"1";
            [self.navigationController pushViewController:IV animated:NO];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:2.0];
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
- (void)tapClick:(UITapGestureRecognizer*)tap
{
    [_codeImageView freshVerCode];
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
