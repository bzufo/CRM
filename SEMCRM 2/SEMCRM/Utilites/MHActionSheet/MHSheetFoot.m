//
//  MHSheetFoot.m
//  MHActionSheet
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.

#import "MHSheetFoot.h"

@implementation MHSheetFoot

- (void)awakeFromNib
{
    _footButton.backgroundColor = [UIColor whiteColor];
    
    [_footButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_footButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    _footButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    if ([[UIScreen mainScreen] bounds].size.height == 667) {
        _footButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    else if ([[UIScreen mainScreen] bounds].size.height > 667) {
        _footButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
    }
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com