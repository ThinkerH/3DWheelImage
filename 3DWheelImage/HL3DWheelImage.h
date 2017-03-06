//
//  HL3DWheelImage.h
//  3DWheelImage
//
//  Created by HL on 17/3/4.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HL3DWheelModel.h"

typedef void(^TapImgBlcok)(HL3DWheelModel *model);

@interface HL3DWheelImage : UIView

@property (nonatomic, strong) NSMutableArray *imagesArr;//图片数据模型数组

@property (nonatomic, copy) TapImgBlcok tapImgBlock;

- (void)startAni;

- (void)stopAni;
@end
