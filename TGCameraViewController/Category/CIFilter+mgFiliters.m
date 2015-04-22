//
//  CIFilter+mgFiliters.m
//  MuGuangIOS
//
//  Created by William Hu on 4/22/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

#import "CIFilter+mgFiliters.h"

static NSString* const kCIColorControls         = @"CIColorControls";
static NSString* const kCIToneCurve             = @"CIToneCurve";
static NSString* const kCIVignette              = @"CIVignette";
static NSString* const kInputContrast           = @"inputContrast";
static NSString* const kInputImage              = @"inputImage";
static NSString* const kInputIntensity          = @"inputIntensity";
static NSString* const kInputPoint0             = @"inputPoint0";
static NSString* const kInputPoint1             = @"inputPoint1";
static NSString* const kInputPoint2             = @"inputPoint2";
static NSString* const kInputPoint3             = @"inputPoint3";
static NSString* const kInputPoint4             = @"inputPoint4";
static NSString* const kInputRadius             = @"inputRadius";
static NSString* const kInputSaturation         = @"inputSaturation";


@implementation CIFilter (mgFiliters)
+ (CIFilter *) saturateFilter
{
    CIFilter *filter = [CIFilter filterWithName:kCIToneCurve];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithX:0 Y:0] forKey:kInputPoint0];
    [filter setValue:[CIVector vectorWithX:.25 Y:.15] forKey:kInputPoint1];
    [filter setValue:[CIVector vectorWithX:.5 Y:.5] forKey:kInputPoint2];
    [filter setValue:[CIVector vectorWithX:.75 Y:.85] forKey:kInputPoint3];
    [filter setValue:[CIVector vectorWithX:1 Y:1] forKey:kInputPoint4];
    return filter;
}

+ (CIFilter *) curve1Filter
{
    CIFilter *filter = [CIFilter filterWithName:kCIToneCurve];
    [filter setDefaults];
    [filter setValue:[CIVector vectorWithX:0 Y:0] forKey:kInputPoint0];
    [filter setValue:[CIVector vectorWithX:.25 Y:.15] forKey:kInputPoint1];
    [filter setValue:[CIVector vectorWithX:.5 Y:.5] forKey:kInputPoint2];
    [filter setValue:[CIVector vectorWithX:.75 Y:.85] forKey:kInputPoint3];
    [filter setValue:[CIVector vectorWithX:1 Y:1] forKey:kInputPoint4];
    return filter;
}

+ (CIFilter *) vignetteFilter
{
    CIFilter *filter = [CIFilter filterWithName:kCIVignette];
    [filter setValue:@(6) forKey:kInputIntensity];
    [filter setValue:@(0) forKey:kInputRadius];
    return filter;
}
@end
