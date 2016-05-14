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
        if ([response objectForKey:@"error"]) { // or other custom error response entry
            
            NSError *error = [NSError errorWithDomain:@"example domain" code:0 userInfo:@{@"info": @"response contains error"}];
            failure(task, error);
            
            return;
        }
    }
    
    // everything is OK
    success(task, responseObject);
}

@end
