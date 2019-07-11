//
//  DYNetWork.h
//  dayikeji
//
//  Created by Fukai on 2018/10/10.
//  Copyright © 2018年 李明. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ __nullable successHandler)(id _Nullable data);
typedef void(^ __nullable errorHandler)(id _Nullable data);
typedef void(^ __nullable failHandler)(id _Nullable error);

@interface DYNetWork : NSObject

/**
 扩展 重写
 */
+ (void)statusCode_401;
/**
 扩展 重写 获取网络请求地址
 */
+ (NSString *_Nullable)sever_address;

/**
 登录/忘记密码获取验证码

 inletType    是    String    C
 phone    否    String    手机号
 codeType    否    int    1
 */
+ (void)sendCodeParamers:(NSDictionary *_Nullable)dic
                   class:(Class _Nonnull)modelClass
          successhandler:(successHandler)success
                   error:(errorHandler)handlererror
                    fail:(failHandler)failHandler;

/**
 get请求
 
 @param strUrl 请求地址
 @param paramers 请求参数
 @param success 成功返回
 @param handlererror 网络请求成功但是数据有错误的情况
 @param failHandler 网络失败
 */
+ (void)getNetWorking:(NSString *_Nonnull)strUrl
             paramers:(id _Nullable )paramers
                class:(Class _Nonnull )modelClass
       successhandler:(successHandler)success
                error:(errorHandler)handlererror
                 fail:(failHandler)failHandler;


/**
 post请求
 
 @param strUrl 请求地址
 @param paramers 请求参数
 @param success 成功返回
 @param handlererror 网络请求成功但是数据有错误的情况
 @param failHandler 网络失败
 */
+ (void)postNetWorking:(NSString *_Nonnull)strUrl
              paramers:(id _Nullable )paramers
                 class:(Class _Nonnull)modelClass
        successhandler:(successHandler)success
                 error:(errorHandler)handlererror
                  fail:(failHandler)failHandler
         isUploadJason:(BOOL)jason;

+ (void)postJSONNetWorking:(NSString * _Nonnull)strUrl
                  paramers:(id _Nullable)paramers
                     class:(Class _Nonnull)modelClass
            successhandler:(successHandler)success
                     error:(errorHandler)handlererror
                      fail:(failHandler)failHandler;

+ (void)postNetWorking:(NSString * _Nonnull)strUrl
              paramers:(id _Nullable)paramers
                 class:(Class _Nonnull)modelClass
        successhandler:(successHandler)success
                 error:(errorHandler)handlererror
                  fail:(failHandler)failHandler;

+ (void)dyUploadImageWithPath:(NSString * _Nonnull)path
                    tempImage:(UIImage * _Nullable)tempImage
                        class:(Class _Nonnull)modelClass
                      success:(successHandler)success
                        error:(errorHandler)handlererror
                         fail:(failHandler)failHandler;

/**
 图片上传

 @param tempImage 图片
 */
+ (void)mineImageUpload:(UIImage * _Nonnull)tempImage
                success:(successHandler)success
                  error:(errorHandler)handlererror
                   fail:(failHandler)failHandler;

/**
 上传脸部图片

 @param tempImage image
 */
+ (void)uploadFileCheckFaceImage:(UIImage * _Nonnull)tempImage
                         success:(successHandler)success
                           error:(errorHandler)handlererror
                            fail:(failHandler)failHandler;
@end
