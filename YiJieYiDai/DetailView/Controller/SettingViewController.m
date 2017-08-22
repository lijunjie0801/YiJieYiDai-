//
//  SettingViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/5.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangePWDViewController.h"
#import "ForgetViewController.h"
#import "SVProgressHUD.h"
#import "SZKCleanCache.h"
#import "MQVerCodeImageView.h"
#import "XDAlertController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,BackBtnDelegate>
@property (nonatomic, strong) MQVerCodeImageView *codeImageView;
@property (nonatomic, strong)UIImageView *iconimage;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    self.title=@"设置";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView.frame=CGRectMake(0, 0,kScreen_Width, kScreen_Width/1.8+20);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0,50, 0);
    [self setTopView];
   
}

-(void)setTopView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 80)];
     topView.userInteractionEnabled=YES;
    topView.backgroundColor=[UIColor whiteColor];
    UILabel *changeIconLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 100, 20)];
    changeIconLab.text=@"更换头像";
    changeIconLab.textColor=[UIColor grayColor];
    [topView addSubview:changeIconLab];
    _tableView.tableHeaderView=topView;
    
    UIImageView *iconimage=[[UIImageView alloc]init];
    self.iconimage=iconimage;
    [topView addSubview:iconimage];
    [iconimage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [iconimage autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [iconimage autoSetDimensionsToSize:CGSizeMake(60, 60)];
    iconimage.userInteractionEnabled=YES;
    [iconimage sd_setImageWithURL:[NSURL URLWithString:self.iconString] placeholderImage:[UIImage imageNamed:@"personIcon"]];
    iconimage.clipsToBounds=YES;
    iconimage.layer.cornerRadius=30;
    
    UIButton *moreBtn=[[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [topView addSubview:moreBtn];
    [moreBtn addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 60)];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView addSubview:[self middleview]];
    [cell.contentView addSubview:[self bottemView]];
    return cell;
}
-(UIView *)middleview{
    UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreen_Width, 240)];
    middleView.backgroundColor=[UIColor whiteColor];
    NSArray *labelText=@[@"修改密码",@"忘记密码",@"清除缓存",@"当前版本"];
    for (int i = 0; i <3; i++) {
        UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(10, 59.5*(i+1), kScreen_Width-20, 1)];
        sepView.backgroundColor=[UIColor colorWithHexString:@"f1f1f1"];
        [middleView addSubview:sepView];
    }
    for (int i = 0; i <4; i++) {
        UILabel *setLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 60*i, 100, 60)];
        setLab.textColor=[UIColor grayColor];
        setLab.text=labelText[i];
        [middleView addSubview:setLab];
        if (i!=3) {
            UIButton *moreBtn=[[UIButton alloc]init];
            [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
            moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
            moreBtn.tag=i;
            [middleView addSubview:moreBtn];
            [moreBtn addTarget:self action:@selector(setClick:) forControlEvents:UIControlEventTouchUpInside];
            [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:60*i];
            [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 60)];
        }else{
            UILabel *banbenLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-120, 60*i, 100, 60)];
            banbenLab.textAlignment=NSTextAlignmentRight;
            banbenLab.textColor=[UIColor grayColor];
            banbenLab.font=[UIFont systemFontOfSize:15];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];  
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            banbenLab.text=app_Version;
            [middleView addSubview:banbenLab];
        }
      
    }
    return  middleView;

}

-(UIView *)bottemView{
    UIButton *bottemView=[[UIButton alloc]initWithFrame:CGRectMake(0, 360, kScreen_Width, 60)];
    bottemView.backgroundColor=[UIColor whiteColor];
    [bottemView setTitle:@"退出登录" forState:UIControlStateNormal];
     [bottemView addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [bottemView setTitleColor:[UIColor colorWithHexString:@"0x4481fe"] forState:UIControlStateNormal];
    return bottemView;
}
-(void)logout{
    
    [kNetManager getLogout:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"logout:%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [DEFAULTS removeObjectForKey:@"userId"];
            [self.delegate refresh];
            [LRNotificationCenter postNotificationName:@"refresh" object:nil];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    } Failure:^(NSError *error) {
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  kScreen_Height-60;
}
-(void)goback{
     [self.delegate refresh];
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)setClick:(UIButton *)sender{
    if (sender.tag==0) {
        ChangePWDViewController *CV=[[ChangePWDViewController alloc]init];
        [self.navigationController pushViewController:CV animated:NO];
    }else if (sender.tag==1){
        ForgetViewController *FV=[[ForgetViewController alloc]init];
         [self.navigationController pushViewController:FV animated:NO];
    }else{
        [SVProgressHUD showWithStatus:@"正在清除缓存···"];
        //输出缓存大小 m
        NSLog(@"%.2fm",[SZKCleanCache folderSizeAtPath]);
        
        //清楚缓存
        [SZKCleanCache cleanCache:^{
            NSLog(@"清除成功");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
//             [SVProgressHUD dismissWithDelay:2.0f];
        }];
    }
}
//- (void)singleTap:(UITapGestureRecognizer *)gesture{
//    [self changeIcon];
//}
-(void)changeIcon{
    if (![DEFAULTS objectForKey:@"userId"]) {
        return;
    }
    XDAlertController *alert = [XDAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:XDAlertControllerStyleActionSheet];
    XDAlertAction *action1 = [XDAlertAction actionWithTitle:@"从相册获取" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    XDAlertAction *action2 = [XDAlertAction actionWithTitle:@"拍照" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    XDAlertAction *action3 = [XDAlertAction actionWithTitle:@"取消" style:XDAlertActionStyleCancel handler:^(XDAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)saveImage:(UIImage *)image {
    // 对于base64编码编码
    NSString *headImageString=[self UIImageToBase64Str:image];
    [kNetManager changeUserIcon:[DEFAULTS objectForKey:@"userId"] headcode:headImageString Success:^(id responseObject) {
        NSLog(@"头像上传成功%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            
            _iconimage.image=image;
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImageStr;
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
