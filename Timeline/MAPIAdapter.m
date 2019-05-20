//
//  MAPIAdapter.m
//  Timeline
//
//  Created by Jim on 2019/4/9.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MAPIAdapter.h"

static MAPIAdapter *myAPIdapter = nil;


@implementation MAPIAdapter


+ (instancetype)sharedKit
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myAPIdapter = [[MAPIAdapter alloc] init];
    });
    return myAPIdapter;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
       
    }
    return self;
}

- (void)loadUserDataFromURL:(NSString *)htmlPath withURL: urlString  completion:(void (^)(id resultObject, NSError *error))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *htmlString = nil;
        NSError *error = nil;
        id resultObject = nil;
        
        NSURL *url = [NSURL URLWithString:urlString];
        htmlString = [NSString stringWithContentsOfURL:url
                                              encoding:NSUTF8StringEncoding
                                                 error:&error];
        
        if (error == nil && htmlString)
        {
            NSData * data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
            resultObject = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:&error];
            //NSLog(@"Load HTML from [%@]", resultObject);
        }
        else
        {
            NSLog(@"Load HTML from [%@] error:\n%@", htmlPath, [error description]);
        }
        completion(resultObject,error);
    });
}


@end
