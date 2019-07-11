//
//  DYNetWork.m
//  dayikeji
//
//  Created by Fukai on 2018/10/10.
//  Copyright © 2018年 李明. All rights reserved.
//

#import "DYNetWork.h"
//#import "DYLoginManager.h"

@implementation DYNetWork

#pragma mark -- code --

+ (void)sendCodeParamers:(NSDictionary *)dic
                   class:(Class)modelClass
          successhandler:(successHandler)success
                   error:(errorHandler)handlererror
                    fail:(failHandler)failHandler{
    [self postNetWorking:@"user/sendCode" paramers:dic class:modelClass successhandler:success error:handlererror fail:failHandler];
}

#pragma mark saas

//get请求回来的参数
+ (void)getNetWorking:(NSString *)strUrl
             paramers:(id)paramers
                class:(Class)modelClass
       successhandler:(successHandler)success
                error:(errorHandler)handlererror
                 fail:(failHandler)failHandler{
    NSString * url = [NSString stringWithFormat:@"%@/%@",[self sever_address],strUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];

    [manager GET:url parameters:paramers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id model = [modelClass yy_modelWithJSON:responseObject];
        DYBaseModel * baseModel = (DYBaseModel *)model;
        if (!model) {
            if(handlererror)
            {
                handlererror(@{});
            }
            return;
        }
        @try {
            if (baseModel.success) {
                if (success) {
                    success(model);
                }
            }else{
                if(handlererror)
                {
                    handlererror(model);
                }
            }
        } @catch (NSException *exception) {
            if(handlererror)
            {
                handlererror(@{@"message":[NSString stringWithFormat:@"解析错误:%@ %@",exception.name,exception.reason]});
            }
        } @finally {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        
        NSInteger statusCode = response.statusCode;
        if (statusCode == 401) {
            [self statusCode_401];
        }else{
            if (failHandler) {
                failHandler(error);
            }
        }
    }];
}

+ (void)postJSONNetWorking:(NSString *)strUrl
                  paramers:(id)paramers
                     class:(Class)modelClass
            successhandler:(successHandler)success
                     error:(errorHandler)handlererror
                      fail:(failHandler)failHandler{
    [self postNetWorking:strUrl paramers:paramers class:modelClass successhandler:success error:handlererror fail:failHandler isUploadJason:YES];
}

+ (void)postNetWorking:(NSString *)strUrl
              paramers:(id)paramers
                 class:(Class)modelClass
        successhandler:(successHandler)success
                 error:(errorHandler)handlererror
                  fail:(failHandler)failHandler{
    [self postNetWorking:strUrl paramers:paramers class:modelClass successhandler:success error:handlererror fail:failHandler isUploadJason:NO];
}

//post请求
+ (void)postNetWorking:(NSString *)strUrl
              paramers:(id)paramers
                 class:(Class)modelClass
        successhandler:(successHandler)success
                 error:(errorHandler)handlererror
                  fail:(failHandler)failHandler
         isUploadJason:(BOOL)jason{
    NSString * url = [NSString stringWithFormat:@"%@/%@",[self sever_address],strUrl];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (jason) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else{
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];

    [manager POST:url parameters:paramers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id model = [modelClass yy_modelWithJSON:responseObject];
        DYBaseModel * baseModel = (DYBaseModel *)model;
        if (!model) {
            if(handlererror)
            {
                handlererror(@{});
            }
            return;
        }
        @try {
            if (baseModel.success) {
                if (success) {
                    success(model);
                }
            }else{
                if(handlererror)
                {
                    handlererror(model);
                }
            }
        } @catch (NSException *exception) {
            if(handlererror)
            {
                handlererror(@{@"message":[NSString stringWithFormat:@"解析错误:%@ %@",exception.name,exception.reason]});
            }
        } @finally {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];

        NSInteger statusCode = response.statusCode;
        
        if (statusCode == 401) {
            [self statusCode_401];
        }else{
            if (failHandler) {
                failHandler(error);
            }
        }
    }];
}

+ (void)uploadFileCheckFaceImage:(UIImage *)tempImage
                         success:(successHandler)success
                           error:(errorHandler)handlererror
                            fail:(failHandler)failHandler{
    [self dyUploadImageWithPath:@"upload/uploadFileCheckFace" tempImage:tempImage class:NSClassFromString(@"DYImageFileModel") success:success error:handlererror fail:failHandler];
}

+ (void)mineImageUpload:(UIImage *)tempImage
                success:(successHandler)success
                  error:(errorHandler)handlererror
                   fail:(failHandler)failHandler{
    [self dyUploadImageWithPath:@"upload/uploadFile" tempImage:tempImage class:NSClassFromString(@"DYImageFileModel") success:success error:handlererror fail:failHandler];
}

+ (void)dyUploadImageWithPath:(NSString *)path
                    tempImage:(UIImage *)tempImage
                        class:(Class)modelClass
                      success:(successHandler)success
                        error:(errorHandler)handlererror
                         fail:(failHandler)failHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];
    [manager POST:[NSString stringWithFormat:@"%@/%@",[self sever_address],path] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.3);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id model = [modelClass yy_modelWithJSON:responseObject];
        DYBaseModel * baseModel = (DYBaseModel *)model;
        if (!model) {
            if(handlererror)
            {
                handlererror(@{});
            }
            return;
        }
        @try {
            if (baseModel.success) {
                if (success) {
                    success(model);
                }
            }else{
                if(handlererror)
                {
                    handlererror(model);
                }
            }
        } @catch (NSException *exception) {
            if(handlererror)
            {
                handlererror(@{@"message":[NSString stringWithFormat:@"解析错误:%@ %@",exception.name,exception.reason]});
            }
        } @finally {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        
        NSInteger statusCode = response.statusCode;
        
        if (statusCode == 401) {
            [self statusCode_401];
        }else{
            if (failHandler) {
                failHandler(error);
            }
        }
    }];
}

+ (NSString *)sever_address{
    return @"";
}

+ (void)statusCode_401{
    
}

@end
