//
//  CItyDoCommonTool.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/18.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "CityDoCommonTool.h"

@implementation CityDoCommonTool

#pragma mark - 计算距离

+ (CGFloat)getStrWidthByHeight:(CGFloat)h font:(UIFont *)font str:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, h) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}

+ (CGFloat)getStrHeightByWidth:(CGFloat)w font:(UIFont *)font str:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(w, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}

+ (CGFloat)getStrHeightByWidth:(CGFloat)w str:(NSString *)str attributeDict:(NSMutableDictionary *)attr
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(w, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return rect.size.height;
}

+ (NSMutableDictionary *)setLineHeightWithH:(CGFloat)h
{
    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineSpacing = h;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    [attr setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    return attr;
}

//改变字体的行间距
+ (NSMutableAttributedString *)changeLineSpaceWithString:(NSString *)str lineSpace:(CGFloat)lineSpace
{
    if (str) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc] init];
        [paragrap setLineSpacing:lineSpace];
        NSRange range = NSMakeRange(0.f, str.length);
        [attr addAttribute:NSParagraphStyleAttributeName value:paragrap range:range];
        return attr;
    }
    return nil;
}

//改变字体的行间距
+ (NSMutableAttributedString *)changeLineSpaceWithString:(NSString *)str lineSpace:(CGFloat)lineSpace textAlignment:(NSTextAlignment)textAlignment {
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc] init];
    [paragrap setLineSpacing:lineSpace];
    paragrap.alignment = textAlignment;
    NSRange range = NSMakeRange(0.f, str.length);
    [attr addAttribute:NSParagraphStyleAttributeName value:paragrap range:range];
    
    return attr;
}

+ (UIViewController *)getCurrentViewControllerOfView:(UIView *)theView
{
    for (UIView *view = theView; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


#pragma mark - 二维码生成


+ (UIImage *)qrImageForString:(NSString *)string imageWidth:(CGFloat)ImageWidth{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
    return [self createUIImageFormCIImage:outPutImage withSize:ImageWidth];
}
+ (UIImage *)createUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)ImageWidth{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(ImageWidth/CGRectGetWidth(extent), ImageWidth/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}
+ (UIImage *)getImageFromView:(UIView *)theView
{
    //UIGraphicsBeginImageContext(theView.bounds.size);
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIView *)getViewWithImage:(UIImage *)image size:(CGSize)size{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat x = size.width * 0.1;
    CGFloat y = size.height * 0.1;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, size.width-2*x, size.height-2*y)];
    [imageView setImage:image];
    [view addSubview:imageView];
    return view;
}
+ (UIImage *)qrCodeImage:(UIImage *)codeImage logo:(UIImage *)logo{
    //给二维码加 logo 图
    CGSize size = codeImage.size;
    CGSize logoSize = CGSizeMake(size.width*0.382, size.height*0.382);
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    [codeImage drawInRect:CGRectMake(0,0 , size.width, size.height)];
    //logo图加白边
    logo = [self getImageFromView:[self getViewWithImage:logo size:logoSize]];
    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [logo drawInRect:CGRectMake((size.width-logoSize.width)/2.0, (size.height-logoSize.height)/2.0, logoSize.width, logoSize.height)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

#pragma mark - 视图

+ (UIView *)createDashLine:(CGRect)frame lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    [self drawDashLine:lineView lineLength:lineLength lineSpacing:lineSpacing lineColor:lineColor];
    return lineView;
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

#pragma mark - 其它

+ (void)toSetPage:(VDSetPageType)type {
    
    NSString * strUrl = @"";
    NSString *prefs = [[UIDevice currentDevice].systemVersion floatValue] >= 10.0?@"APP-Prefs:root=":@"prefs:root=";
    switch (type) {
        case VDSetPageTypeApp:
            strUrl = UIApplicationOpenSettingsURLString;
            break;
        case VDSetPageTypeLocation:
            strUrl = [NSString stringWithFormat:@"%@LOCATION_SERVICES  ",prefs];
            break;
        case VDSetPageTypeBluetooth:
            strUrl = [NSString stringWithFormat:@"%@General&path=Bluetooth",prefs];
            break;
        case VDSetPageTypeVPN:
            strUrl = [NSString stringWithFormat:@"%@General&path=Network/VPN",prefs];
            break;
        case VDSetPageTypeWIFI:
            strUrl = [NSString stringWithFormat:@"%@WIFI",prefs];
            break;
        case VDSetPageTypeGeneral:
            strUrl = [NSString stringWithFormat:@"%@General",prefs];
            break;
        case VDSetPageTypeKeyboard:
            strUrl = [NSString stringWithFormat:@"%@General&path=Keyboard",prefs];
            break;
        default:
            strUrl = UIApplicationOpenSettingsURLString;
            break;
    }
    NSURL *url = [NSURL URLWithString:strUrl];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }else{
        NSLog(@"can't open url:%@",strUrl);
    }
}


@end
