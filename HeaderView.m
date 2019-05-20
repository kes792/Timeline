//
//  HeaderView.m
//  
//
//  Created by Jim on 2019/4/2.
//

#import "HeaderView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define STATUS_HEIGHT         [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT         self.navigationController.navigationBar.frame.size.height
#define ALLTOP_HEIGHT         (STATUS_HEIGHT + NAVBAR_HEIGHT)

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self configUILayout];
        [self getUserData];
    }
    return self;
}

-(void) configUILayout
{
    backgroundImageView = [UIImageView new];
    backgroundImageView.image = [UIImage imageNamed:@"moment_cover.png"];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_WIDTH);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                 self.frame.size.height-20,
                                                                 SCREEN_WIDTH,
                                                                 20)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100,
                                                             self.frame.size.height-80,
                                                             80,
                                                             80)];
    [self addSubview:iconView];
    
    nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH-220,
                                                           iconView.frame.origin.y+20,
                                                           100,
                                                           30)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:nameLabel];
}

-(void) getUserData
{
    __weak HeaderView *weakSelf = self;
    [[MUserManager sharedKit] getUserdata:weakSelf completion:^(NSError *error) {
        if(error){
            NSLog(@"error:\n%@",error);
        }
        else{ // get user's jsonstring
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf updateUserName];
                [weakSelf updateProfileImage];
                [weakSelf updateAvatarImage];
            });
        }
    }];
}

-(void) updateUserName
{
    nameLabel.text = [MUserManager sharedKit].adminUser.nickName;
}

-(void) updateProfileImage
{
    NSURL *url = [NSURL URLWithString:[MUserManager sharedKit].adminUser.profileImageURLString];
    [backgroundImageView sd_setImageWithURL:url
                           placeholderImage:[UIImage imageNamed:@"moment_cover.png"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         NSLog(@"");
     }];
}

-(void) updateAvatarImage
{
    NSURL *url = [NSURL URLWithString:[MUserManager sharedKit].adminUser.avatarURLString];
    [iconView sd_setImageWithURL:url
                placeholderImage:[UIImage imageNamed:@"WWDCICON.png"]
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         NSLog(@"");
     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
