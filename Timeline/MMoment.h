//
//  MMoment.h
//  Timeline
//
//  Created by Jim on 2019/4/11.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMoment : NSObject

@property (nonatomic, copy) NSString        *contentString;
@property (nonatomic, strong)MUser          *senderUser;
@property (nonatomic, strong)MUser          *commentUser;
@property (nonatomic, copy) NSString        *commentContent;
@property (nonatomic, copy) NSArray         *imageURLArrray;
@property (nonatomic, copy) NSMutableArray  *commentsArray;
@property (nonatomic, assign) BOOL           isFullText;
// Moment对应cell高度
@property (nonatomic, assign) double rowHeight;

- (instancetype)init:(NSDictionary *)dir;


@end

NS_ASSUME_NONNULL_END
