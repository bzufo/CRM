//
//  CCSolveReplyViewController.m
//  SemCC
//
//  Created by SEM on 15/6/1.
//  Copyright (c) 2015年 SEM. All rights reserved.
//

#import "CCSolveReplyViewController.h"

@implementation CCSolveReplyViewController
-(void)viewDidLoad{
    if([_isYeDai isEqualToString:@"1"]){
        [_typeSeg setSelectedSegmentIndex:0];
        [_typeSeg setHidden:true];
    }else{
        [_typeSeg setHidden:false];
    }
    self.replyTex.layer.backgroundColor = [[UIColor clearColor] CGColor];
    
    self.replyTex.layer.borderColor = [[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]CGColor];
    
    self.replyTex.layer.borderWidth = 2.0;
    
    self.replyTex.layer.cornerRadius = 8.0f;
    self.replyTex.contentOffset = (CGPoint){.x = 0,.y = 0};
    [self.replyTex.layer setMasksToBounds:YES];
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];
    
    [topView setItems:buttonsArray];
    
    [_replyTex setInputAccessoryView:topView];
}
-(IBAction)dismissKeyBoard

{
    
    [_replyTex resignFirstResponder];
    
}
- (IBAction)saveReplyAction:(id)sender {
    [self submitToSem];
}
-(void)submitToSem{
    NSString *solve_content = self.replyTex.text;
    
    if(solve_content.length<=0){
        [MyUtil showMessage:@"请填写回复内容"];
        return;
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [dic setObject:_customerInfo.accept_mst_no forKey:@"accept_mst_no"];
//   app.userModel.token
    [dic setObject:app.userModel.token forKey:@"token"];
    [dic setObject:solve_content forKey:@"solve_content"];
    
    if([_isYeDai isEqualToString:@"1"]){
        [HttpManageTool insertServAnswer:dic success:^(BOOL isSuccess) {
            if(isSuccess){
                [self.delegate rePly];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *err) {
            
        }];
    }else{
        if (_typeSeg.selectedSegmentIndex==0){
            [dic setObject:@"回复" forKey:@"SOLVE_TYPE"];
        }else{
            [dic setObject:@"申请结案" forKey:@"SOLVE_TYPE"];
        }
        [HttpManageTool insertAnswer:dic success:^(BOOL isSuccess) {
            if(isSuccess){
                [self.delegate rePly];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *err) {
            
        }];
    }
}




//这个函数的最后一个参数text代表你每次输入的的那个字，所以：
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
@end
