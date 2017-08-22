//
//  CYRootTabViewController.m
//  IOSFramework
//
//  Created by xu on 16/3/14.
//
//

#import "CYRootTabViewController.h"
#import "RDVTabBarItem.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "DTCustomeWebViewController.h"
@interface CYRootTabViewController ()

@end

@implementation CYRootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    
    [self customizeTabBarForController];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toSencondCtr:) name:@"toSencondCtr" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toThirdCtr:) name:@"toThirdCtr" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toMe) name:@"tome" object:nil];

}
-(void)toMe{
    self.selectedIndex=2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)toSencondCtr:(NSNotification *)notifi{
    self.selectedIndex=1;
}
-(void)toThirdCtr:(NSNotification *)notifi{
    self.selectedIndex=3;
}
- (void)toSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点了底下第几个%ld",index);
}
- (void)setupViewControllers {
    
    FirstViewController *firstCtr = [[FirstViewController alloc] init];
   
    UINavigationController *nav_First = [[UINavigationController alloc] initWithRootViewController:firstCtr];
    
    SecondViewController *secondCtr = [[SecondViewController alloc] init];
    UINavigationController *nav_second = [[UINavigationController alloc] initWithRootViewController:secondCtr];
    
    
    ThirdViewController *thirdCtr = [[ThirdViewController alloc] init];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:thirdCtr];
    
    [self setViewControllers:@[nav_First, nav_second, nav_third ]];
    
}
//- (BOOL)tabBar:(RDVTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index{
////    NSLog(@"yuyu%ld",index);
//    if ([DEFAULTS boolForKey:@"isLogin"]!=YES) {
//        if (index==3||index==4) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//                LoginViewController *login = [[LoginViewController alloc]init];
//                CATransition * animation = [CATransition animation];
//                animation.duration = 0.5;    //  时间
//                animation.type = @"pageCurl";
//                animation.type = kCATransitionPush;
//                animation.subtype = kCATransitionFromRight;
//                
//                [self.view.window.layer addAnimation:animation forKey:nil];
//                [self presentViewController: login animated:YES completion:nil];
//            }];
//            
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            
//            [alertController addAction:okAction];
//            [alertController addAction:cancelAction];
//            
//            [self presentViewController:alertController animated:YES completion:nil];
//            return NO;
//            
//        }
//
//    }
//    
//    return YES;
//}
- (void)customizeTabBarForController {
    NSArray *tabBarItemImages = @[@"homePage", @"search", @"me"];
    NSArray *tabBarItemTitles = @[@"借款", @"认证", @"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
         item.titlePositionAdjustment = UIOffsetMake(0, 3.0);
//        item.imagePositionAdjustment=UIOffsetMake(0, 2.0);
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}


@end
