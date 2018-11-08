//
//  PopImageView.m
//  Demo
//
//  Created by lyz1 on 2018/11/8.
//  Copyright © 2018 lyz. All rights reserved.
//

#import "PopImageView.h"
@interface PopImageView ()
@property (nonatomic,strong)UIImageView *loadImageView;
@property (nonatomic)CGRect oldRect;
@end

@implementation PopImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
       
        UITapGestureRecognizer *lTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(distapClick:)];
        lTapGesture.numberOfTapsRequired = 1;
        lTapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:lTapGesture];

        
    }
    return self;

}
-(void)distapClick:(UITapGestureRecognizer *)tap {
  
    __weak typeof(self) weakSelf = self;

    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        weakSelf.loadImageView.frame = weakSelf.oldRect;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
- (void)loadImageView:(UIImageView *)imageView ImageRect:(CGRect)rect {
   
    if (imageView) {
        if (_loadImageView) {
            _loadImageView = nil;
        }
       _loadImageView = [[UIImageView alloc]init];
        _loadImageView.image = imageView.image;
        _loadImageView.frame = CGRectMake(rect.origin.x, rect.origin.y, self.frame.size.width, self.frame.size.width*_loadImageView.image.size.height/_loadImageView.image.size.width);
        _oldRect = _loadImageView.frame;
        __weak typeof(self) weakSelf = self;
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            weakSelf.loadImageView.center = self.center;
        } completion:nil];

        _loadImageView.userInteractionEnabled = NO;
        [self addSubview:_loadImageView];
        
    }
    
}
@end
