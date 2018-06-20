//
//  CueInfoCell.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/2/22.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "CueInfoCell.h"

@implementation CueInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configureCell:(CueList*)model{
    _levLal.text=model.level;
    _cnameLal.text = model.cname;
    _mobileLal.text = model.mobile;
    _carsLal.text = model.series;
    _stateLal.text = model.TSTATE;
    _ydLal.text = model.EMPLOYEE_NAME;
    NSString *ss =@"";
    ss=model.cfrom;
    if([model.cfrom isEqualToString:@"集采平台"]){
        ss =[NSString stringWithFormat:@"%@[%@]",ss,model.MEDIA_NAME];
    }
    if(model.WXFLAG!=NULL && [model.WXFLAG isEqualToString:@"1"] ){
        ss = [NSString stringWithFormat:@"%@(%@)", ss,@"网销"];
    }else{
        ss = [NSString stringWithFormat:@"%@(%@)", ss,@"非网销"];
    }
    _cfrom.text=ss;
    _hdmcLal.text=model.leadbatch;
    _bzLal.text=model.REMARK;
    if([model.FROM_FLAG isEqualToString:@"T"]){
        _dateLal.text=@"下发时间";
    }
    
    _createDateLal.text=model.CREATE_DATE;
}
- (IBAction)bzAct:(id)sender {
    [MyUtil showMessage:_bzLal.text];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
