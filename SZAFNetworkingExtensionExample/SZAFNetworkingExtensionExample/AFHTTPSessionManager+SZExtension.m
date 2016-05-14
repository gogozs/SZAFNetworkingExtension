//
//  AFHTTPSessionManager+SZExtension.m
//  SZAFNetworkingExtensionExample
//
//  Created by Song Zhou on 5/14/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

#import "AFHTTPSessionManager+SZExtension.h"

@implementation AFHTTPSessionManager (SZExtension)

- (nullable NSURLSessionDataTask *)SZGET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable SZNetworkDownlaodProgress)downloadProgress
                               success:(nullable SZNetworkSuccess)success
                               failure:(nullable SZNetworkFail)failure {
    
    return [self GET:URLString
                     parameters:parameters
                       progress:downloadProgress
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            [self handleResponse:responseObject task:task success:success failure:failure];
                            
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            failure(task, error);
                        }];
}

- (void)handleResponse:(id _Nullable)responseObject task:(NSURLSessionDataTask * _Nonnull)task success:(nullable SZNetworkSuccess)success failure:(nullable SZNetworkFail)failure {
    success(task, responseObject);
}
@end
