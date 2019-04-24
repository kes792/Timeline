//
//  MImageListView.m
//  Timeline
//
//  Created by Jim on 2019/4/19.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MImageListView.h"
#import "UIImageView+WebCache.h"

@implementation MImageListView

- (instancetype)initWithFrame:(CGRect)frame :(NSArray *)imageStringArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageStringArray = [[NSArray alloc] initWithArray:imageStringArray];
        NSLog(@"_imageStringArray = %@",_imageStringArray);
        [self setBackgroundColor:[UIColor blackColor]];
        /*
        for(int i = 0; i < [_imageStringArray count]; i++)
        {
            UIImageView *photoImgae =  [UIImageView new];
            NSURL *url = [NSURL URLWithString:[_imageStringArray objectAtIndex:i]];
            [photoImgae sd_setImageWithURL:url
                                placeholderImage:nil];
            photoImgae.contentMode = UIViewContentModeScaleAspectFill;
            photoImgae.clipsToBounds = YES;
            photoImgae.userInteractionEnabled = YES;
            [photoImgae setTag:1000+ i];
            [self addSubview:photoImgae];
        }
        */
        if([_imageStringArray count] == 1)
        {
            
        }
        else if([_imageStringArray count] == 4)
        {
            
        }
        else
        {
            
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
