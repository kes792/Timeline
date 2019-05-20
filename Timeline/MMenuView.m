//
//  MMenuView.m
//  Timeline
//
//  Created by Jim on 2019/4/25.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MMenuView.h"
#import "Masonry.h"


#define SHOWCOLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@implementation MMenuView

-(instancetype)init {
    if (self = [super init]) {
        _isShowing = NO;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = SHOWCOLOR(69, 74, 76);
        
        _likeButton = [self createButtonWith:@"赞"
                                       image:@"AlbumLike.png"];
        
        _commentButton = [self createButtonWith:@"评论"
                                          image:@"AlbumComment.png"];
        
        UIView *centerLine = [[UIView alloc]init];
        centerLine.backgroundColor = [UIColor grayColor];
        
        [self addSubview:_likeButton];
        [self addSubview:_commentButton];
        [self addSubview:centerLine];
        
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left).offset(5);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(90);
        }];
        [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(2);
            make.left.mas_equalTo(self.likeButton.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-2);
            make.width.mas_equalTo(1);
        }];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(centerLine.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(90);
        }];
    }
    return self;
}



-(UIButton *)createButtonWith:(NSString *)title image:(NSString *)imageString {
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    return btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
