//
//  AttenceTimelineCell.m
//  Product
//
//  Created by ACTIVATION GROUP on 14-8-7.
//  Copyright (c) 2014年 eKang. All rights reserved.
//

#import "AttenceTimelineCell.h"

@implementation AttenceTimelineCell

#define DotViewCentX 20//圆点中心 x坐标
#define VerticalLineWidth 2//时间轴 线条 宽度
#define ShowLabTop 10//cell间距
#define ShowLabWidth (SCREEN_WIDTH - DotViewCentX - 20)
#define ShowLabFont [UIFont systemFontOfSize:15]

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        verticalLineTopView = [[UIView alloc] init];
        verticalLineTopView.backgroundColor = [UIColor grayColor];
        [self addSubview:verticalLineTopView];
        
        int dotViewRadius = 5;
        dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dotViewRadius * 2, dotViewRadius * 2)];
        dotView.backgroundColor = [UIColor orangeColor];
        dotView.layer.cornerRadius = dotViewRadius;
        [self addSubview:dotView];
        
        verticalLineBottomView = [[UIView alloc] init];
        verticalLineBottomView.backgroundColor = [UIColor grayColor];
        [self addSubview:verticalLineBottomView];
        
        //初始化生成button并把准备好的图片作为其背景图片
        _showLab = [[UIButton alloc] init];
        UIImage *img = [UIImage imageNamed:@"AttenceTimelineCellMessage2"];
        img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        [_showLab setBackgroundImage:img forState:UIControlStateNormal];
        _showLab.titleLabel.font = ShowLabFont;
        _showLab.titleLabel.numberOfLines = 0;
        _showLab.titleLabel.textAlignment = NSTextAlignmentLeft;
        _showLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _showLab.titleEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 5);
        [self addSubview:_showLab];
        //[showLab resignFirstResponder];
        self.iconView=[[UIImageView alloc]init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        //UIImage *img1 = [UIImage imageNamed:@"文本"];
        //[self.iconView setImage:img1];
        [self addSubview:self.iconView];
    }
    return self;
}


- (void)setFrame:(CGRect)frame{
    super.frame = frame;
    dotView.center = CGPointMake(DotViewCentX, ShowLabTop + 13);
    int cutHeight = dotView.frame.size.height/2.0 - 2;
    verticalLineTopView.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0, 0, VerticalLineWidth, dotView.center.y - cutHeight);
    verticalLineBottomView.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0, dotView.center.y + cutHeight, VerticalLineWidth, frame.size.height - (dotView.center.y + cutHeight));
}

//赋值
- (void)setDataSource:(NSString *)content isFirst:(BOOL)isFirst isLast:(BOOL)isLast {
    _showLab.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0 + 5, ShowLabTop, ShowLabWidth, [AttenceTimelineCell cellHeightWithString:content isContentHeight:YES]);
    [_showLab setTitle:content forState:UIControlStateNormal];
    self.iconView.frame =CGRectMake(_showLab.frame.origin.x+_showLab.frame.size.width+1,_showLab.frame.origin.y+_showLab.frame.size.height/2-9,18,18);
    //设置最上面和最下面是否隐藏
    verticalLineTopView.hidden = isFirst;
    verticalLineBottomView.hidden = isLast;
    
    //判断是否是第一个（是第一个更改背景色）
    dotView.backgroundColor = isFirst ? [UIColor orangeColor] : [UIColor grayColor];
    
    //判断是否是第一个（是第一个的话就换成彩色图片）
    UIImage *img = [UIImage imageNamed:isFirst ? @"AttenceTimelineCellMessage" : @"AttenceTimelineCellMessage2"];
    img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    //重新赋值给button的背景
    [_showLab setBackgroundImage:img forState:UIControlStateNormal];
}
- (void)setDataSource:(NSString *)content isFirst:(BOOL)isFirst isLast:(BOOL)isLast showL:(BOOL)show{
    _showLab.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0 + 5, ShowLabTop, ShowLabWidth, [AttenceTimelineCell cellHeightWithString:content isContentHeight:YES]);
    [_showLab setTitle:content forState:UIControlStateNormal];
    self.iconView.frame =CGRectMake(_showLab.frame.origin.x+_showLab.frame.size.width-3,_showLab.frame.origin.y+_showLab.frame.size.height/2-9,18,18);
    UIImage *img1;
    if(show){
        img1 = [UIImage imageNamed:@"喇叭"];
    }else{
        img1 = [UIImage imageNamed:@""];
    }
    [self.iconView setImage:img1];
    //设置最上面和最下面是否隐藏
    verticalLineTopView.hidden = isFirst;
    verticalLineBottomView.hidden = isLast;
    
    //判断是否是第一个（是第一个更改背景色）
    dotView.backgroundColor = isFirst ? [UIColor orangeColor] : [UIColor grayColor];
    
    //判断是否是第一个（是第一个的话就换成彩色图片）
    UIImage *img = [UIImage imageNamed:isFirst ? @"AttenceTimelineCellMessage" : @"AttenceTimelineCellMessage2"];
    img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    //重新赋值给button的背景
    [_showLab setBackgroundImage:img forState:UIControlStateNormal];
}

//根据字符串的高度设置cell的高度
+ (float)cellHeightWithString:(NSString *)content isContentHeight:(BOOL)b{
    float height = [content sizeWithFont:ShowLabFont constrainedToSize:CGSizeMake(ShowLabWidth - 20, 2000)].height;
    float zz = (b ? height : (height + ShowLabTop * 2)) + 15;
    return zz;
}




- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
