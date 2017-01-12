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
@property (nonatomic, strong) UIView *coverView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)testCustomTransition {
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.coverView = [[UIImageView alloc] initWithImage:coverImage];
    self.coverView.frame = self.view.bounds;
    [self.view addSubview:self.coverView];
    
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (IBAction)change:(UIButton *)sender {
    //add the animation to the color layer
    //perform animation (anything you like)
    if (!self.coverView.superview) {
        self.coverView.alpha = 1;
        [self.view addSubview:self.coverView];
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
        self.coverView.transform = transform;
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.coverView.transform = transform;
        self.coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [self.coverView removeFromSuperview];
    }];
}






@end
