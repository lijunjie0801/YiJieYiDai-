//
//  HttpManagerPort.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySingleton.h"
@interface HttpManagerPort : NSObject
DEFINE_SINGLETON_FOR_HEADER(HttpManagerPort)

/**获取验证码**/
-(void)getVerficode:(NSString *)mobile type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**注册**/
-(void)getRegistcode:(NSString *)mobile password:(NSString *)password code:(NSString *)code basecode:(NSString *)basecode deviceId:(NSString *)deviceId Success:(void (^)(id))success Failure:(void (^)(NSError *))failure;
/**登录**/
-(void)getLogin:(NSString *)mobile password:(NSString *)password deviceId:(NSString *)deviceId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**退出登录**/
-(void)getLogout:(NSString *)appKey Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**忘记密码**/
-(void)forgetPassword:(NSString *)userPhone code:(NSString *)code userPwd:(NSString *)userPwd sendCode:(NSString *)sendCode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**修改密码**/
-(void)changePassword:(NSString *)userid oldPass:(NSString *)oldPass  newPass:(NSString *)newPass Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取首页数据**/
-(void)getHomeData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取个人信息数据**/
-(void)getUserIndexData:(NSString *)appKey Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**上传头像**/
-(void)changeUserIcon:(NSString *)userId headcode:(NSString *)headcode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取是否认证数据**/
-(void)getIsIdentifyData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**社交认证**/
-(void)toSocialauth:(NSString *)userId realname1:(NSString *)realname1 mobile1:(NSString *)mobile1 relation1:(NSString *)relation1 realname2:(NSString *)realname2 mobile2:(NSString *)mobile2 relation2:(NSString *)relation2  phonelist:(NSString *)phonelist qq:(NSString *)qq weixin:(NSString *)weixin Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**手机认证**/
-(void)toPhoneIdentify:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**提交手机认证**/
/**提交手机认证**/
-(void)submitPhoneIdentify:(NSString *)userId userName:(NSString *)userName userCard:(NSString *)userCard operatorPwd:(NSString *)operatorPwd Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**支付宝认证**/
-(void)submitZhifubaoIdentify:(NSString *)userId aliPayName:(NSString *)aliPayName aliPayPwd:(NSString *)aliPayPwd Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**借贷宝认证**/
/**借贷宝认证**/
-(void)toJiedaibaoIdentify:(NSString *)userId img_wallet:(NSString *)img_wallet img_hkjilu:(NSString *)img_hkjilu img_jhkuan:(NSString *)img_jhkuan debitType:(NSString *)debitType Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**借贷宝认证是否提交**/
-(void)JiedaibaoIdentifyISok:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**社交认证是否提交**/
-(void)shejiaoIdentifyISok:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**身份证认证是否提交**/
-(void)shenfenIdentifyISok:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**身份证认证**/
-(void)toshenfenIdentify:(NSString *)userId img_front:(NSString *)img_front img_back:(NSString *)img_back  img_hand:(NSString *)img_hand Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**身份证认证上传图片**/
-(void)shenfenIdentifyUpLoad:(NSString *)userId type:(NSString *)type idcardimg:(NSString *)idcardimg Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**芝麻认证**/
-(void)toZhiMaIdentify:(NSString *)userId truename:(NSString *)truename idcard:(NSString *)idcard  Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**借贷宝认证上传图片**/
-(void)jiedaibaoIdentifyUpLoad:(NSString *)userId jiedaibao:(NSString *)jiedaibao Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
- (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)())success
                             failure:(void (^)(NSError *))failure;
@end
