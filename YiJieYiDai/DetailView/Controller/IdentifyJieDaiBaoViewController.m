//
//  IdentifyJieDaiBaoViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "IdentifyJieDaiBaoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "IdentifySuccessViewController.h"
@interface IdentifyJieDaiBaoViewController ()<UITableViewDelegate,UITableViewDataSource,BackBtnDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSInteger _count;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *jdbFlag;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)NSString *image1;
@property(nonatomic,strong)NSString *image2;
@property(nonatomic,strong)NSString *image3;
@property(nonatomic,strong)UIButton *jdbBtn;
@property(nonatomic,strong)UIButton *jtBtn;
@property(nonatomic,strong)UIView *bottemView;
@property(nonatomic,strong)UIImageView *botomImgView;
@end

@implementation IdentifyJieDaiBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rdv_tabBarController setTabBarHidden:YES];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"借贷宝无忧";
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    self.jdbFlag=@"1";
    self.view =_tableView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    CGFloat btnWidth=(kScreen_Width-40)/2;
    return 105+btnWidth*2+(kScreen_Width-20)*1.85+330;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView addSubview:[self topView]];
    [cell.contentView addSubview:[self bottemView]];
    return cell;
}
-(UIView *)topView{
    CGFloat btnWidth=(kScreen_Width-40)/2;
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 90+btnWidth*2)];
    topView.backgroundColor=[UIColor whiteColor];
    UILabel *topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 20, 120, 20)];
    topLab.text=@"请截图上传";
    topLab.textColor=[UIColor grayColor];
    [topView addSubview:topLab];
    
    for (int i=0; i<3; i++) {
        UIButton *topBtn=[[UIButton alloc]init];
        if (i==0) {
            topBtn.frame= CGRectMake((kScreen_Width-btnWidth)/2, 55, btnWidth, btnWidth);
        }else{
            topBtn.frame= CGRectMake(15+(i-1)*(btnWidth+10), 70+btnWidth, btnWidth, btnWidth);
        }
        topBtn.selected=NO;
        topBtn.tag=200+i;
        [topBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jiedaibao%d",i]] forState:UIControlStateNormal];
        [topView addSubview:topBtn];
        [topBtn addTarget:self action:@selector(upLoad:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  topView;
}
-(void)upLoad:(UIButton *)sender{
    _count=sender.tag;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];

}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
- (void)saveImage:(UIImage *)image {
    
    UIButton *JDB=[self.view viewWithTag:_count];
    [JDB setBackgroundImage:image forState:UIControlStateNormal];
    JDB.selected=YES;
    NSString *baseStr=[self UIImageToBase64Str:image];
    [ZZLProgressHUD showHUDWithMessage:@"正在上传"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [kNetManager jiedaibaoIdentifyUpLoad:[DEFAULTS objectForKey:@"userId"] jiedaibao:baseStr Success:^(id responseObject) {
          NSLog(@"上传图片????%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [ZZLProgressHUD popHUD];
            NSString *imgStr=responseObject[@"datas"][@"changeUserImg"][@"smallImg"];
            if (_count==200) {
                self.image1=imgStr;
                NSLog(@"上传图片image1:%ld-----%@",_count,self.image1);
            }else if (_count==201){
                self.image2=imgStr;
                NSLog(@"上传图片image2:%ld-----%@",_count,self.image2);
            }else if (_count==202){
                self.image3=imgStr;
                NSLog(@"上传图片image3:%ld-----%@",_count,self.image3);
            }
        }else{
           [ZZLProgressHUD popHUD];
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }

    } Failure:^(NSError *error) {
        
    }];
//    [kNetManager jiedaibaoIdentifyUpLoad:[DEFAULTS objectForKey:@"userId"] type:[NSString stringWithFormat:@"%ld",_count-200+1] jiedaibao:baseStr Success:^(id responseObject) {
//        NSLog(@"上传图片????%@",responseObject);
//        if ([responseObject[@"result"] integerValue]==100) {
//            [ZZLProgressHUD popHUD];
//            if (_count==200) {
//                self.image1=responseObject[@"img_wallet"];
//                NSLog(@"上传图片image1:%ld-----%@",_count,self.image1);
//            }else if (_count==201){
//                self.image2=responseObject[@"img_hkjilu"];
//                NSLog(@"上传图片image2:%ld-----%@",_count,self.image2);
//            }else if (_count==202){
//                self.image3=responseObject[@"img_jhkuan"];
//                NSLog(@"上传图片image3:%ld-----%@",_count,self.image3);
//            }
//        }
//    } Failure:^(NSError *error) {
//        
//    }];
//    NSLog(@"dic:%@",dic);

}

-(UIView *)bottemView{
     CGFloat btnWidth=(kScreen_Width-40)/2;
    UIView *bottemView=[[UIView alloc]initWithFrame:CGRectMake(0, 105+btnWidth*2, kScreen_Width, (kScreen_Width-20)*1.85+380)];
    self.bottemView=bottemView;
    bottemView.backgroundColor=[UIColor whiteColor];
    
    self.jdbBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, (kScreen_Width-40)/2+20, 40)];
    [_jdbBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [_jdbBtn setTitle:@"借贷宝" forState:UIControlStateNormal];
    [_jdbBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_jdbBtn addTarget:self action:@selector(jdbClick) forControlEvents:UIControlEventTouchUpInside];
    _jdbBtn.selected=YES;
    _jdbBtn.layer.cornerRadius=20.0;
    [bottemView addSubview:_jdbBtn];

    self.jtBtn=[[UIButton alloc]initWithFrame:CGRectMake((kScreen_Width-40)/2-10, 30, (kScreen_Width-40)/2+20, 40)];
    [_jtBtn setBackgroundColor:[UIColor whiteColor]];
    [_jtBtn setTitle:@"无忧借条" forState:UIControlStateNormal];
    [_jtBtn setTitleColor:[UIColor colorWithHexString:@"0x777777"] forState:UIControlStateNormal];
    [_jtBtn addTarget:self action:@selector(jtClick) forControlEvents:UIControlEventTouchUpInside];
    _jtBtn.layer.cornerRadius=20.0;
    _jtBtn.layer.borderColor=[UIColor colorWithHexString:@"0xd3d3d3"].CGColor;
    _jtBtn.layer.borderWidth=1.0;
    _jtBtn.selected=NO;
    [bottemView addSubview:_jtBtn];
    [bottemView bringSubviewToFront:_jdbBtn];

    UILabel *topLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 120, 20)];
    topLab.text=@"截图要求";
    topLab.textColor=[UIColor grayColor];
    [bottemView addSubview:topLab];

    UILabel *textLabel = [[UILabel alloc] init];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"借款记录请将还款日期选成由近到远并按截图示例上传"];
    textLabel.textColor = [UIColor grayColor];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0xfe8644"] range:NSMakeRange(6, 4)];
     [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0xfe8644"] range:NSMakeRange(12, 4)];
    textLabel.attributedText = AttributedStr;
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreen_Width-60, 9999);
    [bottemView addSubview:textLabel];
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [textLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topLab withOffset:5];
    [textLabel autoSetDimension:ALDimensionHeight toSize:expectSize.height];

    
    UIButton *submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 6.0;
    [submitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [bottemView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn autoSetDimension:ALDimensionHeight toSize:40];
    [submitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [submitBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [submitBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textLabel withOffset:40];
 
    UIImageView *botomImgView=[[UIImageView alloc]init];
    self.botomImgView=botomImgView;
    botomImgView.image=[UIImage imageNamed:@"jiedaibaoImage"];
    [bottemView addSubview:botomImgView];
    [botomImgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:submitBtn withOffset:30];
    [botomImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [botomImgView autoSetDimensionsToSize:CGSizeMake(kScreen_Width-20, (kScreen_Width-20)*1.85)];
    return  bottemView;
}
-(void)jdbClick{
    if (self.jdbBtn.selected==NO) {
        self.jdbFlag=@"1";
         _botomImgView.image=[UIImage imageNamed:@"jiedaibaoImage"];
        _jdbBtn.layer.borderWidth=0;
        _jtBtn.layer.borderWidth=1;
        _jtBtn.layer.borderColor=[UIColor colorWithHexString:@"0xd3d3d3"].CGColor;
        [_jdbBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
        [_jdbBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _jdbBtn.selected=YES;
        _jtBtn.selected=NO;
        [_jtBtn setBackgroundColor:[UIColor whiteColor]];
        [_jtBtn setTitleColor:[UIColor colorWithHexString:@"0x777777"] forState:UIControlStateNormal];
        [_bottemView bringSubviewToFront:_jdbBtn];
    }
}
-(void)jtClick{
    if (self.jtBtn.selected==NO) {
          self.jdbFlag=@"2";
        _botomImgView.image=[UIImage imageNamed:@"jtImage"];
//        [_botomImgView autoSetDimension:ALDimensionHeight toSize:(kScreen_Width-20)*1.43];
        _jtBtn.layer.borderWidth=0;
        _jdbBtn.layer.borderWidth=1;
        _jdbBtn.layer.borderColor=[UIColor colorWithHexString:@"0xd3d3d3"].CGColor;
        [_jtBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
        [_jtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _jtBtn.selected=YES;
        _jdbBtn.selected=NO;
        [_jdbBtn setBackgroundColor:[UIColor whiteColor]];
        [_jdbBtn setTitleColor:[UIColor colorWithHexString:@"0x777777"] forState:UIControlStateNormal];
        [_bottemView bringSubviewToFront:_jtBtn];
    }

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
    UIButton *btn1=[self.view viewWithTag:200];
    UIButton *btn2=[self.view viewWithTag:201];
    UIButton *btn3=[self.view viewWithTag:202];
    if (btn1.selected==YES&&btn2.selected==YES&&btn3.selected==YES) {
        // showAlert(@"成功");
    }else{
        showAlert(@"请上传图片");
        return;
    }
    NSLog(@"ppppp::%@",self.jdbFlag);
    NSLog(@"%@---%@--%@",_image1,_image2,_image3);
    [kNetManager toJiedaibaoIdentify:[DEFAULTS objectForKey:@"userId"] img_wallet:self.image1 img_hkjilu:self.image2 img_jhkuan:self.image3  debitType:self.jdbFlag Success:^(id responseObject) {
        NSLog(@"借贷宝认证提交%@",responseObject);
        if ([responseObject[@"status"] intValue]==100) {
            IdentifySuccessViewController *IV=[[IdentifySuccessViewController alloc]init];
            IV.type=@"1";
            [self.navigationController pushViewController:IV animated:NO];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
        

    } Failure:^(NSError *error) {
        
    }];
}
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImageStr;
}
@end
