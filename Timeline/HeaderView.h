//
//  HeaderView.h
//  
//
//  Created by Jim on 2019/4/2.
//

#import <UIKit/UIKit.h>
#import "MUserManager.h"


@interface HeaderView : UIView
{
    MUserManager *userManager;
    UILabel *nameLabel;
    UIImageView * iconView;
    UIImageView * backgroundImageView;
}

//@property (nonatomic, strong) UILabel *nameLabel;

@end


