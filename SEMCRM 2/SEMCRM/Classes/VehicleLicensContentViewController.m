//
//  VehicleLicensContentViewController.m
//  SEMCRM
//
//  Created by 薛斯岐 on 16/3/15.
//  Copyright © 2016年 sem. All rights reserved.
//

#import "VehicleLicensContentViewController.h"
#import "VehicleLicenseModel.h"
@interface VehicleLicensContentViewController ()
{
    VehicleLicenseModel *vehicleLicenseModel;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel *carslal;
@property (weak, nonatomic) IBOutlet UILabel *userNameLal;
@property (weak, nonatomic) IBOutlet UILabel *carIDLal;
@property (weak, nonatomic) IBOutlet UILabel *typeLal;
@property (weak, nonatomic) IBOutlet UILabel *VinLal;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *lastImageView;
@property (nonatomic, assign)CGRect originalFrame;
@end

@implementation VehicleLicensContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)getData{
    [self clearData];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //1456101228854zl62uqujl60wc9d259yc9zz5
    //app.userModel.token
    NSDictionary *dic = @{@"token":app.userModel.token,@"vin":_vin};
    
    [HttpManageTool selectVehicleLicenContent:dic success:^(VehicleLicenseModel *model) {
        
        vehicleLicenseModel =model;
        [self setData];
        
    } failure:^(NSError *err) {
        
    }];
    
}
-(void)setData{
    _carslal.text=vehicleLicenseModel.SERIES;
    _userNameLal.text=vehicleLicenseModel.CUSTOMER_NAME;
    _carIDLal.text=vehicleLicenseModel.LICENSE_NO;
    if([vehicleLicenseModel.UP_CAR_FILE isEqualToString:@"1"]){
        _typeLal.text = @"已上传";
        _commitBtn.enabled =false;
    }else{
        _typeLal.text = @"未上传";
        _commitBtn.enabled =true;
    }
    _VinLal.text=vehicleLicenseModel.VIN;
     self.imageView.userInteractionEnabled = YES;
    [self.imageView setImageWithURL:[NSURL URLWithString:vehicleLicenseModel.CAR_FILE_ID]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showZoomImageView:)];
    [self.imageView addGestureRecognizer:tap];
}
-(void)showZoomImageView:(UITapGestureRecognizer *)tap
{
    if (![(UIImageView *)tap.view image]) {
        return;
    }
    //scrollView作为背景
    UIScrollView *bgView = [[UIScrollView alloc] init];
    bgView.frame = [UIScreen mainScreen].bounds;
    bgView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
    [bgView addGestureRecognizer:tapBg];
    
    UIImageView *picView = (UIImageView *)tap.view;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = picView.image;
    imageView.frame = [bgView convertRect:picView.frame fromView:self.view];
    [bgView addSubview:imageView];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:bgView];
    
    self.lastImageView = imageView;
    self.originalFrame = imageView.frame;
    self.scrollView = bgView;
    //最大放大比例
    self.scrollView.maximumZoomScale = 1.5;
    self.scrollView.delegate = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = imageView.frame;
        frame.size.width = bgView.frame.size.width;
        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
        frame.origin.x = 0;
        frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];
}

-(void)tapBgView:(UITapGestureRecognizer *)tapBgRecognizer
{
    self.scrollView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.5 animations:^{
        self.lastImageView.frame = self.originalFrame;
        tapBgRecognizer.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [tapBgRecognizer.view removeFromSuperview];
        self.scrollView = nil;
        self.lastImageView = nil;
    }];
}

//返回可缩放的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.lastImageView;
}
-(void)clearData{
    _carslal.text=@"";
    _userNameLal.text=@"";
    _carIDLal.text=@"";
    _typeLal.text=@"";
    _VinLal.text=@"";
    [_imageView setImage:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController * view = segue.destinationViewController;
    //    if ([view respondsToSelector:@selector(setManageDic:)]) {
    //        [view setValue:manageDic forKey:@"manageDic"];
    //    }
    
    if([view respondsToSelector:@selector(setVin:)]){
        
        [view setValue:_vin forKey:@"vin"];
    }}


@end
