//
//  FJWaresNumberPicker.h
//  FJPickerVIew
//
//  Created by rocky on 16/5/12.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FJWaresNumberPickerDelegate <NSObject>

- (void)selectedNumber:(NSInteger)number;

@end
@interface FJWaresNumberPicker : UIView
@property (nonatomic, assign) id<FJWaresNumberPickerDelegate> delegate;
- (instancetype)initWithMinNum:(NSInteger)minNum MaxNum:(NSInteger)maxNum;
- (void)show;
@end
