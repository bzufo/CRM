//
//  ConnectRecordCell.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/22.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "ConnectRecordCell.h"

@implementation ConnectRecordCell

- (void)awakeFromNib {
    _RecodeText.layer.borderColor = [[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]CGColor];
    
    _RecodeText.layer.borderWidth = 2.0;
    
    _RecodeText.layer.cornerRadius = 8.0f;
    
    [_RecodeText.layer setMasksToBounds:YES];
    // 2、键盘上方附加一个toolbar，toolbar上有个完成按钮
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    // toolbar上的2个按钮
    UIBarButtonItem *SpaceButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil  action:nil]; // 让完成按钮显示在右侧
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(pickerDoneClicked)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:SpaceButton, doneButton, nil]];
    _RecodeText.inputAccessoryView = keyboardDoneButtonView;
    // Initialization code
}
-(void)pickerDoneClicked
{
    
    [_RecodeText resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
