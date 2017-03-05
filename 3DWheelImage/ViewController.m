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
    
    HL3DWheelImage *wheel = [[HL3DWheelImage alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
    
    [self.view addSubview:wheel];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
