//
//  MomentCell.h
//  Timeline
//
//  Created by Jim on 2019/4/12.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMoment.h"



NS_ASSUME_NONNULL_BEGIN
@protocol MomentCellDelegate;

@interface MomentCell : UITableViewCell
{
    CGFloat maxLimitHeight;
}

@property (nonatomic, strong) UIImageView * avatarImageView;
@property (nonatomic, strong) UIButton    * nameButton;
@property (nonatomic, strong) UILabel     * commentLabel;
@property (nonatomic, strong) UIButton    * showAllBtn;

@property (nonatomic, strong) UILabel     * timeLabel;   //2分鐘前
@property (nonatomic, strong) UIButton    * deleteBtn;
@property (nonatomic, strong) UIView      * commentView; // 赞和评论视图
@property (nonatomic, strong) UIImageView * bgImageView; // 赞和评论视图背景

// 内容
//@property (nonatomic, strong) MLLinkLabel * linkLabel;
// 图片
//@property (nonatomic, strong) MMImageListView * imageListView;

// 操作视图
//@property (nonatomic, strong) MMOperateMenuView * menuView;

// 动态
@property (nonatomic, strong) MMoment * moment;
// 代理
//@property (nonatomic, assign) id<MomentCellDelegate> delegate;

@property (nonatomic, assign) id<MomentCellDelegate> delegate;


@end


@protocol MomentCellDelegate <NSObject>
@optional
// 点击头像|删除|点赞|评论|全文/收起
- (void)didOperateMoment:(MomentCell *)cell operateType:(int)operateType;
// 选择评论
//- (void)didOperateMoment:(MomentCell *)cell selectComment:(Comment *)comment;
@end

NS_ASSUME_NONNULL_END
