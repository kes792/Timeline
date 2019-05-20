//
//  MomentCell.h
//  Timeline
//
//  Created by Jim on 2019/4/12.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMoment.h"
#import "MMenuView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MomentCellDelegate;

@interface MomentCell : UITableViewCell
{
    CGFloat maxLimitHeight;
}

@property (nonatomic, strong) UIImageView * avatarImageView;
@property (nonatomic, strong) UIButton    * nameButton;
@property (nonatomic, strong) UILabel     * contentLabel;
@property (nonatomic, strong) UIButton    * showAllBtn;
@property (nonatomic, strong) UIButton    * moreButton;
@property (nonatomic, strong) MMenuView   * menuView; // 赞和评论视图
@property (nonatomic, strong) UILabel     * commentLabel;


@property (nonatomic, strong) UILabel     * timeLabel;   //2分鐘前


// 动态
@property (nonatomic, strong) MMoment * moment;

@property (nonatomic, assign) id<MomentCellDelegate> delegate;


@end


@protocol MomentCellDelegate <NSObject>
@optional

- (void)didOperateMoment:(MomentCell *)cell operateType:(int)operateType;

@end

NS_ASSUME_NONNULL_END
