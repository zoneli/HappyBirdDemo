//
//  FeatureView.m
//  Demo
//
//  Created by lyz1 on 2018/11/8.
//  Copyright © 2018 lyz. All rights reserved.
//
#import "FeatureView.h"
#import <WebKit/WebKit.h>

@implementation FeatureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews {
   
    UILabel *infolabel = [[UILabel alloc] init];
    infolabel.textAlignment = NSTextAlignmentCenter;
    infolabel.numberOfLines = 0;
    infolabel.backgroundColor = [UIColor clearColor];
    infolabel.font = [UIFont systemFontOfSize:17.0];
    infolabel.text = @"一个生活丰富者不在客观的见过若干事物，而在能主观的激发很复杂，很不同的情感，和能够同情于人性的许多方面的人。";
    NSDictionary *attributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    CGSize labelSize = [infolabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width-40, 5000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributeDic context:nil].size;
    infolabel.frame =CGRectMake(20, 0, self.frame.size.width-40, labelSize.height);
    infolabel.center = CGPointMake(self.center.x, self.center.y*0.62);
    [self addSubview:infolabel];
 

    NSString *svgPath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"svg"];
    NSData *svgData = [NSData dataWithContentsOfFile:svgPath];
    NSString *reasourcePath = [[NSBundle mainBundle] resourcePath];
    NSURL *baseUrl = [[NSURL alloc] initFileURLWithPath:reasourcePath isDirectory:true];    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    webView.backgroundColor = [UIColor clearColor];
    
    //找不到合适的svg素材 所以这么写一下
    [webView setOpaque:NO];
    webView.scrollView.scrollEnabled = NO;
    webView.userInteractionEnabled = NO;
    
    webView.center = CGPointMake(self.center.x, self.center.y*0.62+infolabel.frame.size.height+140);
    [webView loadData:svgData MIMEType:@"image/svg+xml" characterEncodingName:@"UTF-8" baseURL:baseUrl];
    [self addSubview:webView];
    
    
}
@end
