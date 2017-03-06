//
//  HL3DWheelImage.m
//  3DWheelImage
//
//  Created by HL on 17/3/4.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "HL3DWheelImage.h"
#import "HLImageView.h"
//#import "UIImageView+WebCache.h"


@interface HL3DWheelImage ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *imageWheel;
@property (nonatomic, strong) NSMutableArray *imgViews;
@property (nonatomic, strong) UIPageControl *pC;

@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@property (nonatomic, strong) NSTimer *scroTimer;

@property (nonatomic, assign) int imgIndex;

@end

@implementation HL3DWheelImage

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _w = frame.size.width;
        _h = frame.size.height;
        
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _w, _h)];
        backImg.image = [UIImage imageNamed:@"AD_background"];
        [self addSubview:backImg];
        
        _imageWheel = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _w, _h)];
        _imageWheel.pagingEnabled = YES;
        _imageWheel.showsHorizontalScrollIndicator = NO;
        _imageWheel.backgroundColor = [UIColor clearColor];
        //        _imageWheel.layer.shadowColor = BLACK_TEXT_COLOR.CGColor;
        //        _imageWheel.layer.shadowOffset = CGSizeMake(0, 0);
        //        _imageWheel.layer.shadowOpacity = 5.0;
        //        _imageWheel.layer.shadowRadius = 7.0;
        [self addSubview:_imageWheel];
        
        _imgViews = [NSMutableArray array];
        
        _pC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _h - 20, _w, 20)];
        _pC.currentPageIndicatorTintColor = [UIColor redColor];
        _pC.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pC];
        
    }
    return self;
}

- (void)startAni {
    if (!_scroTimer) {
        
        _scroTimer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(runPage)userInfo:nil repeats:YES];
        
        [[NSRunLoop  currentRunLoop] addTimer:_scroTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)stopAni {
    if (_scroTimer) {
        [_scroTimer invalidate];
        _scroTimer = nil;
    }
}

- (void)setImagesArr:(NSMutableArray *)imagesArr {
    
    _imagesArr = imagesArr;
    
    if (_imagesArr.count != 0) {
        
        _pC.numberOfPages = imagesArr.count;
        
        for (HLImageView *removeImg in _imgViews) {
            [removeImg removeFromSuperview];
        }
        
        [_imgViews removeAllObjects];
        
        _imageWheel.delegate = self;
        
        __weak __typeof(self) weakSelf = self;
        for (int i = 0; i < _imagesArr.count + 2; i++) {
            HLImageView *image = [[HLImageView alloc] initWithFrame:CGRectMake(_w * i, 0, _w, _h)];
            image.tapClickBlock = ^(HL3DWheelModel *model) {
                if (weakSelf.tapImgBlock) {
                    weakSelf.tapImgBlock(model);
                }
            };
            if (i == 0) {
                HL3DWheelModel *model = _imagesArr[_imagesArr.count - 1];
                image.model = model;
            } else if (i == _imagesArr.count + 1) {
                HL3DWheelModel *model = _imagesArr[0];
                image.model = model;
            } else {
                HL3DWheelModel *model = _imagesArr[i - 1];
                image.model = model;
            }
            if (i != 1 && i != _imagesArr.count) {
                CATransform3D transform = CATransform3DIdentity;
                CGFloat angle = M_PI_2;
                image.layer.anchorPoint = CGPointMake(1, 0.5);
                image.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
            }
            
            [_imgViews addObject:image];
            
            [_imageWheel addSubview:image];
        }
        
        _imageWheel.contentSize = CGSizeMake(_w * (_imagesArr.count + 2), _h);
        
        _imageWheel.contentOffset = CGPointMake(_w, 0);
        
        [self startAni];
    }
}

- (void)runPage {
    
    _imgIndex++;
    
    if (_imgIndex == _imagesArr.count) {
        _imgIndex = 0;
    }
    
    if (_imgIndex != 0) {
        
        [_imageWheel scrollRectToVisible:CGRectMake(_w * (_imgIndex + 1), 0, _w, _h) animated:YES];
        
    } else {
        [_imageWheel scrollRectToVisible:CGRectMake(_w * (_imagesArr.count + 1), 0, _w, _h) animated:YES];
    }
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
        
        _pC.currentPage = (int)(c - 1);
        _imgIndex = (int)_pC.currentPage;
        
        //        [_imageWheel bringSubviewToFront:img1];
        
        //        HLOG(@"--------------:%f========:%f",scrollView.contentOffset.x,_w * c)
    }
    
    if (scrollView.contentOffset.x == _w * (_imgViews.count - 1)) {
        
        HLImageView *firstImg = (HLImageView *)_imgViews[1];
        firstImg.layer.transform = CATransform3DIdentity;
        
        scrollView.contentOffset = CGPointMake(_w, 0);
    } else if (scrollView.contentOffset.x == 0) {
        
        HLImageView *lastImg = (HLImageView *)_imgViews[_imagesArr.count];
        lastImg.layer.transform = CATransform3DIdentity;
        
        scrollView.contentOffset = CGPointMake(_w * _imagesArr.count, 0);
    }
    
}


@end
