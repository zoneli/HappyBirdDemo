//
//  FirstViewController.m
//  Demo
//
//  Created by lyz1 on 2018/11/8.
//  Copyright © 2018 lyz. All rights reserved.
//  此界面为app 主界面

#import "FirstViewController.h"
#import "PopImageView.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *modelArray;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self createMainTableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavLabelText:@"浏览页"];
}
- (void)initDataSource {
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:20];
    for (int i=0; i<16; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",i+1] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        if (image) {
            [_dataArray addObject:image];
        }        
    }
    _modelArray = [[NSMutableArray alloc] initWithCapacity:10];
    if (_dataArray.count%2!=0) {
        for (int i=0; i<_dataArray.count/2+1; i++) {
            UIImage *lImage = [_dataArray objectAtIndex:i*2];
            if (i==_dataArray.count/2) {
                UIImage *rImage = nil;
                HeighModel *model = [self getSizeWithImage:lImage RightImage:rImage];
                [_modelArray addObject:model];

            }else {
                UIImage *rImage = [_dataArray objectAtIndex:i*2+1];
                HeighModel *model = [self getSizeWithImage:lImage RightImage:rImage];
                [_modelArray addObject:model];
            }
            
        }

    }else {
        for (int i=0; i<_dataArray.count/2; i++) {
            UIImage *lImage = [_dataArray objectAtIndex:i*2];
            UIImage *rImage = [_dataArray objectAtIndex:i*2+1];
            HeighModel *model = [self getSizeWithImage:lImage RightImage:rImage];
            [_modelArray addObject:model];
            
        }

    }
    
}
- (void)createMainTableView {
  
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
        _mainTableView.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0];
        [self.view addSubview:_mainTableView];
    }
    
}
- (HeighModel *)getSizeWithImage:(UIImage *)image RightImage:(UIImage*)rightImage{
    
    HeighModel *model = [[HeighModel alloc] init];
    
    float h=0;
    float lwidth = image.size.width;
    float lheight = image.size.height;
    float rwidth = 0;
    float rheight = 0;
    if (rightImage == nil) {
        rwidth = image.size.width;
        rheight = image.size.height;

    }else {
        rwidth = rightImage.size.width;
        rheight = rightImage.size.height;

    }
    float z1 = lwidth/lheight;
    float z2 = rwidth/rheight;
    h = (self.view.frame.size.width-30)/(z1+z2);
    float lrWidth = z1*h;
    float rrWidth = z2*h;
    model.height = h;
    model.lWidth = lrWidth;
    model.rWidth = rrWidth;
    return model;
    
}
- (void)lTapClick:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    UITableViewCell *cell = (UITableViewCell *)[imageView superview];
    NSIndexPath *indexPath = [_mainTableView indexPathForCell:cell];
    
    CGRect rectInTable = [_mainTableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSelfview = [_mainTableView convertRect:rectInTable toView:self.view];
    CGRect lRect = CGRectMake(rectInSelfview.origin.x+10, rectInSelfview.origin.y+10, rectInSelfview.size.width, rectInSelfview.size.height);
    PopImageView *popView = [[PopImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
  
    [self.view.window addSubview:popView ];
    [popView loadImageView:imageView ImageRect:lRect];

}
- (void)rTapClick:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    UITableViewCell *cell = (UITableViewCell *)[imageView superview];
    NSIndexPath *indexPath = [_mainTableView indexPathForCell:cell];
    
    CGRect rectInTable = [_mainTableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSelfview = [_mainTableView convertRect:rectInTable toView:self.view];
    CGRect rRect = CGRectMake(self.view.frame.size.width-10-imageView.frame.size.width, rectInSelfview.origin.y+10, rectInSelfview.size.width, rectInSelfview.size.height);

    PopImageView *popView = [[PopImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view.window addSubview:popView];
    [popView loadImageView:imageView ImageRect:rRect];

}

#pragma mark tableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count%2==0) {
        return _dataArray.count/2;
    }
    return _dataArray.count/2+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    // 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UIImageView *leftImageView = [[UIImageView alloc] init];
        leftImageView.userInteractionEnabled = YES;
        leftImageView.layer.cornerRadius = 5.0;
        leftImageView.clipsToBounds = YES;
        leftImageView.frame = CGRectMake(10, 10, (self.view.frame.size.width-30)/2, 80);
        leftImageView.tag = 2001;        
        [cell addSubview:leftImageView];
        
        
        UITapGestureRecognizer *lTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lTapClick:)];
        lTapGesture.numberOfTapsRequired = 1;
        lTapGesture.numberOfTouchesRequired = 1;
        [leftImageView addGestureRecognizer:lTapGesture];
        

        UIImageView *rightImageView = [[UIImageView alloc] init];
        rightImageView.userInteractionEnabled = YES;
        rightImageView.layer.cornerRadius = 5.0;
        rightImageView.clipsToBounds = YES;
        rightImageView.frame = CGRectMake(20+(self.view.frame.size.width-30)/2, 10, (self.view.frame.size.width-30)/2, 80);
        rightImageView.tag = 2002;
        rightImageView.backgroundColor = [UIColor clearColor];
        [cell addSubview:rightImageView];

        UITapGestureRecognizer *rTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rTapClick:)];
        rTapGesture.numberOfTapsRequired = 1;
        rTapGesture.numberOfTouchesRequired = 1;
        [rightImageView addGestureRecognizer:rTapGesture];

        
    }
    
    UIImageView *lView = [cell viewWithTag:2001];
    UIImageView *rView = [cell viewWithTag:2002];
    UIImage *lImage = [_dataArray objectAtIndex:indexPath.row*2];
    UIImage *rImage =nil;
    if (_dataArray.count%2!=0) {
        if (indexPath.row==_dataArray.count/2) {
            rImage =nil;
            
        }else {
            rImage = [_dataArray objectAtIndex:indexPath.row*2+1];

        }
    }else {
            rImage = [_dataArray objectAtIndex:indexPath.row*2+1];
    }
    
    lView.image = lImage;
    rView.image = rImage;
    HeighModel *model = [_modelArray objectAtIndex:indexPath.row];

    lView.frame = CGRectMake(lView.frame.origin.x, lView.frame.origin.y, model.lWidth, model.height);
    rView.frame = CGRectMake(20+model.lWidth, rView.frame.origin.y, model.rWidth, model.height);
    
    return cell;
    
}
#pragma mark tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeighModel *model = [_modelArray objectAtIndex:indexPath.row];
    return model.height+20;
}

@end

@implementation HeighModel



@end

