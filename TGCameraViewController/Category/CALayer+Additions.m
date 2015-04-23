//
//  CALayer+Additions.m
//  MuGuangIOS
//
//  Created by William Hu on 4/23/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

#import "CALayer+Additions.h"

@implementation CALayer (Additions)
- (void)bringSublayerToFront:(CALayer *)layer
{
    [layer removeFromSuperlayer];
    [self insertSublayer:layer atIndex:(int)[self.sublayers count]];
}
- (void)sendSublayerToBack:(CALayer *)layer
{
    [layer removeFromSuperlayer];
    [self insertSublayer:layer atIndex:0];
}
@end
