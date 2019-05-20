//
//  MMenuView.h
//  Timeline
//
//  Created by Jim on 2019/4/25.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMenuView : UIView

@property(nonatomic,assign)BOOL isShowing;
@property(nonatomic,copy)NSString *praiseString;

@property (nonatomic, strong) UIButton    * likeButton;
@property (nonatomic, strong) UIButton    * commentButton;


@end

NS_ASSUME_NONNULL_END
