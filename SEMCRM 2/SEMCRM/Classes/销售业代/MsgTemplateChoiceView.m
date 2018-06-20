//
//  MsgTemplateChoiceView.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/23.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "MsgTemplateChoiceView.h"

@interface MsgTemplateChoiceView ()
{
    NSArray *msgArr;
    int nowPage;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLal;
@property (weak, nonatomic) IBOutlet UITextView *subTitleTex;

@end

@implementation MsgTemplateChoiceView
- (IBAction)rightAct:(UIButton *)sender {
    if(nowPage==2){
        nowPage=0;
    }else{
        nowPage++;
    }
    [self getData];
}
- (IBAction)leftAct:(UIButton *)sender {
    if(nowPage==0){
        nowPage=2;
    }else{
        nowPage--;
    }
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    
         UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    
         UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    
         NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];
    
      [topView setItems:buttonsArray];
   
         [_subTitleTex setInputAccessoryView:topView];
    
    
    nowPage=0;
    msgArr = [[NSArray alloc]init];
    msgArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"msg"];
    [self getData];
//    self.view.backgroundColor=[UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)dismissKeyBoard

{
    
    [_subTitleTex resignFirstResponder];
    
}
-(void)getData{
    NSDictionary *dic = msgArr[nowPage];
    NSString *title = [dic objectForKey:@"title"];
    NSString *subtitle = [dic objectForKey:@"subtitle"];
    NSString *cname = _cueModel.cname;
    NSString *sex = _cueModel.sex;
    if([sex isEqualToString:@"男"]){
        sex = @"先生";
    
    }else{
        sex = @"女士";
    }
    NSString *replaceStr = [NSString stringWithFormat:@"%@%@",cname,sex];
    subtitle=[subtitle stringByReplacingOccurrencesOfString:@"XXX先生/女士" withString:replaceStr];
    _titleLal.text = title;
    _subTitleTex.text =subtitle;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancelAct:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)sureAct:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate chooseMsgTemplate:self.subTitleTex.text];
    }];
}

@end
