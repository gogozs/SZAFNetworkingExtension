//
//  AFHTTPSessionManager+SZExtension.h
//  SZAFNetworkingExtensionExample
//
//  Created by Song Zhou on 5/14/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SZNetworkDownlaodProgress)(NSProgress *downloadProgress);
typedef void (^SZNetworkSuccess)(NSURLSessionDataTask *task, id _Nullable responseObject);
typedef void (^SZNetworkFail)(NSURLSessionDataTask * _Nullable task, NSError *error);


@interface AFHTTPSessionManager (SZExtension)

/// ----------------
/// @ handle error
/// ----------------

/**
 * wrapper around AFNetworking `GET` request
 *
 * handle error in response within `success` block
 */
- (nullable NSURLSessionDataTask *)SZGET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable SZNetworkDownlaodProgress)downloadProgress
                               success:(nullable SZNetworkSuccess)success
                               failure:(nullable SZNetworkFail)failure;


/**
 * handle response from server
 *
 * even http status code == 200, still need to handle server defined error or check if `responseObject` is valid
 *
 * @note default doing nothing, needs override to do custom response error handling
 */
- (void)handleResponse:(id _Nullable)responseObject task:(NSURLSessionDataTask * _Nonnull)task success:(nullable SZNetworkSuccess)success failure:(nullable SZNetworkFail)failure;

/// ----------------
/// @ retry
/// ----------------

- (nullable NSURLSessionDataTask *)SZGET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable SZNetworkDownlaodProgress)downloadProgress
                               success:(nullable SZNetworkSuccess)success
                               failure:(nullable SZNetworkFail)failure
                                 retryCount:(NSUInteger)retryCount;

/**
 * @notes needs override, default return `NO`
 */
- (BOOL)needsRetryWithTask:(NSURLSessionDataTask * _Nullable)task  error:(NSError * _Nonnull)error;
@end


NS_ASSUME_NONNULL_END
