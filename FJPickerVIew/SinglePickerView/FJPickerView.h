//
//  FJPickerView.h
//  FJPickerVIew
//
//  Created by rocky on 16/3/31.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerViewSelectBlock)(NSString *item);

@interface FJPickerView : UIView

@property (nonatomic, strong) NSArray *arrayDataSource;
- (void)didFinishSelectedItem:(PickerViewSelectBlock)selectBlock;
@end
