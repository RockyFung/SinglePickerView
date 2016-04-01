//
//  FJPickerView.m
//  FJPickerVIew
//
//  Created by rocky on 16/3/31.
//  Copyright © 2016年 RockyFung. All rights reserved.
//
#import "FJSinglePickerView.h"
#import "FJPickerView.h"



#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
// pickerView高度
#define kPVH (KScreenHeight*0.35>230?230:(KScreenHeight*0.35<200?200:KScreenHeight*0.35)+30)
@interface FJPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) FJSinglePickerView *singlePickerView;
@property (nonatomic, copy) PickerViewSelectBlock selectBlock;
@property (nonatomic,assign) NSInteger pickerIndex;
@end


@implementation FJPickerView

- (instancetype)init
{
    self = [super initWithFrame:[[UIScreen mainScreen]bounds]];
    if (self) {
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        [self setUserInteractionEnabled:YES];
        [self.bgBtn setUserInteractionEnabled:YES];
        // 半透明背景
        self.bgBtn = [[UIButton alloc]init];
        self.bgBtn.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        [self addSubview:self.bgBtn];
        self.bgBtn.backgroundColor = [UIColor blackColor];
        self.bgBtn.alpha = 0;
        [self.bgBtn addTarget:self action:@selector(dismissPickerView) forControlEvents:UIControlEventTouchUpInside];
        
        // 选择器
        self.singlePickerView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FJSinglePickerView class]) owner:self options:nil].lastObject;
        [self addSubview:self.singlePickerView];
        self.singlePickerView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, kPVH);
        
        
        // 取消按钮
        [self.singlePickerView.cancelBtn addTarget:self action:@selector(dismissPickerView) forControlEvents:UIControlEventTouchUpInside];
        [self.singlePickerView.cancelBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        self.singlePickerView.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.singlePickerView.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 确定按钮
        [self.singlePickerView.confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.singlePickerView.confirmBtn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        self.singlePickerView.confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.singlePickerView.confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.singlePickerView.pickerView addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged]
        
        self.singlePickerView.pickerView.delegate = self;
        self.singlePickerView.pickerView.dataSource = self;
        [self pushSinglePickerView];
        
    }
    return self;
}

//出现
- (void)pushSinglePickerView
{
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.singlePickerView.frame = CGRectMake(0, KScreenHeight - kPVH, KScreenWidth, kPVH);
        weakSelf.bgBtn.alpha = 0.2;
    }];
}


// 页面消失
- (void)dismissPickerView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.singlePickerView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, kPVH);
        weakSelf.bgBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.singlePickerView removeFromSuperview];
        [weakSelf.bgBtn removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

//确定
- (void)confirmBtnClick:(id)sender
{
    if (_selectBlock) {
        _selectBlock(self.arrayDataSource[self.pickerIndex]);
    }
    [self dismissPickerView];
}


- (void)didFinishSelectedItem:(PickerViewSelectBlock)selectBlock{
    _selectBlock = selectBlock;
}

#pragma pickerViewDelegate
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// 返回每列多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrayDataSource.count;
}

// 每列高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

// 返回标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.arrayDataSource[row];
}



// 监听UIPickerView选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.pickerIndex = row;
}

@end
