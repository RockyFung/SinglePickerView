//
//  WaresNumberView.h
//  FJPickerVIew
//
//  Created by rocky on 16/5/17.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBlock)(NSInteger currentNum);

@interface WaresNumberView : UIView
@property (nonatomic, assign) NSInteger minNum;
@property (nonatomic, assign) NSInteger maxNum;
@property (nonatomic, assign) NSInteger currentNum;
@property (nonatomic, copy) SelectBlock block;
@end
