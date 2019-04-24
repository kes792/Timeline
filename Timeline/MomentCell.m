//
//  MomentCell.m
//  Timeline
//
//  Created by Jim on 2019/4/12.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MomentCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MImageListView.h"

#define AVATAR_WIDTH          50
#define AVATAR_HEIGHT         50
#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define OFFSET_HEIGHT         10

#define STATUS_HEIGHT         [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT         self.navigationController.navigationBar.frame.size.height
#define ALLTOP_HEIGHT         (STATUS_HEIGHT + NAVBAR_HEIGHT)
#define SHOWCOLOR(r,g,b)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@implementation MomentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

#pragma  mark - config UI
-(void)configUI {
//    @property (nonatomic, strong) UIImageView * avatarImageView;
//    @property (nonatomic, strong) UILabel     * nameLab;
//    @property (nonatomic, strong) UILabel     * timeLab;
//    @property (nonatomic, strong) UIButton    * deleteBtn;
//    @property (nonatomic, strong) UIButton    * showAllBtn;
//    @property (nonatomic, strong) UIView      * commentView; // 赞和评论视图
//    @property (nonatomic, strong) UIImageView * bgImageView; // 赞和评论视图背景
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _avatarImageView = [UIImageView new];
    [_avatarImageView setBackgroundColor:[UIColor grayColor]];
    _avatarImageView.layer.cornerRadius = 5;
    _avatarImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_avatarImageView];
   
    _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nameButton setBackgroundColor:[UIColor clearColor]];
    _nameButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_nameButton setTitleColor:SHOWCOLOR(70, 90, 135) forState:UIControlStateNormal];;
    _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_nameButton];
    
    _commentLabel = [UILabel new];
    [_commentLabel setFont: [UIFont systemFontOfSize:17]];
    _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _commentLabel.numberOfLines = 0;
    [self.contentView addSubview:_commentLabel];

    _showAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showAllBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];

    [_showAllBtn setBackgroundColor:[UIColor clearColor]];
    [_showAllBtn setTitleColor:SHOWCOLOR(70, 90, 135) forState:UIControlStateNormal];;
    _showAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_showAllBtn addTarget:self action:@selector(fullTextClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_showAllBtn];
    [_showAllBtn sizeToFit];
    
    maxLimitHeight = (_commentLabel.font.lineHeight + 5) * 5;
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _timeLabel.font = [UIFont systemFontOfSize:13.0f];
    [_timeLabel setText:@"2分鐘前"];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel sizeToFit];

}

#pragma mark - setter
- (void)setMoment:(MMoment *)moment{
    _moment = moment;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:moment.senderUser.avatarURLString]
                        placeholderImage:nil];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(OFFSET_HEIGHT);
        make.left.mas_equalTo(OFFSET_HEIGHT);
        make.size.mas_equalTo(AVATAR_WIDTH);
    }];
    
    [_nameButton setTitle:moment.senderUser.nickName
                 forState:UIControlStateNormal];
    [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_top);
        make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset (OFFSET_HEIGHT);
        make.right.mas_equalTo(self.mas_right).with.offset(-OFFSET_HEIGHT);
        make.height.mas_equalTo(self.avatarImageView.mas_height).multipliedBy(0.5); //AVATAR_HEIGHT/2
    }];
    [_nameButton setBackgroundColor:[UIColor redColor]];
    
    [_commentLabel setHidden:TRUE];
    [_showAllBtn setHidden:TRUE];
    CGFloat rowHeight = 0;
    
    NSString *str = @"上下文切换，不管是在GPU渲染过程中，还是一直所熟悉的进程切换，上下文切换在哪里都是一个相当耗时的操作。\n\n首先我要保存当前屏幕渲染环境，然后切换到一个新的绘制环境，申请绘制资源，初始化环境，然后开始一个绘制，绘制完毕后销毁这个绘制环境，如需要切换到On-ScreenRendering或者再开始一个新的离屏渲染重复之前的操作。一次mask发生了两次离屏渲染和一次主屏渲染。即使忽略昂贵的上下文切换，一次mask需要渲染三次才能在屏幕上显示，这已经是普通视图显示3陪耗时，若再加上下文环境切换，一次mask就是普通渲染的30倍以上耗时操作。问我这个30倍以上这个数据怎么的出来的？当我在cell的UIImageView的实例增加到150个，并去掉圆角的时候，帧数才跌至28帧每秒。虽然不是甚准确，但至少反映mask这个耗时是无mask操作的耗时的数十倍的。";
    
    [_commentLabel setText: _moment.contentString];
  

    if([_commentLabel.text length]){ //有文字
        
        [_commentLabel setHidden:NO];
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 3;
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:_commentLabel.text];
        [attributedText addAttribute:NSParagraphStyleAttributeName
                               value:style
                               range:NSMakeRange(0,[_commentLabel.text length])];
        _commentLabel.attributedText = attributedText;
 
        CGSize strSize;
        strSize = [_commentLabel.text boundingRectWithSize:CGSizeMake((SCREEN_WIDTH - AVATAR_WIDTH - OFFSET_HEIGHT*3), 1000000.0f)
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName:[_commentLabel font],
                                                             NSParagraphStyleAttributeName :style}
                                                   context:nil].size;
        CGFloat labHeight = strSize.height;
        
        NSLog(@"Jim strSize = %@", NSStringFromCGSize(strSize));
        if (labHeight > maxLimitHeight) {
            if (!_moment.isFullText) {
                labHeight = maxLimitHeight;
            }
            _showAllBtn.hidden = NO;
            _showAllBtn.selected = _moment.isFullText;
            if(self.moment.isFullText)
                [_showAllBtn setTitle:@"折疊" forState:UIControlStateNormal];
            else
                [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
        }
        [_commentLabel setBackgroundColor:[UIColor lightGrayColor]];
        [_commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameButton.mas_bottom).with.offset (OFFSET_HEIGHT);
            make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset (OFFSET_HEIGHT);
            make.width.mas_equalTo(strSize.width + 1);
            make.height.mas_equalTo(labHeight);
        }];

        [_showAllBtn setBackgroundColor:[UIColor yellowColor]];
        [_showAllBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.commentLabel.mas_bottom).with.offset (OFFSET_HEIGHT/2);
            make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset (OFFSET_HEIGHT);
            make.width.mas_equalTo(self.showAllBtn.frame.size.width);
            make.height.mas_equalTo(20);
        }];
        
        if (_showAllBtn.hidden)
            rowHeight = OFFSET_HEIGHT + AVATAR_HEIGHT + labHeight;
        else
            rowHeight = OFFSET_HEIGHT + AVATAR_HEIGHT/2 + OFFSET_HEIGHT + labHeight + _showAllBtn.frame.size.height;
    }
    else{ // 沒文字
        rowHeight = OFFSET_HEIGHT + AVATAR_HEIGHT/2 + OFFSET_HEIGHT;
    }
    
    // Photo
    MImageListView *imageListVew;
    
    if([_moment.imageURLArrray count])
    {
        imageListVew = [[MImageListView alloc] initWithFrame:CGRectZero
                                                            :_moment.imageURLArrray];
        [self.contentView addSubview:imageListVew];
        [imageListVew mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).with.offset (rowHeight);
            make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset (OFFSET_HEIGHT);
            make.size.mas_equalTo(150);
        }];
        rowHeight += 150 + OFFSET_HEIGHT;
    }
    
    [_timeLabel setBackgroundColor:[UIColor greenColor]];
    [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset (rowHeight);
        make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset (OFFSET_HEIGHT);
        make.width.mas_equalTo(self.timeLabel.frame.size.width);
        make.height.mas_equalTo(OFFSET_HEIGHT);
    }];
    rowHeight += self.timeLabel.frame.size.height + OFFSET_HEIGHT;
    
    
    _moment.rowHeight = rowHeight;
    
}

- (void)fullTextClicked:(UIButton *)sender
{
    __weak MomentCell *weakSelf = self;
    
    self.moment.isFullText = !self.moment.isFullText;
    [self setMoment :self.moment];
    
    if ([self.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
        [self.delegate didOperateMoment:self operateType:0];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
