#SZAFNetworkingExtension

prove of concept of adding category on AFNetworking, provide 'retry' and 'unify
failure control flow' features.

## problem I met

### 'failure' response from Server
response status code is `200`, which means request successful. But response from
server tells me something is wrong(by including `error` entry in JSON). So I
need mark above case as `failure`.

### retry
programming with Network is not reliable, retry is neccessary.

## Features

### unify failure control flow
all failure request from Server, including `error` entry in JSON will let code
jump into `failure block`.

### retry
provide retry machanism.

## Usage

- add category in your project
- subclass `AFHTTPSessionManager`

### unify failure control flow
call

``` 
- (nullable NSURLSessionDataTask *)SZGET:(NSString *)URLString 
                              parameters:(nullable id)parameters 
                                progress:(nullable SZNetworkDownlaodProgress)downloadProgress 
                                 success:(nullable SZNetworkSuccess)success 
                                 failure:(nullable SZNetworkFail)failure;
```

and `override` 

```
- (void)handleResponse:(id _Nullable)responseObject 
                  task:(NSURLSessionDataTask * _Nonnull)task 
               success:(nullable SZNetworkSuccess)success 
               failure:(nullable SZNetworkFail)failure;
```
to implement custom error handling logic

### retry

call

```
- (nullable NSURLSessionDataTask *)SZGET:(NSString *)URLString
                              parameters:(nullable id)parameters
                                progress:(nullable SZNetworkDownlaodProgress)downloadProgress
                                success:(nullable SZNetworkSuccess)success
                                failure:(nullable SZNetworkFail)failure
                            retryCount:(NSUInteger)retryCount;
```

and `override`

```
- (BOOL)needsRetryWithTask:(NSURLSessionDataTask * _Nullable)task
                     error:(NSError * _Nonnull)error;
```

to determite which case needs retry

## drawback
- only support `GET` request, pull request welcome
