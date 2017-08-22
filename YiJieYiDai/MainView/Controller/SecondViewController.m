//
//  SecondViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/2.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdCustomeView.h"
#import "IdentfyPhoneViewController.h"
#import "IdentifyZhiMAViewController.h"
#import "IdentifySheJiaoViewController.h"
#import "IdentifyJieDaiBaoViewController.h"
#import "IdentifyShenFenZhengViewController.h"
#import "LoginViewController.h"
#import "MustModel.h"
#import "IdentifySuccessViewController.h"
#import "IdentfyZhiFuBaoController.h"
#import <AddressBook/AddressBook.h>
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *isIdentifyArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *homeArray;
@end

@implementation SecondViewController
-(NSMutableArray *)isIdentifyArray{
    if (!_isIdentifyArray) {
        _isIdentifyArray=[NSMutableArray array];
    }
    return _isIdentifyArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"认证";
    self.view.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.view addSubview:_tableView];
    [self initData];
    
}
- (void)headerRereshing{
    [self initData];
    [self.tableView.header endRefreshing];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [cell.contentView addSubview:[self setTopView]];
    [cell.contentView addSubview:[self middleview]];
//    [cell.contentView addSubview:[self bottemView]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  kScreen_Height;
}
-(UIView *)middleview{
    UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    middleView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width-10, 50)];
    label.text=@"必备认证";
    label.textColor=[UIColor grayColor];
    [middleView addSubview:label];
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreen_Width, 250)];
    backView.backgroundColor=[UIColor whiteColor];
    [middleView addSubview:backView];
    NSArray *labelText=@[@"芝麻信用",@"支付宝认证",@"社交认证",@"借贷宝无忧",@"身份认证",@"手机认证"];
    NSArray *labelImage=@[@"zhimaxinyong",@"zhifubaorenzheng",@"shejiaorenzheng",@"jiedaibaorenzheng",@"shenfenrenzheng",@"shoujirenzheng"];
    for (int i = 0; i <6; i++) {
        ThirdCustomeView *btnView=[[ThirdCustomeView alloc]initWithFrame:CGRectMake(i%3*(kScreen_Width/3), i/3*125, kScreen_Width/3, 125)];
        btnView.tag=i;
        btnView.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [btnView addGestureRecognizer:singleTap];
        [backView addSubview:btnView];
        btnView.imageview.image=[UIImage imageNamed:labelImage[i]];
        btnView.label.text=labelText[i];
        MustModel *model=_homeArray[i];
        if (![DEFAULTS objectForKey:@"userId"]) {
            btnView.rightTopView.image=[UIImage imageNamed:@"weirenzheng"];
        }else{
            if ([model.isIdentify isEqualToString:@"1"]) {
                btnView.rightTopView.image=[UIImage imageNamed:@"yirenzheng"];
            }else{
                btnView.rightTopView.image=[UIImage imageNamed:@"weirenzheng"];
                
            }
            
        }
        
    }
    for (int i=0; i<2; i++) {
        UIView *shuxian=[[UIView alloc]initWithFrame:CGRectMake(kScreen_Width/3*(i+1), 0, 1, 250)];
        shuxian.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
        [backView addSubview:shuxian];
    }
    UIView *hengxian=[[UIView alloc]initWithFrame:CGRectMake(10, 124.5, kScreen_Width-20, 1)];
    hengxian.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [backView addSubview:hengxian];

    UILabel *shuomingLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 320, 50, 20)];
    shuomingLab.textColor=[UIColor grayColor];
    shuomingLab.text=@"说明:";
    [middleView addSubview:shuomingLab];
    
    UIImageView *yiImgView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 320, 20, 20)];
    yiImgView.image=[UIImage imageNamed:@"yirenzheng"];
    [middleView addSubview:yiImgView];
    
    UILabel *yiLab=[[UILabel alloc]initWithFrame:CGRectMake(120, 320, 70, 20)];
    yiLab.textColor=[UIColor grayColor];
    yiLab.text=@"已认证";
    [middleView addSubview:yiLab];
    
    UIImageView *weiImgView=[[UIImageView alloc]initWithFrame:CGRectMake(200, 320, 20, 20)];
    weiImgView.image=[UIImage imageNamed:@"weirenzheng"];
    [middleView addSubview:weiImgView];
    
    UILabel *weiLab=[[UILabel alloc]initWithFrame:CGRectMake(240, 320, 70, 20)];
    weiLab.textColor=[UIColor grayColor];
    weiLab.text=@"未认证";
    [middleView addSubview:weiLab];

     return  middleView;
}
-(void)initData{
    NSMutableArray *muArray=[NSMutableArray array];
    NSString *userId;
    if (![DEFAULTS objectForKey:@"userId"]) {
        userId=@"";
    }else{
        userId=[DEFAULTS objectForKey:@"userId"];
    }
    NSLog(@"user%@",userId);
    [kNetManager getIsIdentifyData:userId Success:^(id responseObject) {
         NSLog(@"是否认证%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            
           
            NSString *is_mobile=responseObject[@"datas"][@"index"][@"isPhoneReal"];
            NSString *is_zmxy=responseObject[@"datas"][@"index"][@"isZhimaReal"];
            NSString *is_zhifubao=responseObject[@"datas"][@"index"][@"isAlipayReal"];
            NSString *is_social=responseObject[@"datas"][@"index"][@"isSocialReal"];
            NSString *is_jiedaibao=responseObject[@"datas"][@"index"][@"isDebitReal"];
            NSString *is_authentic=responseObject[@"datas"][@"index"][@"isCardReal"];
            
            [muArray addObject:is_zmxy];
            [muArray addObject:is_zhifubao];
            [muArray addObject:is_social];
            [muArray addObject:is_jiedaibao];
            [muArray addObject:is_authentic];
            [muArray addObject:is_mobile];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            NSArray *imgarray=@[@"zm",@"zhifubao",@"sh",@"jdb",@"sf",@"geren"];
            NSArray *titleArray=@[@"芝麻信用",@"支付宝",@"社交认证",@"借贷宝无忧",@"身份证认证",@"手机认证"];
            for (int i=0;i<imgarray.count;i++) {
                MustModel *model=[[MustModel alloc]init];
                model.imageIcon=imgarray[i];
                model.title=titleArray[i];
                model.isIdentify=muArray[i];
                [homeModelArray addObject:model];
                
            }
            _homeArray=[homeModelArray mutableCopy];
            
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error) {
        
    }];

}

-(void)setBottomView{
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"toSencondCtr" object:nil];
//        [LRNotificationCenter addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];
        [self.rdv_tabBarController setTabBarHidden:NO];
    [self initData];

}
-(void)toSencondCtr:(NSNotification *)noti{
    [self initData];
}
-(void)singleTap:(id)sender{
    IdentfyPhoneViewController *IPV=[[IdentfyPhoneViewController alloc]init];
    IdentifyZhiMAViewController *IZV=[[IdentifyZhiMAViewController alloc]init];
    IdentifySheJiaoViewController *ISV=[[IdentifySheJiaoViewController alloc]init];
    IdentifyJieDaiBaoViewController *IJV=[[IdentifyJieDaiBaoViewController alloc]init];
    IdentifyShenFenZhengViewController *ISFV=[[IdentifyShenFenZhengViewController alloc]init];
    ISFV.backType=@"1";
    IdentifySuccessViewController *idc=[[IdentifySuccessViewController alloc]init];
    idc.type=@"1";
    IdentfyZhiFuBaoController *IZFBV=[[IdentfyZhiFuBaoController alloc]init];
    NSString *userId;
    if (![DEFAULTS objectForKey:@"userId"]) {
        [self alertLogin];
        return;
    }else{
        userId=[DEFAULTS objectForKey:@"userId"];
    }
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld",[singleTap view].tag);
    NSInteger index=[singleTap view].tag;
     MustModel *model=_homeArray[index];
      if ([model.isIdentify integerValue]==1) {
          return;
      }
    if (index==4) {
        if ([model.isIdentify integerValue]==3) {
            [self.navigationController pushViewController:idc animated:NO];
        }else{
            [self.navigationController pushViewController:ISFV animated:NO];
        }
    }
    if (index==3) {
        if ([model.isIdentify integerValue]==3) {
                [self.navigationController pushViewController:idc animated:NO];
            }else{
                [self.navigationController pushViewController:IJV animated:NO];
            }
        }
    if (index==2) {
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
             [self.navigationController pushViewController:ISV animated:NO];
        }else if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
             [self.navigationController pushViewController:ISV animated:NO];
        }else{
//            UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有获取通讯录权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//            alert.delegate = self;
//            [alert show];
            [self toSQ];
        }

        
        
    }
    if (index==1) {
        [self.navigationController pushViewController:IZFBV animated:NO];

    }
    if (index==0) {
        [self.navigationController pushViewController:IZV animated:NO];
    }
    if (index==5) {
        
        if ([model.isIdentify integerValue]==3) {
            [self.navigationController pushViewController:idc animated:NO];

        }else
            [self.navigationController pushViewController:IPV animated:NO];
        }
    

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
-(void)toSQ{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你尚未授权访问您的通讯录，是否去设置" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

          }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)refresh{
  //  [self initData];
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
