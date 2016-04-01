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
@interface ViewController ()
@property (nonatomic, strong) UILabel *label ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 200, 40)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"选择器" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    self.label.backgroundColor = [UIColor grayColor];
    self.label.textColor = [UIColor redColor];
    [self.view addSubview:self.label];
}


- (void)action{
    FJPickerView *pickerView = [[FJPickerView alloc]init];
    pickerView.arrayDataSource = @[@"大阪",@"东京",@"尼日利亚",@"亚历山大",@"中国上海"];
    __weak typeof(self) weakSelf = self;
    [pickerView didFinishSelectedItem:^(NSString *item) {
        weakSelf.label.text = item;
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
