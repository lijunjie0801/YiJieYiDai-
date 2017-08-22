//
//  IdentifySheJiaoViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/5.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "IdentifySheJiaoViewController.h"
#import <AddressBook/AddressBook.h>
#define SYSTEMVERSION   [UIDevice currentDevice].systemVersion
#define iOS9OrLater ([SYSTEMVERSION floatValue] >= 9.0)
#import "IdentifySuccessViewController.h"
#import "RXAddressiOS10.h"
#import "RXAddressiOS9.h"
@interface IdentifySheJiaoViewController ()<UITableViewDelegate,UITableViewDataSource,BackBtnDelegate,UITextFieldDelegate>{
    RXAddressiOS9 * _objct9;
    RXAddressiOS10 * _objct10;
}
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic, assign)BOOL isFirstRelation;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *relationText1;
@property(nonatomic,strong)UITextField *relationText2;
@property(nonatomic,strong)UIButton *bigBackBtn;
@property(nonatomic,strong)UITextField *phoneText1;
@property(nonatomic,strong)UITextField *phoneText2;
@property(nonatomic,strong)UITextField *nameText1;
@property(nonatomic,strong)UITextField *nameText2;
@property(nonatomic,strong)UITextField *QQText;
@property(nonatomic,strong)UITextField *WXText;
@property(nonatomic,strong)NSMutableArray *linkmanInfoArray;
@end

@implementation IdentifySheJiaoViewController
-(NSMutableArray *)linkmanInfoArray{
    if (!_linkmanInfoArray) {
        _linkmanInfoArray=[NSMutableArray array];
    }
    return _linkmanInfoArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rdv_tabBarController setTabBarHidden:YES];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"社交认证";
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    self.view =_tableView;

    __weak typeof(self)weakSelf = self;
    
    _objct10 = [[RXAddressiOS10 alloc] init];
    _objct10.complete = ^(BOOL status, NSString * phoneNum, NSString * nameString) {
        if(status) {
            if (self.isFirstRelation==YES) {
                 weakSelf.phoneText1.text = phoneNum;
            }else{
                weakSelf.phoneText2.text = phoneNum;
            }
           
        }
        if (self.isFirstRelation==YES) {
           weakSelf.nameText1.text = nameString;
        }else{
           weakSelf.nameText2.text = nameString;
        }
    };
    _objct9 = [[RXAddressiOS9 alloc] init];
    _objct9.complete = ^(BOOL status, NSString * phoneNum, NSString * nameString) {
        if(status) {
            if (self.isFirstRelation==YES) {
                weakSelf.phoneText1.text = phoneNum;
            }else{
                weakSelf.phoneText2.text = phoneNum;
            }

        }
        if (self.isFirstRelation==YES) {
            weakSelf.nameText1.text = nameString;
        }else{
            weakSelf.nameText2.text = phoneNum;
        }

    };


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView addSubview:[self middleview]];
    [cell.contentView addSubview:[self bottemView]];
    [cell.contentView addSubview:[self lastView]];
    return cell;
}
-(UIView *)middleview{
    UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    middleView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *personImage=[[UIImageView alloc]init];
    [middleView addSubview:personImage];
    personImage.image=[UIImage imageNamed:@"people"];
    [personImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [personImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [personImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *nameText = [[UITextField alloc]init];
    self.nameText1=nameText;
    nameText.delegate=self;
    [middleView addSubview:nameText];
    nameText.backgroundColor = [UIColor whiteColor];
    nameText.layer.cornerRadius = 6.0;
    nameText.placeholder = @"请输入真实姓名";
    nameText.leftViewMode = UITextFieldViewModeAlways;
    [nameText autoSetDimension:ALDimensionHeight toSize:30];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [nameText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    UIImageView *phoneImage=[[UIImageView alloc]init];
    [middleView addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"iphone"];
    [phoneImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:personImage withOffset:30];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneText1=phoneText;
    phoneText.keyboardType = UIKeyboardTypeASCIICapable;
    phoneText.delegate=self;
    [middleView addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入手机号码";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:145];
    [phoneText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:personImage withOffset:30];
    
    
    
    UIView *yzmline=[[UIView alloc]init];
    yzmline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:yzmline];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-110];
    [yzmline autoSetDimension:ALDimensionHeight toSize:1];
    
    UIImageView *relationImage=[[UIImageView alloc]init];
    [middleView addSubview:relationImage];
    relationImage.image=[UIImage imageNamed:@"peoples"];
    [relationImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    [relationImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [relationImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *relationText = [[UITextField alloc]init];
    self.relationText1=relationText;
    relationText.delegate=self;
    [middleView addSubview:relationText];
    relationText.backgroundColor = [UIColor whiteColor];
    relationText.layer.cornerRadius = 6.0;
    relationText.placeholder = @"请输入与本人的关系";
    relationText.leftViewMode = UITextFieldViewModeAlways;
    [relationText autoSetDimension:ALDimensionHeight toSize:30];
    [relationText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [relationText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [relationText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    
    UIView *Pwdline=[[UIView alloc]init];
    Pwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [relationText addSubview:Pwdline];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [Pwdline autoSetDimension:ALDimensionHeight toSize:1];   return  middleView;
    
}
-(UIView *)bottemView{
    UIView *bottemView=[[UIView alloc]initWithFrame:CGRectMake(0, 220, kScreen_Width, 200)];
    bottemView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *personImage=[[UIImageView alloc]init];
    [bottemView addSubview:personImage];
    personImage.image=[UIImage imageNamed:@"people"];
    [personImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [personImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [personImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *nameText = [[UITextField alloc]init];
    self.nameText2=nameText;
    //    nameText.keyboardType = UIKeyboardTypeNumberPad;
    nameText.delegate=self;
    [bottemView addSubview:nameText];
    nameText.backgroundColor = [UIColor whiteColor];
    nameText.layer.cornerRadius = 6.0;
    nameText.placeholder = @"请输入真实姓名";
    nameText.leftViewMode = UITextFieldViewModeAlways;
    [nameText autoSetDimension:ALDimensionHeight toSize:30];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [nameText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    UIImageView *phoneImage=[[UIImageView alloc]init];
    [bottemView addSubview:phoneImage];
    phoneImage.image=[UIImage imageNamed:@"iphone"];
    [phoneImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:personImage withOffset:30];
    [phoneImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneText2=phoneText;
    phoneText.keyboardType = UIKeyboardTypeASCIICapable;
    phoneText.delegate=self;
    [bottemView addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入手机号码";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:145];
    [phoneText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:personImage withOffset:30];
    
    
    
    UIView *yzmline=[[UIView alloc]init];
    yzmline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:yzmline];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-110];
    [yzmline autoSetDimension:ALDimensionHeight toSize:1];
    
    UIImageView *relationImage=[[UIImageView alloc]init];
    [bottemView addSubview:relationImage];
    relationImage.image=[UIImage imageNamed:@"peoples"];
    [relationImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    [relationImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [relationImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *relationText = [[UITextField alloc]init];
        self.relationText2=relationText;
//    relationText.secureTextEntry=YES;
    relationText.delegate=self;
    [bottemView addSubview:relationText];
    relationText.backgroundColor = [UIColor whiteColor];
    relationText.layer.cornerRadius = 6.0;
    relationText.placeholder = @"请输入与本人的关系";
    relationText.leftViewMode = UITextFieldViewModeAlways;
    [relationText autoSetDimension:ALDimensionHeight toSize:30];
    [relationText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [relationText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [relationText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneImage withOffset:30];
    
    UIView *Pwdline=[[UIView alloc]init];
    Pwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [relationText addSubview:Pwdline];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [Pwdline autoSetDimension:ALDimensionHeight toSize:1];
    return  bottemView;
}
-(UIView *)lastView{
    UIView *lastView=[[UIView alloc]initWithFrame:CGRectMake(0, 440, kScreen_Width, 400)];
    lastView.backgroundColor=[UIColor whiteColor];
    
    UIImageView *qqImage=[[UIImageView alloc]init];
    [lastView addSubview:qqImage];
    qqImage.image=[UIImage imageNamed:@"mQQ"];
    [qqImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [qqImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [qqImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *QQText = [[UITextField alloc]init];
    QQText.delegate=self;
    self.QQText=QQText;
    QQText.keyboardType=UIKeyboardTypeNumberPad;
    [lastView addSubview:QQText];
    QQText.backgroundColor = [UIColor whiteColor];
    QQText.layer.cornerRadius = 6.0;
    QQText.placeholder = @"请输入QQ号";
    QQText.leftViewMode = UITextFieldViewModeAlways;
    [QQText autoSetDimension:ALDimensionHeight toSize:30];
    [QQText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [QQText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [QQText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [QQText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    UIImageView *WXImage=[[UIImageView alloc]init];
    [lastView addSubview:WXImage];
    WXImage.image=[UIImage imageNamed:@"mWX"];
    [WXImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:qqImage withOffset:30];
    [WXImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [WXImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    
    UITextField *WXText = [[UITextField alloc]init];
    self.WXText=WXText;
    WXText.keyboardType = UIKeyboardTypeASCIICapable;
    WXText.delegate=self;
    [lastView addSubview:WXText];
    WXText.backgroundColor = [UIColor whiteColor];
    WXText.layer.cornerRadius = 6.0;
    WXText.placeholder = @"请输入微信号";
    WXText.leftViewMode = UITextFieldViewModeAlways;
    [WXText autoSetDimension:ALDimensionHeight toSize:30];
    [WXText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    [WXText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:145];
    [WXText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:qqImage withOffset:30];
    
    
    
    UIView *yzmline=[[UIView alloc]init];
    yzmline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [WXText addSubview:yzmline];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-55];
    [yzmline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-110];
    [yzmline autoSetDimension:ALDimensionHeight toSize:1];

    UILabel *qwLab=[[UILabel alloc]init];
    [lastView addSubview:qwLab];
    qwLab.font=[UIFont systemFontOfSize:14];
    qwLab.textColor=[UIColor colorWithHexString:@"0xfe8644"];
    qwLab.text=@"本人QQ或微信号(填写一项即可)";
    qwLab.textAlignment=NSTextAlignmentRight;
    [qwLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [qwLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [qwLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:yzmline withOffset:10];
    [qwLab autoSetDimension:ALDimensionHeight toSize:20];

    /*登录按钮*/
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [lastView addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:yzmline withOffset:50];
    
    UIButton *selectBtn=[[UIButton alloc]init];
    [selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    selectBtn.selected=YES;
    self.selectBtn=selectBtn;
    [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [lastView addSubview:selectBtn];
    [selectBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:20];
    [selectBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [selectBtn autoSetDimensionsToSize:CGSizeMake(20, 20)];
    
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"我同意《e捷金服用户协议》"];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"0x4481fe"]
                       range:NSMakeRange(3, 10)];
    UILabel *bottomLab=[[UILabel alloc]init];
    bottomLab.font=[UIFont systemFontOfSize:14];
    bottomLab.attributedText=attrString;
    [lastView addSubview:bottomLab];
    bottomLab.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agree:)];
    singleTap.numberOfTapsRequired=1;
    [bottomLab addGestureRecognizer:singleTap];

    [bottomLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:20];
    [bottomLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [bottomLab autoSetDimensionsToSize:CGSizeMake(200, 20)];

    
    UILabel *bottomLab1=[[UILabel alloc]init];
    [lastView addSubview:bottomLab1];
    bottomLab1.text=@"温馨提示";
    bottomLab1.font=[UIFont systemFontOfSize:14];
    bottomLab1.textColor=[UIColor colorWithHexString:@"0xfe8644"];
    [bottomLab1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [bottomLab1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:selectBtn withOffset:30];
    [bottomLab1 autoSetDimensionsToSize:CGSizeMake(100, 20)];
    
    UILabel *bottomLab2 = [[UILabel alloc] init];
    bottomLab2.font = [UIFont systemFontOfSize:14];
    NSString *str = @"1、客服MM审核时不会致电联系人，会通过分析确定与联系人的联系。";
    bottomLab2.text = str;
    bottomLab2.textColor = [UIColor colorWithHexString:@"0xfe8644"];
    bottomLab2.numberOfLines = 0;
    bottomLab2.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreen_Width-60, 9999);
    [lastView addSubview:bottomLab2];
    CGSize expectSize = [bottomLab2 sizeThatFits:maximumLabelSize];
    [bottomLab2 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [bottomLab2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [bottomLab2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:bottomLab1 withOffset:5];
    [bottomLab2 autoSetDimension:ALDimensionHeight toSize:expectSize.height];

    UILabel *bottomLab3 = [[UILabel alloc] init];
    bottomLab3.font = [UIFont systemFontOfSize:14];
    NSString *str2 = @"2、如果消息不属实系统将拒绝您的借款申请，同时会把您加入系统黑名单。";
    bottomLab3.text = str2;
    bottomLab3.textColor = [UIColor colorWithHexString:@"0xfe8644"];
    bottomLab3.numberOfLines = 0;
    bottomLab3.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize2 = CGSizeMake(kScreen_Width-60, 9999);
    [lastView addSubview:bottomLab3];
    CGSize expectSize2 = [bottomLab3 sizeThatFits:maximumLabelSize2];
    [bottomLab3 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [bottomLab3 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [bottomLab3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:bottomLab2 withOffset:5];
    [bottomLab3 autoSetDimension:ALDimensionHeight toSize:expectSize2.height];

    return lastView;
}
-(void)viewWillAppear:(BOOL)animated{
      [self.rdv_tabBarController setTabBarHidden:YES];
}
-(void)agree:(id)sender{
    DTCustomeWebViewController *DV=[[DTCustomeWebViewController alloc]init];
    DV.webUrl=[NSString stringWithFormat:@"%@/api.php/index/yjydProtocal",kUrl];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:DV];
    [self presentViewController:nav_third animated:NO completion:nil];

}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return  kScreen_Height;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 840;
}
-(void)selectClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        [sender setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
}
-(void)submitClick{
    if (self.selectBtn.selected==NO) {
        showAlert(@"请同意");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectRelation{
    UIButton *bigBackBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+64+20)];
    bigBackBtn.backgroundColor=RGBA(42, 42, 42, 0.7);
    self.bigBackBtn=bigBackBtn;
    [[[UIApplication sharedApplication ] keyWindow ] addSubview : bigBackBtn];
    
    [bigBackBtn addTarget:self action:@selector(clickEmpt) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.userInteractionEnabled=YES;
    bgView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [bigBackBtn addSubview:bgView];
    bgView.frame=CGRectMake(0, kScreen_Height-200, kScreen_Width, 200);
    
    UILabel *topLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    topLab.text=@"关系";
    [bgView addSubview:topLab];
    topLab.textColor=[UIColor grayColor];
    topLab.textAlignment=NSTextAlignmentCenter;
    topLab.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    NSArray *relaArray=@[@"父亲",@"母亲",@"朋友"];
    for (int i=0; i<3; i++) {
        UIButton *relaLab=[[UIButton alloc]initWithFrame:CGRectMake(20, 50*(i+1), kScreen_Width-20, 50)];
        relaLab.tag=i;
        [relaLab addTarget:self action:@selector(selRelation:) forControlEvents:UIControlEventTouchUpInside];
        [relaLab setTitle:relaArray[i] forState:UIControlStateNormal];
        [relaLab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [relaLab setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [bgView addSubview:relaLab];
        if (i!=2) {
            UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(10, 100+50*i, kScreen_Width-20, 1)];
            sepView.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
            [bgView addSubview:sepView];
        }
    }

}
-(void)selRelation:(UIButton *)sender{
    NSArray *relaArray=@[@"父亲",@"母亲",@"朋友"];
    [self.bigBackBtn removeFromSuperview];
    if (self.isFirstRelation==YES) {
        self.relationText1.text=relaArray[sender.tag];
    }else{
        self.relationText2.text=relaArray[sender.tag];
    }
  
}
// 获得焦点
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.relationText1||textField==self.relationText2) {
        //[textField resignFirstResponder];
        if (textField==self.relationText1) {
            self.isFirstRelation=YES;
        }else{
            self.isFirstRelation=NO;
        }
        [self selectRelation];
        return NO;
    }else if (textField==self.phoneText1||textField==self.phoneText2||textField==self.nameText1||textField==self.nameText2){
       // [textField resignFirstResponder];
        if (textField==self.phoneText1||textField==self.nameText1) {
            self.isFirstRelation=YES;
        }else{
            self.isFirstRelation=NO;
        }
        if(iOS9OrLater) {
            [_objct10 getAddress:self];
        }else {
            [_objct9 getAddress:self];
        }
        return NO;
    }
    return YES;
}
-(void)clickEmpt
{
    [self.bigBackBtn removeFromSuperview];
}
-(void)getLinkDatas{
    // 1. 判读授权
    NSMutableArray *mArray=[NSMutableArray array];
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus != kABAuthorizationStatusAuthorized) {
        
        NSLog(@"没有授权");
        return;
    }
    
    // 2. 获取所有联系人
    ABAddressBookRef addressBookRef = ABAddressBookCreate();
    CFArrayRef arrayRef = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    long count = CFArrayGetCount(arrayRef);
    for (int i = 0; i < count; i++) {
        //获取联系人对象的引用
        ABRecordRef people = CFArrayGetValueAtIndex(arrayRef, i);
        
        //获取当前联系人名字
        NSString *firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        
        //获取当前联系人姓氏
        NSString *lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        //    NSLog(@"--------------------------------------------------");
        if (!firstName) {
            firstName=@"";
        }
        
        if (!lastName) {
            lastName=@"";
        }
        NSString *Name=[NSString stringWithFormat:@"%@%@",lastName,firstName]
        ;
        
        //获取当前联系人的电话 数组
        NSMutableArray *phoneArray = [[NSMutableArray alloc]init];
        ABMultiValueRef phones = ABRecordCopyValue(people, kABPersonPhoneProperty);
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
            NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
            //   NSLog(@"phone=%@", phone);
            [phoneArray addObject:phone];
        }
        
        NSDictionary *dic=@{
                            @"name":Name,
                            @"phone":phoneArray
                            };
        
        [mArray addObject:dic];
    }
    _linkmanInfoArray=[mArray mutableCopy];
    
   
}
- (void)submit{
    [self getLinkDatas];
    if ([self isBlankString:self.nameText1.text]||[self isBlankString:self.nameText2.text]) {
        showAlert(@"请填写姓名和手机号");
        return;
    }
    if ([self isBlankString:self.relationText1.text]||[self isBlankString:self.relationText2.text]) {
        showAlert(@"请填写关系");
        return;
    }
    if ([self isBlankString:self.QQText.text]&&[self isBlankString:self.WXText.text]) {
        showAlert(@"QQ和微信选填一项");
        return;
    }
    NSMutableDictionary *dicFriends = [[NSMutableDictionary alloc] init];
    
    [dicFriends setObject:_linkmanInfoArray forKey:@"datas"];
    
    NSData *dataFriends = [NSJSONSerialization dataWithJSONObject:dicFriends options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:dataFriends
                            
                                                 encoding:NSUTF8StringEncoding];
   // NSString *ss=[_linkmanInfoArray componentsJoinedByString:@""];
    NSString *userId;
    if([DEFAULTS objectForKey:@"userId"]){
        userId=[DEFAULTS objectForKey:@"userId"];
    }else{
        userId=@"";
    }
    NSString *relation1;
    NSString *relation2;
    if ([self.relationText1.text isEqualToString:@"父亲"]) {
        relation1=@"1";
    }else if([self.relationText1.text isEqualToString:@"母亲"]){
        relation1=@"2";
    }else{
        relation1=@"3";
    }
    if ([self.relationText2.text isEqualToString:@"父亲"]) {
        relation2=@"1";
    }else if([self.relationText2.text isEqualToString:@"母亲"]){
        relation2=@"2";
    }else{
        relation2=@"3";
    }
    [kNetManager toSocialauth:userId realname1:self.nameText1.text mobile1:self.phoneText1.text relation1:relation1 realname2:self.nameText2.text mobile2:self.phoneText2.text relation2:relation2 phonelist:jsonString qq:self.QQText.text weixin:self.WXText.text Success:^(id responseObject) {
        NSLog(@"社交认证提交：%@",responseObject);
        //if ([responseObject[@"status"] intValue]==100) {
           // [JRToast showWithText:@"提交成功" duration:2.0];
            [self.navigationController popViewControllerAnimated:NO];
            //[LRNotificationCenter postNotificationName:@"toSencondCtr" object:nil];
      //  }
    } Failure:^(NSError *error) {
         NSLog(@"社交认证提交：%@",error);
    }];
    
}
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
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
