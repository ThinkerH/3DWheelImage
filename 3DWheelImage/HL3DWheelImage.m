//
//  HL3DWheelImage.m
//  3DWheelImage
//
//  Created by HL on 17/3/4.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "HL3DWheelImage.h"
//#import "HLScrollView.h"
#import "HLImageView.h"

#define imgCount 5 // 图片个数

@interface HL3DWheelImage ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *imageWheel;
@property (nonatomic, strong) NSMutableArray *imgViews;
@property (nonatomic, strong) UIPageControl *pC;

@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end

@implementation HL3DWheelImage

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _w = frame.size.width;
        _h = _w / 2.0;
        
        _imageWheel = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _w, _w)];
        _imageWheel.contentSize = CGSizeMake(_w * (imgCount + 2), _h);
        _imageWheel.pagingEnabled = YES;
        _imageWheel.backgroundColor = [UIColor grayColor];
        _imageWheel.delegate = self;
        [self addSubview:_imageWheel];
        
        _imgViews = [NSMutableArray array];
        
        
        
        for (int i = 0; i < imgCount + 2; i++) {
            HLImageView *image = [[HLImageView alloc] initWithFrame:CGRectMake(_w * i, 0, _w, _h * 2)];
            if (i == 0) {
                image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",imgCount]];
            } else if (i == imgCount + 1) {
                image.image = [UIImage imageNamed:@"1"];
            } else {
                image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            }
            if (i != 1 && i != imgCount) {
                CATransform3D transform = CATransform3DIdentity;
                CGFloat angle = M_PI_2;
                image.layer.anchorPoint = CGPointMake(1, 0.5);
                image.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
            }
            
            [_imgViews addObject:image];
            
            [_imageWheel addSubview:image];
        }
        
        _imageWheel.contentOffset = CGPointMake(_w, 0);
        
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat c = ceilf(scrollView.contentOffset.x / _w);
    
    if (c > 0 && c < _imgViews.count) {
        CGFloat value = (scrollView.contentOffset.x - (c - 1) * _w) / _w; // 滑动时的值范围0~1
        
        // 当前展示图的实时旋转角度
        CGFloat angle0 = M_PI_2 * value;
        
        // 当前展示的图
        HLImageView *img0 = (HLImageView *)_imgViews[(int)c - 1];
        img0.layer.anchorPoint = CGPointMake(0.0, 0.5);
        img0.layer.position = CGPointMake(img0.posiP.x - img0.frame.size.width / 2.0 * (1 - value),img0.posiP.y);
        
        // 设置3D旋转效果
        CATransform3D transform0 = CATransform3DIdentity;
        transform0.m34 = -1 / 550.0;
        img0.layer.transform = CATransform3DRotate(transform0, angle0, 0, 1, 0);
        
        // 当前展示图后一张图的实时旋转角度
        CGFloat angle1 = M_PI_2 * (1 - value);
        
        // 当前展示图的后一张图
        HLImageView *img1 = (HLImageView *)_imgViews[(int)c];
        img1.layer.anchorPoint = CGPointMake(1.0, 0.5);
        img1.layer.position = CGPointMake(img1.posiP.x + img1.frame.size.width / 2.0 * value, img1.posiP.y);
        
        //设置3D旋转效果
        CATransform3D transform1 = CATransform3DIdentity;
        transform1.m34 = -1 / 550.0;
        
        img1.layer.transform = CATransform3DRotate(transform1, -angle1, 0, 1, 0);
        
        
        NSLog(@"===========:%f--------:%f=========:%f",scrollView.contentOffset.x,c,value);
    }
    
    
    if (scrollView.contentOffset.x == _w * (_imgViews.count - 1)) {
        
        HLImageView *firstImg = (HLImageView *)_imgViews[1];
        firstImg.layer.transform = CATransform3DIdentity;
        
        scrollView.contentOffset = CGPointMake(_w, 0);
    } else if (scrollView.contentOffset.x == 0) {
        
        HLImageView *lastImg = (HLImageView *)_imgViews[imgCount];
        lastImg.layer.transform = CATransform3DIdentity;
        
        scrollView.contentOffset = CGPointMake(_w * imgCount, 0);
    }
}


@end
