//
//  MMomentDatamanager.m
//  Timeline
//
//  Created by Jim on 2019/4/11.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MMomentDatamanager.h"
#import "MAPIAdapter.h"

#define USERINFO_URL          @"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets"


static MMomentDatamanager *momentDatamanager = nil;

@implementation MMomentDatamanager

+ (instancetype)sharedKit
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        momentDatamanager = [[MMomentDatamanager alloc] init];
    });
    return momentDatamanager;
}

- (instancetype)init
{
    self = [super init];
    if (self){
        _momentArray = [[NSMutableArray alloc] init];

    }
    return self;
}

-(void)getALLMomentData:(id)object completion:(void (^)(NSError* error))completion
{
    __weak MMomentDatamanager *weakSelf = self;
    [[MAPIAdapter sharedKit] loadUserDataFromURL: weakSelf
                                         withURL: USERINFO_URL
                                      completion:^(id resultObject, NSError *error)
     {
         if (error == nil && resultObject != nil)
         {
             NSArray *resultArray = (NSArray *)resultObject;
             for(int i=0; i < [resultArray count]; i++)
             {
                 NSLog(@"resultObject = %@", resultObject);
                 
                 MMoment *moment = [[MMoment alloc] init: [resultArray objectAtIndex:i]];
                 if(moment != NULL)
                     [weakSelf.momentArray addObject:moment];
             }
             NSLog(@"weakSelf.momentArray = %ld",[weakSelf.momentArray count]);
         }
         else
         {
             NSLog(@"Retrieve data error");
         }
         completion(error);
     }];
}

- (NSArray *)getMomentList:(int)mementIndex pageNumber:(int)num
{
    NSMutableArray * tempMomentList = [[NSMutableArray alloc] init];
    if(mementIndex + num > [_momentArray count]) // 如果讀取頁數 > 取得
        num = (int)[_momentArray count] - mementIndex;
    
    for(int i = 0; i< num; i++)
    {
        [tempMomentList addObject: [_momentArray objectAtIndex:mementIndex + i]];
    }
    return tempMomentList;

}

@end
