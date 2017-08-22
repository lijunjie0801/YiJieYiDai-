//
//  DTCustomeWebViewController.m
//  YiJieYiDai
//
//  Created by lijunjie on 2017/6/8.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "DTCustomeWebViewController.h"
#import "MustIdentifyViewController.h"

@interface DTCustomeWebViewController ()<BackBtnDelegate,UIWebViewDelegate,WebViewJSDelegate>
@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) UINavigationItem * navigationBarTitle;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic, strong)UIImageView *navBarHairlineImageView;

@end

@implementation DTCustomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    [ZZLProgressHUD showHUDWithMessage:@"正在加载"];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height)];
    _webview=webview;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    webview.scalesPageToFit = YES;
    webview.backgroundColor = [UIColor whiteColor];
    NSURL *url=[NSURL URLWithString:self.webUrl];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    webview.allowsInlineMediaPlayback = YES;
    webview.mediaPlaybackRequiresUserAction = NO;
    webview.delegate=self;
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;
    [self.view addSubview:webview];
    _navBarHairlineImageView= [self findHairlineImageViewUnder:self.navigationController.navigationBar];

}
- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        } 
    } 
    return nil; 
}
-(void)viewWillAppear:(BOOL)animated{
    _navBarHairlineImageView.hidden=YES;
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [ZZLProgressHUD popHUD];
}
-(void)tobibeirenzJS{
    MustIdentifyViewController *MC=[[MustIdentifyViewController alloc]init];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:MC];
    [self presentViewController:nav_third animated:NO completion:nil];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ZZLProgressHUD popHUD];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;
}
-(void)goback{
    if ([self.webview canGoBack]) {
        if([self.title isEqualToString:@"芝麻信用"]){
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.delegate twoback];
//           [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        }else{
            [self.webview goBack];
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(void)liuyanJS{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)loanapplyJS{
//    MustIdentifyViewController *MC=[[MustIdentifyViewController alloc]init];
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:MC];
//    [self presentViewController:nav_third animated:NO completion:nil];
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];
        [LRNotificationCenter postNotificationName:@"tome" object:nil];

}
-(void)indexJS{
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)userCenterJS{
    [self.delegate homeRefresh];
   [self dismissViewControllerAnimated:NO completion:nil];
    [JRToast showWithText:@"提交个人资料成功" duration:1.0];
}
-(void)kefuJS{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    // 提供uin, 你所要联系人的QQ号码
    NSString *qqstr = @"mqqwpa://im/chat?chat_type=crm&uin=938182955&version=1&src_type=web&web_src=http:://yjydhk.zilankeji.com";
    NSURL *url = [NSURL URLWithString:qqstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];

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
