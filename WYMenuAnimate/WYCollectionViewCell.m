//
//  WYCollectionViewCell.m
//  WYMenuAnimate
//
//  Created by Kevin on 15/7/12.
//  Copyright (c) 2015年 石乐. All rights reserved.
//

#import "WYCollectionViewCell.h"

@implementation WYCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
        self.titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
        self.titlelable.textAlignment = NSTextAlignmentCenter;
        self.titlelable.font=[UIFont systemFontOfSize:12];
        [self addSubview:self.titlelable];
        
    }
    return self;
}
@end
