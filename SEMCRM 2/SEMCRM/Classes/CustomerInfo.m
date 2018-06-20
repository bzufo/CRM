//
//  CustomerInfo.m
//  SemCC
//
//  Created by SEM on 15/5/30.
//  Copyright (c) 2015年 SEM. All rights reserved.
//

#import "CustomerInfo.h"

@implementation CustomerInfo
-(id)initWithTrue:(BOOL)flag{
    if ( self = [super init] )
    {
        self.isTrue=flag;
    }
    return self;
    
}
@end
