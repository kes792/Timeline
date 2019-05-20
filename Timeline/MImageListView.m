//
//  MImageListView.m
//  Timeline
//
//  Created by Jim on 2019/4/19.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MImageListView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@implementation MImageListView

- (instancetype)initWithFrame:(CGRect)frame :(NSArray *)imageStringArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //NSLog(@"_imageStringArray = %d", (int)[imageStringArray count]);
        [self setBackgroundColor:[UIColor clearColor]];
        _imageViewArray = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < [imageStringArray count]; i++)
        {
            UIImageView *photoImgae =  [UIImageView new];
            NSDictionary *dic = [imageStringArray objectAtIndex:i];
            NSURL *url = [NSURL URLWithString:[dic objectForKey:@"url"]];
            //NSLog(@"url = %@",url);
            [photoImgae sd_setImageWithURL:url
                          placeholderImage:[UIImage imageNamed:@"moment_cover.png"]
                                   options:SDWebImageAllowInvalidSSLCertificates];
           
            photoImgae.contentMode = UIViewContentModeScaleAspectFill;
            photoImgae.clipsToBounds = YES;
            photoImgae.userInteractionEnabled = YES;
            [photoImgae setTag:1000+ i];
            [self addSubview:photoImgae];
            [photoImgae setBackgroundColor:[UIColor lightGrayColor]];

            [_imageViewArray addObject:photoImgae];
        }
        
        if([imageStringArray count] == 1)
        {
            UIImageView *photoImgae = (UIImageView *)[_imageViewArray objectAtIndex:0];
            photoImgae.contentMode = UIViewContentModeTopLeft;
            [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.mas_width).multipliedBy(0.8);
                make.height.mas_equalTo(self.mas_height).multipliedBy(0.8);
                make.left.mas_equalTo(self.mas_left);
                make.top.mas_equalTo(self.mas_top);
            }];
        }
        else if([imageStringArray count] == 2)
        {
            for (UIImageView *photoImgae in _imageViewArray)
            {
                switch (photoImgae.tag) {
                    case 1000:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
                            make.height.mas_equalTo(self.mas_height);
                            make.left.mas_equalTo(self.mas_left);
                            make.centerY.mas_equalTo(self.mas_centerY);
                        }];
                    }
                        break;
                    case 1001:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
                            make.height.mas_equalTo(self.mas_height);
                            make.right.mas_equalTo(self.mas_right);
                            make.centerY.mas_equalTo(self.mas_centerY);
                        }];
                    }
                        break;
                }
            }
        }
        else if([imageStringArray count] == 4)
        {
            for (UIImageView *photoImgae in _imageViewArray)
            {
                switch (photoImgae.tag) {
                    case 1000:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
                            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
                            make.left.mas_equalTo(self.mas_left);
                            make.top.mas_equalTo(self.mas_top);
                        }];
                    }
                        break;
                    case 1001:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
                            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
                            make.right.mas_equalTo(self.mas_right);
                            make.top.mas_equalTo(self.mas_top);
                        }];
                    }
                        break;
                    case 1002:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
                            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
                            make.left.mas_equalTo(self.mas_left);
                            make.bottom.mas_equalTo(self.mas_bottom);
                        }];
                    }
                        break;
                    case 1003:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
                            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
                            make.right.mas_equalTo(self.mas_right);
                            make.bottom.mas_equalTo(self.mas_bottom);
                        }];
                    }
                        break;
                }
            }
        }
        else 
        {
            for (UIImageView *photoImgae in _imageViewArray)
            {
                switch (photoImgae.tag) {
                    case 1000:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.left.mas_equalTo(self.mas_left);
                            make.top.mas_equalTo(self.mas_top);
                        }];
                    }
                        break;
                    case 1001:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.centerX.mas_equalTo(self.mas_centerX);
                            make.top.mas_equalTo(self.mas_top);
                        }];
                    }
                        break;
                    case 1002:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.right.mas_equalTo(self.mas_right);
                            make.top.mas_equalTo(self.mas_top);
                        }];
                    }
                        break;
                    case 1003:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.left.mas_equalTo(self.mas_left);
                            make.centerY.mas_equalTo(self.mas_centerY);
                        }];
                    }
                        break;
                    case 1004:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.centerX.mas_equalTo(self.mas_centerX);
                            make.centerY.mas_equalTo(self.mas_centerY);
                        }];
                    }
                        break;
                    case 1005:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.right.mas_equalTo(self.mas_right);
                            make.centerY.mas_equalTo(self.mas_centerY);
                        }];
                    }
                        break;
                    case 1006:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.left.mas_equalTo(self.mas_left);
                            make.bottom.mas_equalTo(self.mas_bottom);
                        }];
                    }
                        break;
                    case 1007:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.centerX.mas_equalTo(self.mas_centerX);
                            make.bottom.mas_equalTo(self.mas_bottom);
                        }];
                    }
                        break;
                    case 1008:
                    {
                        [photoImgae mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
                            make.height.mas_equalTo(self.mas_height);
                            make.right.mas_equalTo(self.mas_right);
                            make.bottom.mas_equalTo(self.mas_bottom);
                        }];
                    }
                        break;
                }
            }
        };
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
