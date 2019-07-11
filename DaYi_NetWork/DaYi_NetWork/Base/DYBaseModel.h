//
//  DYBaseModel.h
//  DaYi_JRXB
//
//  Created by Fukai on 2018/12/25.
//  Copyright © 2018 FuKai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYBaseModel : NSObject

@property (nonatomic , assign)BOOL success;
@property (nonatomic , assign)BOOL autoPrompt;
@property (nonatomic , strong)NSString * message;
@property (nonatomic , strong)NSString * errCode;

@end

NS_ASSUME_NONNULL_END
