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
@property (nonatomic, strong) CAAnimationGroup *groupAnimation;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testKeyFrame];
}

- (void)testKeyFrame {
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.containerView.layer addSublayer:colorLayer];
    
    //add the ship
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 20, 20);
    self.shipLayer.position = CGPointMake(64, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"ship.png"].CGImage;
    [self.containerView.layer addSublayer:_shipLayer];
    
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animation];
    anim1.keyPath = @"position";
    anim1.path = bezierPath.CGPath;
    anim1.rotationMode = kCAAnimationRotateAuto;
    
    //create the color animation
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.values = @[(__bridge id)[UIColor redColor].CGColor,
                          (__bridge id)[UIColor greenColor].CGColor,
                          (__bridge id)[UIColor blueColor].CGColor];
    //create group animation
    self.groupAnimation = [CAAnimationGroup animation];
    self.groupAnimation.animations = @[anim1, animation2];
    self.groupAnimation.duration = 4.0;
    
    
}
- (IBAction)change:(UIButton *)sender {
    //add the animation to the color layer
    [self.shipLayer addAnimation:self.groupAnimation forKey:nil];
}






@end
