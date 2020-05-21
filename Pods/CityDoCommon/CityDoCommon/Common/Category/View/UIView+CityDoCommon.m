//
//  UIView+CityDoCommon.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "UIView+CityDoCommon.h"
#import <objc/runtime.h>

@interface UIView()

@property (nonatomic, strong)CAGradientLayer *cd_backgroundColorsLayer;

@property (nonatomic, strong)UILabel *cd_colorsLabel;
@property (nonatomic, strong)CAGradientLayer *cd_colorLabelLayer;

@end

@implementation UIView (CityDoCommon)
// [GET方法]

- (CGFloat)cd_x{
    return self.frame.origin.x;
}

- (CGFloat)cd_y{
    return self.frame.origin.y;
}

- (CGFloat)cd_w{
    return self.frame.size.width;
}

- (CGFloat)cd_h{
    return self.frame.size.height;
}

- (CGFloat)cd_centerX{
    return self.center.x;
}

- (CGFloat)cd_centerY{
    return self.center.y;
}
- (CGFloat)cd_top{
    return self.cd_y;
}
- (CGFloat)cd_left{
    return self.cd_x;
}
- (CGFloat)cd_bottom{
    return (self.cd_y + self.cd_h);
}
- (CGFloat)cd_right{
    return (self.cd_x + self.cd_w);
}
- (CGSize)cd_size{
    return self.frame.size;
}
- (CGPoint)cd_origin{
    return self.frame.origin;
}
// [SET方法]

- (void)setCd_x:(CGFloat)cd_x{
    self.frame = CGRectMake(cd_x, self.cd_y, self.cd_w, self.cd_h);
}

- (void)setCd_y:(CGFloat)cd_y{
    self.frame = CGRectMake(self.cd_x, cd_y, self.cd_w, self.cd_h);
}

- (void)setCd_w:(CGFloat)cd_w{
    self.frame = CGRectMake(self.cd_x, self.cd_y, cd_w, self.cd_h);
}

- (void)setCd_h:(CGFloat)cd_h{
    self.frame = CGRectMake(self.cd_x, self.cd_y, self.cd_w, cd_h);
}

- (void)setCd_centerX:(CGFloat)cd_centerX{
    self.center = CGPointMake(cd_centerX, self.cd_centerY);
}

- (void)setCd_centerY:(CGFloat)cd_centerY{
    self.center = CGPointMake(self.cd_centerX, cd_centerY);
}
- (void)setCd_size:(CGSize)cd_size{
    self.frame = CGRectMake(self.cd_x, self.cd_y, cd_size.width, cd_size.height);
}
- (void)setCd_origin:(CGPoint)cd_origin{
    self.frame = CGRectMake(cd_origin.x, cd_origin.y, self.cd_w, self.cd_h);
}

#pragma mark [layer]

- (CGFloat)cd_cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setCd_cornerRadius:(CGFloat)cd_cornerRadius{
    self.layer.cornerRadius = cd_cornerRadius;
    self.layer.masksToBounds = YES;
}

static char *cdBackgroundColorsLayerKey = "cdBackgroundColorsLayerKey";

- (CAGradientLayer *)cd_backgroundColorsLayer {
    return objc_getAssociatedObject(self, cdBackgroundColorsLayerKey);
}

- (void)setCd_backgroundColorsLayer:(CAGradientLayer *)cd_backgroundColorsLayer {
    objc_setAssociatedObject(self, cdBackgroundColorsLayerKey, cd_backgroundColorsLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<UIColor *> *)cd_backgroundColors {
    return nil;
}
- (void)setCd_backgroundColors:(NSArray<UIColor *> *)cd_backgroundColors {
    if (cd_backgroundColors == nil) {
        [self cd_clearColors];
    }else {
        [self cd_clearColors];
        self.cd_backgroundColorsLayer = [self cd_getColorsLayer:cd_backgroundColors frame:self.bounds isHorizontal:YES];
        [self.layer insertSublayer:self.cd_backgroundColorsLayer atIndex:0];
        [self cd_addFrameObserver];
    }
    
}

#pragma mark - textColors
static char *cdColorsLabelKey = "cdColorsLabelKey";

- (UILabel *)cd_colorsLabel {
    return objc_getAssociatedObject(self, cdColorsLabelKey);
}

- (void)setCd_colorsLabel:(UILabel *)cd_colorsLabel {
    objc_setAssociatedObject(self, cdColorsLabelKey, cd_colorsLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *cdColorLabelLayerKey = "cdColorLabelLayerKey";

- (CAGradientLayer *)cd_colorLabelLayer {
    return objc_getAssociatedObject(self, cdColorLabelLayerKey);
}

- (void)setCd_colorLabelLayer:(CAGradientLayer *)cd_colorLabelLayer {
    objc_setAssociatedObject(self, cdColorLabelLayerKey, cd_colorLabelLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSArray<UIColor *> *)cd_textColors {
    return nil;
}

- (void)setCd_textColors:(NSArray<UIColor *> *)cd_textColors {
    
    if (![self isKindOfClass:[UILabel class]]) {
        
        NSLog(@"cdCommon setcd_textColors error: this is not label");
    } else {
        
        if (cd_textColors == nil && self.cd_colorLabelLayer) {
            [self.cd_colorsLabel removeFromSuperview];
            [self.cd_colorLabelLayer removeFromSuperlayer];
            [self cd_removeColorsTextObserver];
            return;
        }
        
        ((UILabel *)self).textColor = UIColor.clearColor;
        self.cd_colorsLabel = [[UILabel alloc]initWithFrame:self.bounds];
        self.cd_colorsLabel.font = ((UILabel *)self).font;
        self.cd_colorsLabel.text = ((UILabel *)self).text;
        self.cd_colorsLabel.textAlignment = ((UILabel *)self).textAlignment;
        [self addSubview:self.cd_colorsLabel];
        self.cd_colorLabelLayer = [self cd_getColorsLayer:cd_textColors frame:self.bounds isHorizontal:NO];
        [self.layer addSublayer:self.cd_colorLabelLayer];
        self.cd_colorLabelLayer.mask = self.cd_colorsLabel.layer;
        [self cd_addColorsTextObserver];
    }
    
}

#pragma mark [method]

- (CAGradientLayer *)cd_getColorsLayer:(NSArray *)colors frame:(CGRect)frame isHorizontal:(BOOL)isHorizontal {
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    [layer setFrame:frame];
    NSMutableArray *arr = [NSMutableArray array];
    for (UIColor *color in colors) {
        [arr addObject:(__bridge id)color.CGColor];
    }
    [layer setColors:arr];
    [layer setStartPoint:CGPointMake(0.0, 0.0)];
    if (isHorizontal) {
        [layer setEndPoint:CGPointMake(1.0, 0.0)];
    }else {
        [layer setEndPoint:CGPointMake(0.0, 1.0)];
    }
    return layer;
}

- (void)cd_clearColors {
    if (self.cd_backgroundColorsLayer) {
        [self cd_removeFrameObserver];
        [self.cd_backgroundColorsLayer removeFromSuperlayer];
        self.cd_backgroundColorsLayer = nil;
    }
}

#pragma mark - KVO
- (void)cd_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        
        if (self.cd_colorsLabel) {
            
            UILabel *this = (UILabel *)self;
            self.cd_colorsLabel.frame = this.bounds;
            self.cd_colorLabelLayer.frame = this.bounds;
        }
        if (self.cd_backgroundColorsLayer) {
            
            self.cd_backgroundColorsLayer.frame = self.bounds;
        }
    } else if ([keyPath isEqualToString:@"font"]) {
        
        UILabel *this = (UILabel *)self;
        self.cd_colorsLabel.font = this.font;
        
    } else if ([keyPath isEqualToString:@"text"]) {
        
        UILabel *this = (UILabel *)self;
        self.cd_colorsLabel.text = this.text;
    } else if ([keyPath isEqualToString:@"textAlignment"]) {
        
        UILabel *this = (UILabel *)self;
        self.cd_colorsLabel.textAlignment = this.textAlignment;
    }  else if ([keyPath isEqualToString:@"textColor"]) {
        
        [self removeObserver:self forKeyPath:@"textColor"];
        UILabel *this = (UILabel *)self;
        this.textColor = UIColor.clearColor;
        [self addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
    }
}

// frame

- (void)cd_addFrameObserver {
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)cd_addColorsTextObserver {
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"textAlignment" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)cd_removeColorsTextObserver {
    
    if (self.cd_colorLabelLayer) {
        
        [self removeObserver:self forKeyPath:@"frame"];
        [self removeObserver:self forKeyPath:@"font"];
        [self removeObserver:self forKeyPath:@"text"];
        [self removeObserver:self forKeyPath:@"textAlignment"];
        [self removeObserver:self forKeyPath:@"textColor"];
    }
}

- (void)cd_removeFrameObserver {
    
    if (self.cd_backgroundColorsLayer) {
        
        [self removeObserver:self forKeyPath:@"frame"];
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        Method setTextMethod = class_getInstanceMethod(class, NSSelectorFromString(@"dealloc"));
        Method replaceSetTextMethod = class_getInstanceMethod(class, NSSelectorFromString(@"cd_dealloc"));
        method_exchangeImplementations(setTextMethod, replaceSetTextMethod);
        
        Method observeMethod = class_getInstanceMethod(class, @selector(observeValueForKeyPath:ofObject:change:context:));
        Method replaceObserveMethod = class_getInstanceMethod(class, @selector(cd_observeValueForKeyPath:ofObject:change:context:));
        method_exchangeImplementations(observeMethod, replaceObserveMethod);
        
    });
}

- (void)cd_dealloc {
    
    [self cd_removeColorsTextObserver];
    [self cd_removeFrameObserver];
}

#pragma mark Gesture

static char *CDSingleTapGestureKey = "CDSingleTapGestureKey";
static char *CDDoubleTapGestureKey = "CDDoubleTapGestureKey";
static char *CDLongPressGestureKey = "CDLongPressGestureKey";

static char *CDSingleCallBackKey = "CDSingleCallBackKey";
static char *CDDoubleCallBackKey = "CDDoubleCallBackKey";
static char *CDLongPressCallBackKey = "CDLongPressCallBackKey";

- (void)cd_singleTap:(void (^)(UITapGestureRecognizer *))callback {
    [self setCDSingleCallBack:callback];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cdSingleTapAction:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    [self setCDSingleTapGesture:tap];
}

- (void)cd_doubleTap:(void (^)(UITapGestureRecognizer *))callback {
    [self setCDDoubleCallBack:callback];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cdDoubleTapAction:)];
    tap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tap];
    [self setcdDoubleTapGesture:tap];
}

- (void)cd_longPressWithSec:(NSTimeInterval)sec callback:(void (^)(UILongPressGestureRecognizer *))callback {
    [self setCDLongPressCallBack:callback];
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cdLongPressAction:)];
    press.minimumPressDuration = sec;
    [self addGestureRecognizer:press];
    [self setCDLongPressGesture:press];
}

- (void)setCDSingleTapGesture:(UITapGestureRecognizer *)tap {
    
    objc_setAssociatedObject(self, CDSingleTapGestureKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self checkGestures];
}

- (UITapGestureRecognizer *)cdSingleTapGesture {
    return objc_getAssociatedObject(self, CDSingleTapGestureKey);
}

- (void)setcdDoubleTapGesture:(UITapGestureRecognizer *)tap {

    objc_setAssociatedObject(self, CDDoubleTapGestureKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self checkGestures];
}

- (UITapGestureRecognizer *)cdDoubleTapGesture {
    
    return objc_getAssociatedObject(self, CDDoubleTapGestureKey);
}

- (void)setCDLongPressGesture:(UILongPressGestureRecognizer *)press {
    
    objc_setAssociatedObject(self, CDLongPressGestureKey, press, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self checkGestures];
}

- (UILongPressGestureRecognizer *)cdLongPress {
    
    return objc_getAssociatedObject(self, CDLongPressGestureKey);
}

- (void)checkGestures {
    // 单双击手势冲突
    if ([self cdSingleTapGesture]&&[self cdDoubleTapGesture]) {
        [[self cdSingleTapGesture] requireGestureRecognizerToFail:[self cdDoubleTapGesture]];
    }
    // scrollView 添加手势冲突问题
    if ([self isKindOfClass:[UIScrollView class]]) {
        
        ((UIScrollView *)self).canCancelContentTouches=NO;
        ((UIScrollView *)self).delaysContentTouches=NO;
    }
}

#pragma mark Callback

- (void)setCDSingleCallBack:(void (^)(UITapGestureRecognizer *))callback {
    
    objc_setAssociatedObject(self, CDSingleCallBackKey, callback, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITapGestureRecognizer *))cdSingleCallBack {
    
    return objc_getAssociatedObject(self, CDSingleCallBackKey);
}

- (void)setCDDoubleCallBack:(void (^)(UITapGestureRecognizer *))callback {
    
    objc_setAssociatedObject(self, CDDoubleCallBackKey, callback, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITapGestureRecognizer *))cdDoubleCallBack {
    
    return objc_getAssociatedObject(self, CDDoubleCallBackKey);
}

- (void)setCDLongPressCallBack:(void (^)(UILongPressGestureRecognizer *))callback {
    
    objc_setAssociatedObject(self, CDLongPressCallBackKey, callback, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UILongPressGestureRecognizer *))cdLongPressCallBack {
    
    return objc_getAssociatedObject(self, CDLongPressCallBackKey);
}

#pragma mark Selector

- (void)cdSingleTapAction:(UITapGestureRecognizer *)tap {
    if ([self cdSingleCallBack]) {
        [self cdSingleCallBack](tap);
    }
}

- (void)cdDoubleTapAction:(UITapGestureRecognizer *)tap {
    if ([self cdSingleCallBack]) {
        [self cdDoubleCallBack](tap);
    }
}

- (void)cdLongPressAction:(UILongPressGestureRecognizer *)press {
    if ([self cdSingleCallBack]) {
        [self cdLongPressCallBack](press);
    }
}

@end
