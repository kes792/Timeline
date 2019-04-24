//
//  MMoment.m
//  Timeline
//
//  Created by Jim on 2019/4/11.
//  Copyright © 2019 Jim. All rights reserved.
//

#import "MMoment.h"
@implementation MMoment

- (instancetype)init:(NSDictionary *)dir 
{

    self = [super init];
    if (self)
    {
        _isFullText = NO; 
        
        if([dir objectForKey:@"unknown error"] || [dir objectForKey:@"error"] )
            return NULL;
        
        if(![dir objectForKey:@"content"] && ![dir objectForKey:@"images"] ) // 沒有內容也沒照片
            return NULL;
        
        if([dir objectForKey:@"content"]){
            _contentString = [[NSString alloc] initWithString:[dir objectForKey:@"content"]];
        }
        if([dir objectForKey:@"images"] ){
            _imageURLArrray = [[NSArray alloc] initWithArray: [dir objectForKey:@"images"]];
        }
        if([dir objectForKey:@"sender"] ){
            _senderUser = [[MUser alloc] init:[dir objectForKey:@"sender"]];
        }
        
        if([dir objectForKey:@"comments"])
        {
            _commentsArray = [[NSMutableArray alloc] init];
            NSArray *arrary = (NSArray *)[dir objectForKey:@"comments"];
            for(int i=0;i<[arrary count]; i++)
            {
                NSDictionary *dir = (NSDictionary *)[arrary objectAtIndex:i];
                if([dir objectForKey:@"content"] && [dir objectForKey:@"sender"])
                {
                    _commentUser   = [[MUser alloc] init:[dir objectForKey:@"sender"]];
                    NSDictionary *commentDir = [NSDictionary dictionaryWithObjectsAndKeys:
                                                _commentUser,@"sender",
                                                [dir objectForKey:@"content"],@"content",
                                                nil];
                    [_commentsArray addObject:commentDir];
                }
            }
        }
        
    }
    
    return self;
}

@end
