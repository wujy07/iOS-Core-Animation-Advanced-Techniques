//
//  ViewController.m
//  THULayerTest
//
//  Created by Junyan Wu on 17/1/6.
//  Copyright © 2017年 THU. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<CAAnimationDelegate>
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) CALayer *shipLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testKeyFrame];
}

- (void)testKeyFrame {
    //create a path
    self.bezierPath = [[UIBezierPath alloc] init];
    [self.bezierPath moveToPoint:CGPointMake(0, 150)];
    [self.bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    //add the ship
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = CGPointMake(0, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"ship.png"].CGImage;
   
    self.shipLayer.anchorPoint = CGPointMake(1, 0.5);
    
}
- (IBAction)change:(UIButton *)sender {
    if (self.shipLayer.superlayer == nil) {
         [self.containerView.layer addSublayer:self.shipLayer];
    }
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = self.bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    [self.shipLayer addAnimation:animation forKey:nil];
}






@end
