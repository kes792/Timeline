//
//  MAPIAdapter.h
//  Timeline
//
//  Created by Jim on 2019/4/9.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPIAdapter : NSObject

+ (instancetype)sharedKit;


- (void)loadUserDataFromURL:(id)object
                    withURL: urlString
                 completion:(void (^)(id resultObject, NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
