//
//  SZHTTPSessionManager.m
//  SZAFNetworkingExtensionExample
//
//  Created by Song Zhou on 5/14/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

#import "SZHTTPSessionManager.h"

@implementation SZHTTPSessionManager

- (void)handleResponse:(id)responseObject task:(NSURLSessionDataTask *)task success:(SZNetworkSuccess)success failure:(SZNetworkFail)failure {
    
    // only allow `Array` or `Dictionary` responseObject
    if (![responseObject isKindOfClass:[NSArray class]] && ![responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSError *error = [NSError errorWithDomain:@"example domain" code:0 userInfo:@{@"info": @"not valid response"}];
        failure(task, error);
        
        return;
    }
    
    // check custom defined error entry
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *response = responseObject;
        
        NSNumber *errorCode = [response objectForKey:@"error"];
        if (errorCode) {
            NSError *error;
            if (errorCode.integerValue <= 5) { // not serious error, can retry
                error = [NSError errorWithDomain:@"example domain" code:errorCode.integerValue userInfo:@{@"info": @"needs retry"}];
            } else { // serious error
                error = [NSError errorWithDomain:@"example domain" code:errorCode.integerValue userInfo:@{@"info": @"response contains error"}];
            }
            
            failure(task, error);
            return;
            
        }
    }
    
    // everything is OK
    success(task, responseObject);
}

- (BOOL)needsRetryWithTask:(NSURLSessionDataTask *)task error:(NSError *)error {
    if (error.code <= 5) {
        return YES;
    }
    
    return NO;
}
@end
