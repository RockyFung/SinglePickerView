//
//  FJWaresNumberPicker.h
//  FJPickerVIew
//
//  Created by rocky on 16/5/12.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WaresNumSelectBlock)(NSInteger num);

@interface FJWaresNumberPicker : UIView

- (instancetype)initWithMinNum:(NSInteger)minNum MaxNum:(NSInteger)maxNum;
- (void)show;
- (void)selectFinish:(WaresNumSelectBlock)block;
@end
