//
//  ViewController.m
//  FJPickerVIew
//
//  Created by rocky on 16/3/30.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import "FJPickerView.h"
#import "FJSinglePickerView.h"
#import "FJWaresNumberPicker.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *label ;
@property (nonatomic, strong) UILabel *label2 ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // pickerView
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 200, 40)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"选择器" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    self.label.backgroundColor = [UIColor grayColor];
    self.label.textColor = [UIColor redColor];
    [self.view addSubview:self.label];
    
    // 商品选择器
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 200, 40)];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 setTitle:@"商品选择器" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(action2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 250, 200, 40)];
    self.label2.backgroundColor = [UIColor grayColor];
    self.label2.textColor = [UIColor redColor];
    [self.view addSubview:self.label2];
}


- (void)action{
    FJPickerView *pickerView = [[FJPickerView alloc]init];
    pickerView.arrayDataSource = @[@"大阪",@"东京",@"尼日利亚",@"亚历山大",@"中国上海"];
    __weak typeof(self) weakSelf = self;
    [pickerView didFinishSelectedItem:^(NSString *item) {
        weakSelf.label.text = item;
    }];

}


- (void)action2{
    FJWaresNumberPicker *pv = [[FJWaresNumberPicker alloc]initWithMinNum:1 MaxNum:15];
    pv.delegate = self;
    [pv selectFinish:^(NSInteger num) {
        self.label2.text = [NSString stringWithFormat:@"%ld",num];
    }];
    [pv show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
