
//
//  WaresNumberView.m
//  FJPickerVIew
//
//  Created by rocky on 16/5/17.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import "WaresNumberView.h"

#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width


@interface WaresNumberView()
@property (nonatomic, strong) UIButton *minBtn; //最小
@property (nonatomic, strong) UIButton *maxBtn; //最大
@property (nonatomic, strong) UIButton *reduceBtn; // 减
@property (nonatomic, strong) UIButton *addBtn; // 加
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, strong) UILabel *foot;
@end


@implementation WaresNumberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KScreenWidth - 30, KScreenWidth / 12)];
        title.text = @"转让数量";
        title.textColor = [UIColor grayColor];
        [self addSubview:title];
        
       
        CGFloat minW = KScreenWidth / 8;
        CGFloat minH = KScreenWidth / 12;
        CGFloat addW = KScreenWidth / 12;
        CGFloat gap = minH / 2;
        CGFloat y = (self.frame.size.height  - minH) / 2;
        
        self.minBtn = [[UIButton alloc]initWithFrame:CGRectMake(minH,  y, minW, minH)];
        self.minBtn.backgroundColor = [UIColor grayColor];
        [self.minBtn setTitle:@"最小" forState:UIControlStateNormal];
        self.minBtn.layer.cornerRadius = 3;
        [self.minBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.minBtn.enabled =  NO;
        [self.minBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.minBtn.tag =10000;
        [self addSubview:self.minBtn];
        
        self.maxBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - minH - minW, y, minW, minH)];
        self.maxBtn.backgroundColor = [UIColor redColor];
        [self.maxBtn setTitle:@"最大" forState:UIControlStateNormal];
        self.maxBtn.layer.cornerRadius = 3;
        [self.maxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.maxBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.maxBtn.tag =10001;
        [self addSubview:self.maxBtn];
        
        self.reduceBtn = [[UIButton alloc]initWithFrame:CGRectMake(minH + minW + gap, y, addW, addW)];
        [self.reduceBtn setBackgroundImage:[UIImage imageNamed:@"减-不可点"] forState:UIControlStateNormal];
        self.reduceBtn.enabled = NO;
        [self.reduceBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.reduceBtn.tag =10002;
        [self addSubview:self.reduceBtn];
        
        self.addBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - minH - minW - gap - addW, y, addW, addW)];
        [self.addBtn setBackgroundImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.addBtn.tag =10003;
        [self addSubview:self.addBtn];
        
        CGFloat labelW = KScreenWidth - 2*minH - 2*minW - 4*gap - 2*addW;
        self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(minH + minW + gap + addW + gap, y, labelW, minH)];
//        self.currentLabel.backgroundColor = [UIColor grayColor];
        self.currentLabel.layer.borderWidth = 1;
        self.currentLabel.layer.borderColor = [UIColor grayColor].CGColor;
        self.currentLabel.layer.cornerRadius = 5;
        self.currentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: self.currentLabel];
        
        self.foot = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - minH, KScreenWidth, minH)];
        self.foot.textColor = [UIColor lightGrayColor];
        self.foot.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.foot];
        
        // 添加KVO，监控currentLabel的值
        [self.currentLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

// KVO方法实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSString *new = [change objectForKey:@"new"];
    NSArray *nums = [new componentsSeparatedByString:@" "];
    NSInteger num = [nums[0] integerValue];
    if (num == self.minNum) {
        
        self.maxBtn.enabled = YES;
        self.maxBtn.backgroundColor = [UIColor redColor];
        self.addBtn.enabled = YES;
        [self.addBtn setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
        
        self.minBtn.enabled = NO;
        self.minBtn.backgroundColor = [UIColor grayColor];
        self.reduceBtn.enabled = NO;
        [self.reduceBtn setImage:[UIImage imageNamed:@"减-不可点"] forState:UIControlStateNormal];
        
    }else if(num == self.maxNum){
        
        self.maxBtn.enabled = NO;
        self.maxBtn.backgroundColor = [UIColor grayColor];
        self.addBtn.enabled = NO;
        [self.addBtn setImage:[UIImage imageNamed:@"加-不可点"] forState:UIControlStateNormal];
        
        self.minBtn.enabled = YES;
        self.minBtn.backgroundColor = [UIColor redColor];
        self.reduceBtn.enabled = YES;
        [self.reduceBtn setImage:[UIImage imageNamed:@"减"] forState:UIControlStateNormal];
        
    }else{
        self.minBtn.enabled = YES;
        self.minBtn.backgroundColor = [UIColor redColor];
        self.reduceBtn.enabled = YES;
        [self.reduceBtn setImage:[UIImage imageNamed:@"减"] forState:UIControlStateNormal];
        
        self.maxBtn.enabled = YES;
        self.maxBtn.backgroundColor = [UIColor redColor];
        self.addBtn.enabled = YES;
        [self.addBtn setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];

    }
}
- (void)buttonAction:(UIButton *)btn{
    NSInteger tag = btn.tag;
    if (tag == 10000) {
        self.currentNum = self.minNum;
        [self updateCurrentLabel];
    }else if (tag == 10001){
        self.currentNum = self.maxNum;
        [self updateCurrentLabel];
    }else if (tag == 10002){
        self.currentNum -= 1;
        [self updateCurrentLabel];
    }else if (tag == 10003){
        self.currentNum += 1;
        [self updateCurrentLabel];
    }
    
}
- (void)setMinNum:(NSInteger)minNum{
    _minNum = minNum;
     self.foot.text = [NSString stringWithFormat:@"最低出让数量%ld件，最高出让数量%ld件",_minNum, _maxNum];
    self.currentNum = minNum;
    [self updateCurrentLabel];
}
- (void)setMaxNum:(NSInteger)maxNum{
    _maxNum = maxNum;
     self.foot.text = [NSString stringWithFormat:@"最低出让数量%ld件，最高出让数量%ld件",_minNum, _maxNum];
}


- (void)updateCurrentLabel{
    self.currentLabel.text = [NSString stringWithFormat:@"%ld 件",self.currentNum];
    if (self.block) {
        self.block(self.currentNum);
    }
}














@end
