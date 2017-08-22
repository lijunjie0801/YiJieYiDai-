//
//  MustIdentifyViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MustIdentifyViewController.h"
#import "MustModel.h"
#import "MustIdentifyViewCell.h"
#import "IdentifySuccessViewController.h"
#import "IdentfyPhoneViewController.h"
#import "IdentifyZhiMAViewController.h"
#import "IdentifySheJiaoViewController.h"
#import "IdentifyJieDaiBaoViewController.h"
#import "IdentifyShenFenZhengViewController.h"
#import "IdentfyZhiFuBaoController.h"
@interface MustIdentifyViewController ()<BackBtnDelegate,UITableViewDelegate,UITableViewDataSource,MustDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *homeArray;
@property(nonatomic,strong)NSMutableArray *isIdentifyArray;
@property(nonatomic,strong)UIButton *submitBtn;
@end

@implementation MustIdentifyViewController
-(NSMutableArray *)isIdentifyArray{
    if (!_isIdentifyArray) {
        _isIdentifyArray=[NSMutableArray array];
    }
    return _isIdentifyArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initData];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"必备认证";
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView.frame=CGRectMake(0, 0,kScreen_Width, kScreen_Width/1.8+20);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0,50, 0);
    
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    self.tableView.tableHeaderView=topview;
    
    UIView *botomview=[[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreen_Width, 100)];
    [botomview addSubview:[self submitView]];
    self.tableView.tableFooterView=botomview;
}
-(void)viewWillAppear:(BOOL)animated{
    [self initData];
}
-(void)initData{
    NSMutableArray *muArray=[NSMutableArray array];
    [kNetManager getIsIdentifyData:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
            
            NSLog(@"是否认证%@",responseObject);
           
            NSString *is_zmxy=responseObject[@"datas"][@"index"][@"isZhimaReal"];
            NSString *is_zhifubao=responseObject[@"datas"][@"index"][@"isAlipayReal"];
            NSString *is_social=responseObject[@"datas"][@"index"][@"isSocialReal"];
            NSString *is_jiedaibao=responseObject[@"datas"][@"index"][@"isDebitReal"];
            NSString *is_authentic=responseObject[@"datas"][@"index"][@"isCardReal"];
            NSString *canSheng=responseObject[@"datas"][@"index"][@"canSheng"];
            NSString *is_mobile=responseObject[@"datas"][@"index"][@"isPhoneReal"];
            
            [muArray addObject:is_zmxy];
            [muArray addObject:is_zhifubao];
            [muArray addObject:is_social];
            [muArray addObject:is_jiedaibao];
            [muArray addObject:is_authentic];
            [muArray addObject:is_mobile];
            if ([canSheng intValue]==2) {
                [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_submitBtn setBackgroundColor:[UIColor colorWithHexString:@"0xccc8c7"]];
                _submitBtn.userInteractionEnabled=NO;
            }else{
                [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_submitBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
                 _submitBtn.userInteractionEnabled=YES;
            }
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
-(UIView *)submitView{
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 40, kScreen_Width-60, 40)];
    self.submitBtn=submitBtn;
    [submitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit)forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 6.0;
    return submitBtn;
}
-(void)submit{

    DTCustomeWebViewController *webVC=[[DTCustomeWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"%@/Sindex/loanapply?user_id=%@",kUrl,[DEFAULTS objectForKey:@"userId"]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:nav_third animated:NO completion:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MustModel *model = self.homeArray[indexPath.row];
    
    NSString *identifier = [NSString stringWithFormat:@"TimeLineCell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    MustIdentifyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =  [[MustIdentifyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.indexRow=[NSString stringWithFormat:@"%ld",indexPath.row];
    cell.delegate=self;
    [cell updataWithModel:model];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  70;
}

-(void)goback{
   // [self dismissViewControllerAnimated:NO completion:nil];
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)toIdentyfy:(NSString *)indexrow{
    NSInteger index=[indexrow integerValue];
    IdentfyPhoneViewController *IPV=[[IdentfyPhoneViewController alloc]init];
    IdentifyZhiMAViewController *IZV=[[IdentifyZhiMAViewController alloc]init];
    IdentifySheJiaoViewController *ISV=[[IdentifySheJiaoViewController alloc]init];
    IdentifyJieDaiBaoViewController *IJV=[[IdentifyJieDaiBaoViewController alloc]init];
    IdentifyShenFenZhengViewController *ISFV=[[IdentifyShenFenZhengViewController alloc]init];
    ISFV.backType=@"1";
    IdentifySuccessViewController *idc=[[IdentifySuccessViewController alloc]init];
    idc.type=@"1";
    IdentfyZhiFuBaoController *IZFBV=[[IdentfyZhiFuBaoController alloc]init];
    NSString *userId=[DEFAULTS objectForKey:@"userId"];
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
        [self.navigationController pushViewController:ISV animated:NO];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
