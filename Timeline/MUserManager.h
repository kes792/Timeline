//
//  MUserManager.h
//  
//
//  Created by Jim on 2019/4/9.
//

#import <Foundation/Foundation.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface MUserManager : NSObject

@property (nonatomic, strong) MUser *adminUser;

+ (instancetype)sharedKit;

- (void)getUserdata:(id)object
         completion:(void (^)(NSError* error))completion;

@end

NS_ASSUME_NONNULL_END
