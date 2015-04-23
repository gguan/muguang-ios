//
//  CALayer+Additions.h
//  MuGuangIOS
//
//  Created by William Hu on 4/23/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Additions)
- (void)bringSublayerToFront:(CALayer *)layer;
- (void)sendSublayerToBack:(CALayer *)layer;
@end
