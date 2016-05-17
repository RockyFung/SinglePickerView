
//
//  FJWaresNumberPicker.m
//  FJPickerVIew
//
//  Created by rocky on 16/5/12.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "FJWaresNumberPicker.h"
#import "WaresNumberView.h"

#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
// pickerView高度
#define kPVH (KScreenHeight / 4)

@interface FJWaresNumberPicker()
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIView *pickerBg;

@property (nonatomic, assign) NSInteger minNum;
@property (nonatomic, assign) NSInteger maxNum;
@property (nonatomic, assign) NSInteger currentNum;


@end

@implementation FJWaresNumberPicker


- (instancetype)initWithMinNum:(NSInteger)minNum MaxNum:(NSInteger)maxNum
{
    self = [super initWithFrame:[[UIScreen mainScreen]bounds]];
    if (self) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        [self setUserInteractionEnabled:YES];
        [self.bgBtn setUserInteractionEnabled:YES];
        
        self.minNum = minNum ? minNum : 1;
        self.maxNum = maxNum ? maxNum : 10;
        self.currentNum = 1;
        
        // 半透明背景
        self.bgBtn = [[UIButton alloc]init];
        self.bgBtn.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        [self addSubview:self.bgBtn];
        self.bgBtn.backgroundColor = [UIColor blackColor];
        self.bgBtn.alpha = 0;
        [self.bgBtn addTarget:self action:@selector(dismissPickerView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bgBtn];
        
        // 选择器背景
        self.pickerBg = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, kPVH)];
        self.pickerBg.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerBg];
        
        CGFloat headerHeight = kPVH / 5;
        // 选择器取消确认按钮
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, headerHeight)];
        header.backgroundColor = [UIColor darkGrayColor];
        [self.pickerBg addSubview:header];
        
        // 取消按钮
        UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth / 4, headerHeight)];
        [cancle setTitle:@"cancle" forState:UIControlStateNormal];
        [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(dismissPickerView) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:cancle];
        
        // 确定按钮
        UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - KScreenWidth / 4, 0, KScreenWidth / 4, headerHeight)];
        [confirm setTitle:@"confirm" forState:UIControlStateNormal];
        [confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:confirm];
        
        // 添加选择页面
        WaresNumberView *waresView = [[WaresNumberView alloc]initWithFrame:CGRectMake(0, headerHeight, KScreenWidth, kPVH - headerHeight)];
        waresView.minNum = minNum;
        waresView.maxNum = maxNum;
        waresView.block = ^(NSInteger currentNum){
            self.currentNum = currentNum;
        };
        [self.pickerBg addSubview:waresView];
        
        
    }
    return self;
}

- (void)show{
    
    [self pushSinglePickerView];
}

- (void)confirm{
    [self dismissPickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedNumber:)]) {
        [self.delegate selectedNumber:self.currentNum];
    }
}

//出现
- (void)pushSinglePickerView
{
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.pickerBg.frame = CGRectMake(0, KScreenHeight - kPVH, KScreenWidth, kPVH);
        weakSelf.bgBtn.alpha = 0.2;
    }];
}


// 页面消失
- (void)dismissPickerView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.pickerBg.frame = CGRectMake(0, KScreenHeight, KScreenWidth, kPVH);
        weakSelf.bgBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.pickerBg removeFromSuperview];
        [weakSelf.bgBtn removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}





@end
