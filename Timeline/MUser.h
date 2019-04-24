//
//  MUser.h
//  Timeline
//
//  Created by Jim on 2019/4/11.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUser : NSObject

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, copy) NSString * avatarURLString;
@property (nonatomic, copy) NSString * profileImageURLString;

- (instancetype)init:(NSDictionary *)dir;

@end

NS_ASSUME_NONNULL_END
