//
//  HLImageView.m
//  3DWheelImage
//
//  Created by HL on 17/3/4.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "HLImageView.h"

@interface HLImageView ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation HLImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        
        _posiP = self.layer.position;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h / 2.0)];
        [self addSubview:_imgView];
        
        CAReplicatorLayer *repL =  (CAReplicatorLayer *)self.layer;
        repL.instanceCount = 2;
        //复制出来的子层,它都是绕着复制层锚点进行旋转.
        repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        
        repL.instanceRedOffset -= 0.5;
        repL.instanceGreenOffset -= 0.5;
        repL.instanceBlueOffset -= 0.5;
        repL.instanceAlphaOffset -= 0.5;
        
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imgView.image = image;
}

//返回当前layer的类型
+ (nonnull Class)layerClass{
    return [CAReplicatorLayer class];
}

@end
