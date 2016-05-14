//
//  SZAFNetworkingExtensionExampleTests.m
//  SZAFNetworkingExtensionExampleTests
//
//  Created by Song Zhou on 5/13/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SZHTTPSessionManager.h"

static NSString *API_URL = @"http://echo.jsontest.com";
static NSString *STATUS_URL = @"http://httpstat.us";

@interface SZAFNetworkingExtensionExampleTests : XCTestCase

@property (nonatomic) NSString *responseErrorMethod;
@property (nonatomic) NSString *successMethod;
@property (nonatomic) SZHTTPSessionManager *httpClient;
@property (nonatomic) SZHTTPSessionManager *testStatusClient;

@end

@implementation SZAFNetworkingExtensionExampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _responseErrorMethod = @"error/1";
    _successMethod = @"success/1";
    
    _httpClient = [[SZHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:API_URL]];
    _testStatusClient = [[SZHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:STATUS_URL]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark -
- (void)testSuccess {
    [self caseWithGetMethod:_successMethod needsSuccess:YES];
}

- (void)testServerResponseError {
    [self caseWithGetMethod:_responseErrorMethod needsSuccess:NO];
    
}

- (void)test404 {
    [self caseWithStatusMethod:@"404" needsSuccess:NO];
}

#pragma mark -
- (void)caseWithGetMethod:(NSString *)method needsSuccess:(BOOL)needsSuccess {
    [self caseWithClient:_httpClient method:method needsSuccess:needsSuccess];
}

- (void)caseWithStatusMethod:(NSString *)method needsSuccess:(BOOL)needsSuccess {
    [self caseWithClient:_testStatusClient method:method needsSuccess:needsSuccess];
}

- (void)caseWithClient:(SZHTTPSessionManager *)client method:(NSString *)method needsSuccess:(BOOL)needsSuccess {
    XCTestExpectation *e = [self expectationWithDescription:method];
    
    [client SZGET:method
          parameters:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"success: %@", responseObject);
                 if (needsSuccess) {
                     [e fulfill];
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"fail: %@", error);
                 if (!needsSuccess) {
                     [e fulfill];
                 }
             }
     ];
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}


@end
