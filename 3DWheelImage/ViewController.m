//
//  ViewController.m
//  3DWheelImage
//
//  Created by HL on 17/3/4.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "ViewController.h"
#import "HL3DWheelImage.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        HL3DWheelModel *model = [[HL3DWheelModel alloc] init];
        model.imgUrl = [NSString stringWithFormat:@"%d",i + 1];
        model.tapUrl = [NSString stringWithFormat:@"图片的HTMLurl,点击浏览对应文章----:%d",i + 1];
        [images addObject:model];
    }
    
    HL3DWheelImage *wheel = [[HL3DWheelImage alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
    wheel.imagesArr = [images mutableCopy];
    wheel.tapImgBlock = ^(HL3DWheelModel *model) {
        NSLog(@"%@",model.tapUrl);
    };
    [self.view addSubview:wheel];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
