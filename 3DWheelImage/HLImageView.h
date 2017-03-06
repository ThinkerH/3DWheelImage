//
//  HLImageView.h
//  3DWheelImage
//
//  Created by HL on 17/3/4.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HL3DWheelModel.h"

typedef void(^TapClickImgBlock)(HL3DWheelModel *model);

@interface HLImageView : UIView
@property (nonatomic, assign) CGPoint posiP;
@property (nonatomic, strong) HL3DWheelModel *model;

@property (nonatomic, copy) TapClickImgBlock tapClickBlock;

@end
