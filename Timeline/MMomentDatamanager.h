//
//  MMomentDatamanager.h
//  Timeline
//
//  Created by Jim on 2019/4/11.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMoment.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMomentDatamanager : NSObject
{
}

@property (nonatomic, copy) NSMutableArray *momentArray;


+ (instancetype)sharedKit;

-(NSArray *)getMomentList:(int)momentIndex pageNumber:(int)num;

-(void)getALLMomentData:(id)object completion:(void (^)(NSError* error))completion;

@end

NS_ASSUME_NONNULL_END
