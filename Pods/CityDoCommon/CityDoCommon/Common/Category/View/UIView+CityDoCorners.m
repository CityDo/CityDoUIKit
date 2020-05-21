//
//  UIView+CityDoCorners.m
//  CityDoCommon
//
//  Created by CityDoWCY on 2020/5/20.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "UIView+CityDoCorners.h"

@implementation UIView (CityDoCorners)

- (void)useBezierPathClipCornerWithType:(CDCornerRadiusType)cornerType WithCornerRadius:(CGFloat)cornerRadius {
    
    [self makeCornerWithMaskPath:[self getBezierPathWithUILayoutCornerType:cornerType WithCornerRadius:cornerRadius]];
}

- (void)useBezierPathClipCornerWithType:(CDCornerRadiusType)cornerType WithCornerRadius:(CGFloat)cornerRadius WithColor:(UIColor *)color withBorderWidth:(CGFloat)width{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = [[self getBezierPathWithUILayoutCornerType:cornerType WithCornerRadius:cornerRadius] CGPath];
    shapeLayer.lineWidth = width;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    
    [self useBezierPathClipCornerWithType:cornerType WithCornerRadius:cornerRadius];
}

#pragma mark - 添加边框
- (void)useCALayerMakeBorderLineWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    self.layer.borderColor = color.CGColor;//设置边框颜色
    self.layer.borderWidth = width;//设置边框颜色
}

#pragma mark - 私有处理方法
- (UIBezierPath *)getBezierPathWithUILayoutCornerType:(CDCornerRadiusType)cornerType WithCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *maskPath;
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    
    switch (cornerType) {
            // 四个角全切
        case CDCornerRadiusTypeAll:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerAllCorners
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
            // 三个角
        case CDCornerRadiusTypeExceptTopLeft:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeExceptTopRight:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeExceptBottomLeft:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerTopLeft|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeExceptBottomRight:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerTopLeft)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
            // 两个角
        case CDCornerRadiusTypeTop:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeLeft:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeRight:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeBottom:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
            // 一个角
        case CDCornerRadiusTypeTopLeft:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeTopRight:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeBottomLeft:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeBottomRight:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
            // 对角线
        case CDCornerRadiusTypeTopLeftToBottomRight:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        case CDCornerRadiusTypeTopRightToBottomLeft:{
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomLeft)
                                                   cornerRadii:cornerSize];
            
        }
            break;
            
        default: {
            
        }
            break;
            
    }
    
    return maskPath;
}

- (void)makeCornerWithMaskPath:(UIBezierPath *)maskPath {
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


@end
