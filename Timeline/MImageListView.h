//
//  MImageListView.h
//  Timeline
//
//  Created by Jim on 2019/4/19.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MImageListView : UIView

@property (nonatomic,strong) NSArray * imageStringArray;


- (instancetype)initWithFrame:(CGRect)frame :(NSArray *)imageStringArray;

@end

NS_ASSUME_NONNULL_END
