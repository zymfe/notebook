//
//  YMRegionListApi.m
//  SingleViewApp
//
//  Created by 赵一鸣 on 2019/11/10.
//  Copyright © 2019 zhaoyiming. All rights reserved.
//

#import "YMRegionApi.h"
#import <AFNetworking.h>
#import "YMRegionItem.h"

@implementation YMRegionApi

- (void)getRegionList {
    NSString *urlString = @"https://api.0351zhuangxiu.com/tour/region/list?a=1&b=2";
    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSArray *dataArray = [result objectForKey:@"data"];
        NSLog(@"dataArray: %@", dataArray);
        NSMutableArray *RegionMutableArray = @[].mutableCopy;
        for (int i = 0; i < dataArray.count; i++) {
            [RegionMutableArray addObject:dataArray[i]];
        }
        NSLog(@"RegionMutableArray: %@", RegionMutableArray);
    }];

    [dataTask resume];
}

//- (void) getRegionList {
//    NSString *urlString = @"https://api.0351zhuangxiu.com/tour/region/list?a=1&b=2";
//    [[AFHTTPSessionManager manager] GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"response: %@", responseObject[@"data"][0][@"region_name"]);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
//}

@end
    
