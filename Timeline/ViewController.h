//
//  ViewController.h
//  Timeline
//
//  Created by Jim on 2019/3/30.
//  Copyright © 2019 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) NSMutableArray * momentList;  
@property (nonatomic, strong) UITableView * tableView;

@end

