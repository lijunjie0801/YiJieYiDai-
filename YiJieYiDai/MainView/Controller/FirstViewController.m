//
//  FirstViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/2.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FirstViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "LoginViewController.h"
#import "MustIdentifyViewController.h"
@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,WebViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)NSMutableArray *homeArray;
@property(nonatomic,strong)UILabel *canMoneyNumLab;
@property(nonatomic,strong)NSString *canMoneystring;
@property(nonatomic,strong)NSString *is_persondata;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"用户id：%@",[DEFAULTS objectForKey:@"userId"]);
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.navigationController.view addSubview:_tableView];
    _tableView.tableHeaderView.frame=CGRectMake(0, 0,kScreen_Width, kScreen_Width/1.8+20);
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];

    _tableView.contentInset = UIEdgeInsetsMake(0, 0,50, 0);
    _tableView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
     [self initdata];
 
}

-(void)initdata{
    NSMutableArray *homeModelArray=[NSMutableArray array];
    NSArray *imgarray=@[@"shandian",@"duixian"];
    NSArray *rightimgarray=@[@"huobao",@"tuijian"];
    NSString *userId;
    if([DEFAULTS objectForKey:@"userId"]){
        userId=[DEFAULTS objectForKey:@"userId"];
    }else{
        userId=@"";
    }
    [kNetManager getHomeData:userId Success:^(id responseObject) {
        NSLog(@"首页数据%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            self.canMoneystring=responseObject[@"datas"][@"index"][@"creditMoney"];
            self.is_persondata=responseObject[@"datas"][@"index"][@"quickGoto"];
            for (int i=0;i<2;i++) {
                HomeModel *model=[[HomeModel alloc]init];
                model.image=imgarray[i];
                model.rightImage=rightimgarray[i];
                if (i==0) {
                    model.price=responseObject[@"datas"][@"index"][@"quickContent"];
                    model.status=@"1";
                }else{
                    model.status=@"2";
                    model.price=responseObject[@"datas"][@"index"][@"cashContent"];
                }
             
                [homeModelArray addObject:model];
            }
            _homeArray=[homeModelArray mutableCopy];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error) {
        
    }];

}
- (void)headerRereshing{
    [self initdata];
    [self.tableView.header endRefreshing];
    
}

-(UIView *)setTopView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.8)];
    topView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    UIImageView *topImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.8)];
    topImg.image=[UIImage imageNamed:@"HomeTop"];
    topImg.userInteractionEnabled=YES;
    [topView addSubview:topImg];
    
    UILabel *keyongLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 45, kScreen_Width, 20)];
    keyongLab.textAlignment = NSTextAlignmentCenter;
    keyongLab.text=@"可用额度(元)";
    keyongLab.font=[UIFont systemFontOfSize:14];
    keyongLab.textColor=[UIColor colorWithHexString:@"0xcddcfb"];
    [topImg addSubview:keyongLab];

    UILabel *numLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, kScreen_Width, 20)];
    numLabel.font=[UIFont systemFontOfSize:23];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.text=self.canMoneystring;
    self.canMoneyNumLab=numLabel;
    numLabel.textColor=[UIColor whiteColor];
    [topImg addSubview:numLabel];

    UILabel *alertLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 105, kScreen_Width, 20)];
    alertLab.font=[UIFont systemFontOfSize:14];
    alertLab.textAlignment = NSTextAlignmentCenter;
  
    alertLab.textColor=[UIColor colorWithHexString:@"0xcddcfb"];
    [topImg addSubview:alertLab];
    
    UIButton *LoginBtn=[[UIButton alloc]init];
    self.loginBtn=LoginBtn;
    [LoginBtn setBackgroundColor:[UIColor whiteColor]];
    LoginBtn.clipsToBounds=YES;
    LoginBtn.layer.cornerRadius=3;
    if ([DEFAULTS objectForKey:@"userId"]) {
        [self.loginBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        alertLab.text=@"立即申请，即可快速申请借款";
    }else{
        [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        alertLab.text=@"填写身份信息，快速获取额度";
    }

   
    [LoginBtn addTarget:self action:@selector(loginAct) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn setTitleColor:[UIColor colorWithHexString:@"0x4481fe"] forState:UIControlStateNormal];
    [topImg addSubview:LoginBtn];
    [LoginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:alertLab withOffset:20];
    [LoginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [LoginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:100];
    [LoginBtn autoSetDimension:ALDimensionHeight toSize:(kScreen_Width/1.8+10)/6.5];

    return topView;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView addSubview:[self setTopView]];
    [cell.contentView addSubview:[self middleview]];
    return cell;
}
-(UIView *)middleview{
    UIView *middleview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Width/1.8+20, kScreen_Width, kScreen_Height-kScreen_Width/1.8-20)];
    middleview.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    NSArray *imageName=@[@"shandian",@"duixian"];
    
    for (int i=0; i<2; i++) {
        HomeModel *model=_homeArray[i];
        HomeTableViewCell *cusview=[[HomeTableViewCell alloc]initWithFrame:CGRectMake(0, ((kScreen_Width-20)/2.7+20)*i, kScreen_Width, (kScreen_Width-20)/2.7+20)];
        cusview.tag=i;
        cusview.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [cusview addGestureRecognizer:singleTap];
        cusview.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        cusview.backimageView.image=[UIImage imageNamed:imageName[i]];
        cusview.priceLab.text=model.price;
        if([model.status integerValue]==1){
            cusview.rightView.image=[UIImage imageNamed:@"tuijian"];
        }else if([model.status integerValue]==2){
            cusview.rightView.image=[UIImage imageNamed:@"huobao"];
        }
        [middleview addSubview:cusview];
    }
    NSString *str = @"不向学生提供服务";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(kScreen_Width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    NSLog(@"%f%f", size.width, size.height);
    
    UIImageView *studentView=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-30-size.width)/2, ((kScreen_Width-20)/2.7+20)*2+20, 20, 20)];
    studentView.image=[UIImage imageNamed:@"tishi"];
    [middleview addSubview:studentView];
    UILabel *studentLab=[[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-30-size.width)/2+30, ((kScreen_Width-20)/2.7+20)*2+20, size.width+20, 20)];
    studentLab.text=str;
    studentLab.font=[UIFont systemFontOfSize:15];
    studentLab.textColor=[UIColor colorWithHexString:@"0xfe8644"];
    [middleview addSubview:studentLab];
    return middleview;
}
-(void)loginAct{
    if ([DEFAULTS objectForKey:@"userId"]) {
        [self torenzheng];
    }else{
        LoginViewController *LV=[[LoginViewController alloc]init];
        UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:LV];
        [self presentViewController:nav_third animated:NO completion:nil ];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  kScreen_Height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self initdata];
//    [LRNotificationCenter addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];
}
-(void)refresh{
    [self initdata];
}
-(void)singleTap:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld",[singleTap view].tag);
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
        return;
    }
    if ([singleTap view].tag==0) {
        [self torenzheng];
    }else{
        DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
        webVC.webUrl=[NSString stringWithFormat:@"%@/api.php/cashPay/index?appKey=%@",kUrl,[DEFAULTS objectForKey:@"userId"]];
        UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
        [self presentViewController:nav_third animated:NO completion:nil];
    }
}
-(void)torenzheng{
    if ([self.is_persondata integerValue]==1) {
        DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
        webVC.delegate=self;
        webVC.webUrl=[NSString stringWithFormat:@"%@/api.php/userCenter/userInfo?appKey=%@",kUrl,[DEFAULTS objectForKey:@"userId"]];
        //  MustIdentifyViewController *MC=[[MustIdentifyViewController alloc]init];
        UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
        [self presentViewController:nav_third animated:NO completion:nil];
    }else if ([self.is_persondata integerValue]==2){
        MustIdentifyViewController *MC=[[MustIdentifyViewController alloc]init];
        UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:MC];
        [self presentViewController:nav_third animated:NO completion:nil];
    }else if ([self.is_persondata integerValue]==3){
        DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
        webVC.delegate=self;
        webVC.webUrl=[NSString stringWithFormat:@"%@/api.php/loanPay/index?appKey=%@",kUrl,[DEFAULTS objectForKey:@"userId"]];
        //  MustIdentifyViewController *MC=[[MustIdentifyViewController alloc]init];
        UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
        [self presentViewController:nav_third animated:NO completion:nil];
    }

}
-(void)homeRefresh{
    [self initdata];
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

@end
