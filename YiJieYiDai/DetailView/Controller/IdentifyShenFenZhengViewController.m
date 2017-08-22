//
//  IdentifyShenFenZhengViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/6.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "IdentifyShenFenZhengViewController.h"
#import "XDAlertController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "IdentifySuccessViewController.h"
@interface IdentifyShenFenZhengViewController ()<UITableViewDelegate,UITableViewDataSource,BackBtnDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,successDelegate>{
    NSInteger _count;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *image1;
@property(nonatomic,strong)NSString *image2;
@property(nonatomic,strong)NSString *image3;
@end

@implementation IdentifyShenFenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rdv_tabBarController setTabBarHidden:YES];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.title=@"身份证认证";
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    self.view =_tableView;

}
-(void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)goback{
    if ([self.backType integerValue]==1) {
         [self.navigationController popViewControllerAnimated:NO];
    }else{
        [self.delegate ThirdRefresh];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
   
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((kScreen_Width-40)*0.5+20)*3+300;
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
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, ((kScreen_Width-40)*0.5+20)*3+60)];
    topView.backgroundColor=[UIColor whiteColor];
    
    UILabel *topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 20, 200, 20)];
    topLab.text=@"请用相机拍照上传";
    topLab.textColor=[UIColor grayColor];
    [topView addSubview:topLab];
    for (int i=0; i<3; i++) {
        UIButton *imageview=[[UIButton alloc]initWithFrame:CGRectMake(20, 60+((kScreen_Width-40)*0.5+20)*i, kScreen_Width-40, (kScreen_Width-40)*0.5)];
        imageview.selected=NO;
        imageview.tag=100+i;
        imageview.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired=1;
        [imageview addGestureRecognizer:singleTap];
        //imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"SFZ%d",i]];
        [imageview setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"SFZ%d",i]] forState:UIControlStateNormal];
        [topView addSubview:imageview];
    }
    return topView;
}
-(void)singleTap:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    _count=[singleTap view].tag;
    NSLog(@"%ld",_count);
    [self changeIcon];
}
-(void)changeIcon{
    if (![DEFAULTS objectForKey:@"userId"]) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
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
- (void)saveImage:(UIImage *)image {
    UIButton *shenfenzhen=[self.view viewWithTag:_count];
    [shenfenzhen setBackgroundImage:image forState:UIControlStateNormal];
    shenfenzhen.selected=YES;
    NSString *baseStr=[self UIImageToBase64Str:image];
    [ZZLProgressHUD showHUDWithMessage:@"正在上传"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [kNetManager jiedaibaoIdentifyUpLoad:[DEFAULTS objectForKey:@"userId"] jiedaibao:baseStr Success:^(id responseObject) {
        NSLog(@"上传图片????%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            [ZZLProgressHUD popHUD];
            NSString *imgStr=responseObject[@"datas"][@"changeUserImg"][@"smallImg"];
            if (_count==100) {
                self.image1=imgStr;
                NSLog(@"上传图片image1:%ld-----%@",_count,self.image1);
            }else if (_count==101){
                self.image2=imgStr;
                NSLog(@"上传图片image2:%ld-----%@",_count,self.image2);
            }else if (_count==102){
                self.image3=imgStr;
                NSLog(@"上传图片image3:%ld-----%@",_count,self.image3);
            }
        }else{
            [ZZLProgressHUD popHUD];
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }
        
    } Failure:^(NSError *error) {
        
    }];
//    [kNetManager shenfenIdentifyUpLoad:[DEFAULTS objectForKey:@"userId"] type:[NSString stringWithFormat:@"%ld",_count-100+1] idcardimg:baseStr Success:^(id responseObject) {
//         NSLog(@"上传图片????%@",responseObject);
//        if ([responseObject[@"result"] integerValue]==100) {
//            [ZZLProgressHUD popHUD];
//            
//            if (_count==100) {
//                self.image1=responseObject[@"img_front"];
//                 NSLog(@"上传图片image1:%ld-----%@",_count,self.image1);
//            }else if (_count==101){
//               
//                self.image2=responseObject[@"img_back"];
//                  NSLog(@"上传图片image2:%ld-----%@",_count,self.image2);
//            }else if (_count==102){
//                self.image3=responseObject[@"img_hand"];
//                 NSLog(@"上传图片image3:%ld-----%@",_count,self.image3);
//            }
//        }
//    } Failure:^(NSError *error) {
//        
//    }];
    NSLog(@"dic:%@",dic);
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
-(UIView *)bottemView{
    UIView *bottemView=[[UIView alloc]initWithFrame:CGRectMake(0, ((kScreen_Width-40)*0.5+20)*3+80, kScreen_Width, 220)];
    bottemView.backgroundColor=[UIColor whiteColor];

    UILabel *bottomLab1=[[UILabel alloc]init];
    [bottemView addSubview:bottomLab1];
    bottomLab1.text=@"温馨提示";
    bottomLab1.font=[UIFont systemFontOfSize:14];
    bottomLab1.textColor=[UIColor grayColor];
    [bottomLab1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [bottomLab1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [bottomLab1 autoSetDimensionsToSize:CGSizeMake(100, 20)];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font=[UIFont systemFontOfSize:14];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"1、拍摄身份证照片务必区分人相面，国徽面"];
    textLabel.textColor = [UIColor grayColor];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0xfe8644"] range:NSMakeRange(13, 3)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0xfe8644"] range:NSMakeRange(17, 3)];
    textLabel.attributedText = AttributedStr;
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreen_Width-60, 9999);
    [bottemView addSubview:textLabel];
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [textLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [textLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:bottomLab1 withOffset:5];
    [textLabel autoSetDimension:ALDimensionHeight toSize:expectSize.height];

    UILabel *textLabel1 = [[UILabel alloc] init];
    textLabel1.font=[UIFont systemFontOfSize:14];
    NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:@"2、手持身份证照片须本人、清晰且完整"];
    textLabel1.textColor = [UIColor grayColor];
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0xfe8644"] range:NSMakeRange(10, 2)];
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0xfe8644"] range:NSMakeRange(13, 2)];
     [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0xfe8644"] range:NSMakeRange(16, 2)];
    textLabel1.attributedText = AttributedStr1;
    textLabel1.numberOfLines = 0;
    textLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize1 = CGSizeMake(kScreen_Width-60, 9999);
    [bottemView addSubview:textLabel1];
    CGSize expectSize1 = [textLabel1 sizeThatFits:maximumLabelSize1];
    [textLabel1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [textLabel1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [textLabel1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textLabel withOffset:5];
    [textLabel1 autoSetDimension:ALDimensionHeight toSize:expectSize.height];

    UIButton *submitBtn = [[UIButton alloc]init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 6.0;
    [submitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor colorWithHexString:@"0x4481fe"]];
    [bottemView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn autoSetDimension:ALDimensionHeight toSize:40];
    [submitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [submitBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [submitBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textLabel1 withOffset:50];
    return bottemView;
}
-(void)submit{
    UIButton *btn1=[self.view viewWithTag:100];
    UIButton *btn2=[self.view viewWithTag:101];
    UIButton *btn3=[self.view viewWithTag:102];
    if (btn1.selected==YES&&btn2.selected==YES&&btn3.selected==YES) {
       // showAlert(@"成功");
    }else{
        showAlert(@"请拍照上传");
        return;
    }

    NSLog(@"%@---%@--%@",_image1,_image2,_image3);

    [kNetManager toshenfenIdentify:[DEFAULTS objectForKey:@"userId"] img_front:self.image1 img_back:self.image2 img_hand:self.image3 Success:^(id responseObject) {
        NSLog(@"身份证认证提交%@",responseObject);
        if ([responseObject[@"status"] intValue]==100) {
            //[ZZLProgressHUD popHUD];
            IdentifySuccessViewController *IV=[[IdentifySuccessViewController alloc]init];
            IV.type=self.backType;
            IV.delegate=self;
            [self.navigationController pushViewController:IV animated:NO];
        }else{
            [JRToast showWithText:responseObject[@"msgs"] duration:1.0];
        }

    } Failure:^(NSError *error) {
        
    }];
    

  }
-(void)backMe{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImageStr;
}

@end
