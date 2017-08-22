//
//  HttpManagerPort.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "HttpManagerPort.h"
#import "ZZLProgressHUD.h"
#import "HttpManagers.h"
@implementation HttpManagerPort
DEFINE_SINGLETON_FOR_CLASS(HttpManagerPort)


/**获取验证码**/
-(void)getVerficode:(NSString *)mobile type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/sendCode",kUrl] parameters:@{@"userPhone":mobile,@"type":type} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}
/**注册**/
-(void)getRegistcode:(NSString *)mobile password:(NSString *)password code:(NSString *)code basecode:(NSString *)basecode deviceId:(NSString *)deviceId Success:(void (^)(id))success Failure:(void (^)(NSError *))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/userReg",kUrl] parameters:@{@"userPhone":mobile,@"userPwd":password,@"code":code,@"sendCode":basecode,@"deviceId":deviceId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

/**登录**/
-(void)getLogin:(NSString *)mobile password:(NSString *)password deviceId:(NSString *)deviceId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/nameLogin",kUrl] parameters:@{@"userPhone":mobile,@"userPwd":password,@"deviceId":deviceId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**退出登录**/
-(void)getLogout:(NSString *)appKey Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/loginOut",kUrl] parameters:@{@"appKey":appKey} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**忘记密码**/
-(void)forgetPassword:(NSString *)userPhone code:(NSString *)code userPwd:(NSString *)userPwd sendCode:(NSString *)sendCode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/user/changePwd",kUrl] parameters:@{@"userPhone":userPhone,@"code":code,@"userPwd":userPwd,@"sendCode":sendCode} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**修改密码**/
-(void)changePassword:(NSString *)userid oldPass:(NSString *)oldPass  newPass:(NSString *)newPass Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/userCenter/changeUserPwd",kUrl] parameters:@{@"appKey":userid,@"oldPwd":oldPass,@"newPwd":newPass} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
/**获取首页数据**/
-(void)getHomeData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/index/index",kUrl] parameters:@{@"appKey":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**获取个人信息数据**/
-(void)getUserIndexData:(NSString *)appKey Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/userCenter/index",kUrl] parameters:@{@"appKey":appKey} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}




/**上传头像**/
-(void)changeUserIcon:(NSString *)userId headcode:(NSString *)headcode Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/userCenter/changeUserImg",kUrl] parameters:@{@"appKey":userId,@"headBase64":headcode} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**获取是否认证数据**/
-(void)getIsIdentifyData:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/index",kUrl] parameters:@{@"appKey":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
/**社交认证**/
-(void)toSocialauth:(NSString *)userId realname1:(NSString *)realname1 mobile1:(NSString *)mobile1 relation1:(NSString *)relation1 realname2:(NSString *)realname2 mobile2:(NSString *)mobile2 relation2:(NSString *)relation2  phonelist:(NSString *)phonelist qq:(NSString *)qq weixin:(NSString *)weixin Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/socialRealCheck",kUrl] parameters:@{@"appKey":userId,@"realName1":realname1,@"realPhone1":mobile1,@"relation1":relation1,@"realName2":realname2,@"realPhone2":mobile2,@"relation2":relation2,@"phoneList":phonelist,@"userQq":qq,@"userWeixin":weixin} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**手机认证**/
-(void)toPhoneIdentify:(NSString *)userId Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/phoneReal",kUrl] parameters:@{@"appKey":userId} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**提交手机认证**/
-(void)submitPhoneIdentify:(NSString *)userId userName:(NSString *)userName userCard:(NSString *)userCard operatorPwd:(NSString *)operatorPwd Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/phoneRealCheck",kUrl] parameters:@{@"appKey":userId,@"operatorPwd":operatorPwd,@"userCard":userCard,@"userName":userName} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**借贷宝认证**/
-(void)toJiedaibaoIdentify:(NSString *)userId img_wallet:(NSString *)img_wallet img_hkjilu:(NSString *)img_hkjilu img_jhkuan:(NSString *)img_jhkuan debitType:(NSString *)debitType Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/debitRealCheck",kUrl] parameters:@{@"appKey":userId,@"imgUrl1":img_wallet,@"imgUrl2":img_hkjilu,@"imgUrl3":img_jhkuan,@"debitType":debitType} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**借贷宝认证**/
/**身份证认证**/
-(void)toshenfenIdentify:(NSString *)userId img_front:(NSString *)img_front img_back:(NSString *)img_back  img_hand:(NSString *)img_hand Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/cardRealCheck",kUrl] parameters:@{@"appKey":userId,@"imgUrl1":img_front,@"imgUrl2":img_back,@"imgUrl3":img_hand} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**支付宝认证**/
-(void)submitZhifubaoIdentify:(NSString *)userId aliPayName:(NSString *)aliPayName aliPayPwd:(NSString *)aliPayPwd Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/alipayRealCheck",kUrl] parameters:@{@"appKey":userId,@"aliPayName":aliPayName,@"aliPayPwd":aliPayPwd} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**借贷宝认证上传图片**/
-(void)jiedaibaoIdentifyUpLoad:(NSString *)userId jiedaibao:(NSString *)jiedaibao Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    NSLog(@"appKey:%@ ------------------  headBase64:%@",userId,jiedaibao);
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/index/uploadImage",kUrl] parameters:@{@"appKey":userId,@"headBase64":jiedaibao} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**芝麻认证**/
-(void)toZhiMaIdentify:(NSString *)userId truename:(NSString *)truename idcard:(NSString *)idcard  Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api.php/apply/zhimaRealCheck",kUrl] parameters:@{@"appKey":userId,@"userRealName":truename,@"userCard":idcard} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}





@end
