//
//  FJSinglePickerView.h
//  xiaochunlaile
//
//  Created by rocky on 16/3/30.
//  Copyright © 2016年 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FJSinglePickerView : UIView

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;


@end
