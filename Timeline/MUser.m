//
//  MUser.m
//  Timeline
//
//  Created by Jim on 2019/4/11.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MUser.h"

@implementation MUser

- (instancetype)init:(NSDictionary *)dir
{

    self = [super init];
    if (self) {
        
        if([dir objectForKey:@"username"]){
            _userName = [[NSString alloc] initWithString:[dir objectForKey:@"username"]];
        }
        if([dir objectForKey:@"nick"] ){
            _nickName = [[NSString alloc] initWithString:[dir objectForKey:@"nick"]];
        }
        if([dir objectForKey:@"avatar"] ){
            _avatarURLString = [[NSString alloc] initWithString:[dir objectForKey:@"avatar"]];
        }
        if([dir objectForKey:@"profile-image"]){
            _profileImageURLString = [[NSString alloc] initWithString:[dir objectForKey:@"profile-image"]];
        }
    }
    
    return self;
}


@end
