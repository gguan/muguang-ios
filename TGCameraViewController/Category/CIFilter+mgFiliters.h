//
//  CIFilter+mgFiliters.h
//  MuGuangIOS
//
//  Created by William Hu on 4/22/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIFilter (mgFiliters)
//Humm
+ (CIFilter *) saturateFilter;
//Delcious
+ (CIFilter *) curve1Filter;
//Yupi
+ (CIFilter *) vignetteFilter;
@end
