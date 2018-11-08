//
//  PopImageView.h
//  Demo
//
//  Created by lyz1 on 2018/11/8.
//  Copyright © 2018 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopImageView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
- (void)loadImageView:(UIImageView *)imageView ImageRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
