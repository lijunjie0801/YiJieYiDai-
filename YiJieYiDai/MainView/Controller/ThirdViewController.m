//
//  ThirdViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/2.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ThirdViewController.h"
#import "HomeTableViewCell.h"
#import "CustomeViewCell.h"
#import "SettingViewController.h"
#import "XDAlertController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "LoginViewController.h"
#import "IdentifyShenFenZhengViewController.h"
@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource,SettingDelegate,SFZDelegate>
@property(nonatomic,strong)NSString *phoneNum;
@property(nonatomic,strong)NSString *is_authentic;
@property(nonatomic,strong)NSString *iconUrl;
@property(nonatomic,strong)UIImageView *iconimage;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -22, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
      self.navigationController.navigationBar.hidden =YES;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView.frame=CGRectMake(0, 0,kScreen_Width, kScreen_Width/1.8+20);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0,50, 0);
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];

    [self setTopView];
    [self getUserData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toMe) name:@"tome" object:nil];
}
-(void)toMe{
    DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"%@/Sindex/myloan?user_id=%@",kUrl,[DEFAULTS objectForKey:@"userId"]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nav_third animated:NO completion:nil];

}
- (void)headerRereshing{
    [self getUserData];
    [self.tableView.header endRefreshing];
    
}
-(void)getUserData{
    
    if ([DEFAULTS objectForKey:@"userId"]) {
        [kNetManager getUserIndexData:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
            NSLog(@"获取个人信息成功:%@",responseObject);
            if ([responseObject[@"status"] intValue]==100) {
                self.phoneNum=responseObject[@"datas"][@"index"][@"userMain"][@"userPhone"];
                self.iconUrl=responseObject[@"datas"][@"index"][@"userMain"][@"userImg"];
                self.is_authentic=responseObject[@"datas"][@"index"][@"userMain"][@"isCardReal"];;
                [self.tableView reloadData];
            }
        } Failure:^(NSError *error) {
            NSLog(@"获取个人信息error:%@",error);
        }];

    }else{
        self.phoneNum=@"";
        self.iconUrl=@"";
        self.is_authentic=@"";
        [self.tableView reloadData];
    }
   }
-(UIView *)setTopView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.8+50)];
    topView.userInteractionEnabled=YES;
    UIImageView *topImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.8)];
    topImg.image=[UIImage imageNamed:@"personCenter"];
    [topView addSubview:topImg];
    topImg.userInteractionEnabled=YES;
    UIImageView *iconimage=[[UIImageView alloc]init];
    self.iconimage=iconimage;
    [topImg addSubview:iconimage];
    [iconimage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [iconimage autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [iconimage autoSetDimensionsToSize:CGSizeMake(80, 80)];
    if([DEFAULTS objectForKey:@"userId"]){
        [iconimage sd_setImageWithURL:[NSURL URLWithString:self.iconUrl] placeholderImage:[UIImage imageNamed:@"personIcon"]];
    }else{
         iconimage.image=[UIImage imageNamed:@"personIcon"];
    }
    iconimage.userInteractionEnabled=YES;
    iconimage.clipsToBounds=YES;
    iconimage.layer.cornerRadius=40;
    [topImg addSubview:iconimage];
    
    UIButton *toLoginLab=[[UIButton alloc]init];
    [toLoginLab addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [toLoginLab setTitle:@"去登录" forState:UIControlStateNormal];
    [toLoginLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topImg addSubview:toLoginLab];
    [toLoginLab setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [toLoginLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconimage withOffset:20];
    [toLoginLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:iconimage withOffset:30];
    [toLoginLab autoSetDimensionsToSize:CGSizeMake(kScreen_Width-130, 20)];
    
    UILabel *nickName=[[UILabel alloc]init];
    nickName.text=self.phoneNum;
    [topImg addSubview:nickName];
    nickName.textColor=[UIColor whiteColor];
    [nickName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconimage withOffset:20];
    [nickName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:iconimage withOffset:10];
    [nickName autoSetDimensionsToSize:CGSizeMake(kScreen_Width-130, 20)];

    UIButton *nickBtn=[[UIButton alloc]init];
    nickBtn.tag=[self.is_authentic intValue];
    [nickBtn addTarget:self action:@selector(identyClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.is_authentic intValue]==2) {
         [nickBtn setTitle:@"去认证" forState:UIControlStateNormal];
    }else if ([self.is_authentic intValue]==1){
         [nickBtn setTitle:@"已认证" forState:UIControlStateNormal];
    }else{
         [nickBtn setTitle:@"待审核" forState:UIControlStateNormal];
    }
    [topImg addSubview:nickBtn];
    nickBtn.clipsToBounds=YES;
    nickBtn.layer.borderWidth=0.8;
    nickBtn.layer.cornerRadius=6;
    nickBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    nickBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [nickBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconimage withOffset:20];
    [nickBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nickName withOffset:20];
    [nickBtn autoSetDimensionsToSize:CGSizeMake(60, 20)];

    
    if([DEFAULTS objectForKey:@"userId"]){
        toLoginLab.hidden=YES;
    }else{
        nickName.hidden=YES;
        nickBtn.hidden=YES;
    }
    
    UILabel *infoLab=[[UILabel alloc]init];
    infoLab.text=@"个人资料";
    [topView addSubview:infoLab];
    infoLab.textColor=[UIColor grayColor];
    [infoLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [infoLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topImg withOffset:0];
    [infoLab autoSetDimensionsToSize:CGSizeMake(100, 50)];

    
    UIButton *moreBtn=[[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [topView addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(selfInfo) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [moreBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topImg withOffset:0];
    [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-20, 50)];
    return topView;
}
-(void)identyClick:(UIButton *)sender{
    if (sender.tag==2) {
        IdentifyShenFenZhengViewController *ISV=[[IdentifyShenFenZhengViewController alloc]init];
        ISV.backType=@"2";
        UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:ISV];
        [self presentViewController:nav_third animated:NO completion:nil];
        
//    [self.navigationController pushViewController:ISV animated:NO];
    }
}
//-(void)ThirdRefresh{
//    [self getUserData];
//}
-(void)viewWillAppear:(BOOL)animated{
    [self getUserData];
}
-(void)selfInfo{
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
        return;
    }
    DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"%@/api.php/userCenter/userInfo?appKey=%@",kUrl,[DEFAULTS objectForKey:@"userId"]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nav_third animated:NO completion:nil];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView addSubview:[self setTopView]];
    [cell.contentView addSubview:[self middleview]];
    [cell.contentView addSubview:[self bottemView]];
    return cell;
}
-(UIView *)middleview{
    UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Width/1.8+50, kScreen_Width, (kScreen_Width/4)*2+10)];
    middleView.backgroundColor=[UIColor whiteColor];
    NSArray *labelText=@[@"我的借款",@"借款攻略",@"还款攻略",@"留言",@"法律责任",@"常见问题",@"客服QQ",@"微信公众"];
    NSArray *labelImage=@[@"wodejiekuan",@"jiekuangonglue",@"huankuangonglue",@"liuyan",@"falvzeren",@"changjianwenti",@"QQ",@"weixin"];
    for (int i = 0; i <8; i++) {
        CustomeViewCell *btnView=[[CustomeViewCell alloc]initWithFrame:CGRectMake(i%4*(kScreen_Width/4), i/4*(kScreen_Width/4), kScreen_Width/4, kScreen_Width/4-10)];
        btnView.tag=i;
        [middleView addSubview:btnView];
        btnView.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thirdClick:)];
        singleTap.numberOfTapsRequired=1;
        [btnView addGestureRecognizer:singleTap];
        btnView.label.text=labelText[i];
        btnView.label.font=[UIFont systemFontOfSize:14];
        btnView.imageview.image=[UIImage imageNamed:labelImage[i]];
    }
    return  middleView;
    }
-(void)thirdClick:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld",[singleTap view].tag);
    NSInteger index=[singleTap view].tag;
    NSArray *webUrlArray=@[@"loanPayPage",@"loanPage",@"repayPage",@"messagePage",@"lawPage",@"problemPage",@"qqService",@"weixinPage"];
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
        return;
    }
    if (index==6) {


        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        // 提供uin, 你所要联系人的QQ号码
        NSString *qqstr = @"mqqwpa://im/chat?chat_type=crm&uin=938182955&version=1&src_type=web&web_src=http:://yjydhk.zilankeji.com";
        NSURL *url = [NSURL URLWithString:qqstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        [self.view addSubview:webView];
        return;
    }
    DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"%@/api.php/userCenter/%@?appKey=%@",kUrl,webUrlArray[index],[DEFAULTS objectForKey:@"userId"]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nav_third animated:NO completion:nil];

}
-(UIView *)bottemView{
    UIView *bottemView=[[UIView alloc]initWithFrame:CGRectMake(0,  kScreen_Width/1.8+70+(kScreen_Width/4)*2+10, kScreen_Width, 50)];
    bottemView.backgroundColor=[UIColor whiteColor];
    
    UILabel *setLab=[[UILabel alloc]init];
    setLab.text=@"设置";
    [bottemView addSubview:setLab];
    setLab.textColor=[UIColor grayColor];
    [setLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [setLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [setLab autoSetDimensionsToSize:CGSizeMake(100, 50)];
    
    UIButton *moreBtn=[[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [bottemView addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-20, 50)];

    return  bottemView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  kScreen_Height;
}
-(void)setClick{
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
        return;
    }
    SettingViewController *SV=[[SettingViewController alloc]init];
    SV.iconString=self.iconUrl;
    SV.delegate=self;
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:SV];

    [self presentViewController:nav_third animated:NO completion:nil];
}
-(void)alertLogin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
         UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav_third animated:NO completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)refresh{
    [self viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginClick{
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:nav_third animated:NO completion:nil];

    
}
@end
