//
//  MUserManager.m
//  
//
//  Created by Jim on 2019/4/9.
//

#import "MUserManager.h"
#import "MAPIAdapter.h"

#define USERINFO_URL          @"http://thoughtworks-ios.herokuapp.com/user/jsmith"

static MUserManager *myUserManager = nil;


@implementation MUserManager


+ (instancetype)sharedKit
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myUserManager = [[MUserManager alloc] init];
    });
    return myUserManager;
}

- (instancetype)init
{
    self = [super init];
    if (self){
    }
    return self;
}

- (void)getUserdata:(id)object
         completion:(void (^)(NSError* error))completion
{
    __weak MUserManager *weakSelf = self;
    [[MAPIAdapter sharedKit] loadUserDataFromURL: weakSelf
                                         withURL: USERINFO_URL
                                      completion:^(id resultObject, NSError *error)
     {
         if (error == nil && resultObject != nil)
         {
             //NSLog(@"resultObject = %@", resultObject);
             NSDictionary *dictionary = (NSDictionary *)resultObject;
             weakSelf.adminUser = [[MUser alloc] init:dictionary];
         }
         else
         {
             NSLog(@"Retrieve data error");
         }
         completion(error);
     }];
}


@end
