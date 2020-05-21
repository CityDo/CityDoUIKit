//
//  CityDoDateFormatTool.m
//  CityDoCommon
//
//  Created by volientDuan on 2020/5/15.
//  Copyright © 2020 CityDo. All rights reserved.
//

#import "CityDoDateFormatTool.h"

@implementation CityDoDateFormatTool

+ (NSTimeInterval)getTimerInterval:(NSTimeInterval)timeInterval{
    if (timeInterval > 1000000000000) {
        return timeInterval/1000;
    }
    return timeInterval;
}
+ (NSTimeInterval)getNowTimeInterval{
    return [[NSDate date]timeIntervalSince1970];
}

+ (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)formatStr{
    if (time < 0)
    {
        return @"";
    }
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self getTimerInterval:timeInterval]];
    return [formatter stringFromDate:date];
}
+ (NSString *)formatDate:(NSDate *)date format:(NSString *)formatStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatStr];
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromTimeTinterval:(NSTimeInterval)timeInterval {
    return [NSDate dateWithTimeIntervalSince1970:[self getTimerInterval:timeInterval]];
}
+ (NSDate *)dateFromStr:(NSString *)dateStr format:(NSString *)formatStr {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = formatStr;
    return [fmt dateFromString:dateStr];
}

+ (NSTimeInterval)timeIntervalFromDate:(NSDate *)date {
    return [date timeIntervalSince1970];
}
+ (NSTimeInterval)timeIntervalFromStr:(NSString *)dateStr format:(NSString *)formatStr {
    return [self timeIntervalFromDate:[self dateFromStr:dateStr format:formatStr]];
}


+ (NSInteger)getSecCountdownFrom:(NSTimeInterval)from to:(NSTimeInterval)to{
    NSTimeInterval toTime = [self getTimerInterval:to];
    NSTimeInterval fromTime = [self getTimerInterval:from];
    return toTime - fromTime;
}

+ (NSString *)today:(NSString *)format{
    return [self formatTimeInterval:[self getNowTimeInterval] format:format];
}
+ (NSString *)yesterday:(NSString *)format{
    return [self formatTimeInterval:([self getNowTimeInterval]-24*60*60) format:format];
}

+ (NSString *)formatDateStr:(NSString *)dateStr from:(NSString *)from to:(NSString *)to {
    NSDate *date = [self dateFromStr:dateStr format:from];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:to];
    return [formatter stringFromDate:date];
    
}

+ (NSString *)weekdayFrom:(NSDate *)date customDays:(NSArray *)customDays {
    NSMutableArray *weekdays = [NSMutableArray arrayWithArray:@[@"周天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"]];
    if (customDays) {
        [weekdays removeAllObjects];
        [weekdays addObjectsFromArray:customDays];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekdays objectAtIndex:theComponents.weekday-1];
}

@end
