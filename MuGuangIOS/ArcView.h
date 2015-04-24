//
//  ArcView.h
//  ArcLabel
//
//  Created by ZhangHao on 15/4/23.
//  Copyright (c) 2015年 ZhangHao. All rights reserved.
//

// source: http://stackoverflow.com/questions/3841642/curve-text-on-existing-circle

#import <UIKit/UIKit.h>

@interface ArcView : UIView
@property(retain, nonatomic) UIFont *font;
@property(retain, nonatomic) NSString *text;
@property(readonly, nonatomic) NSAttributedString *attributedString;
@property(assign, nonatomic) CGFloat radius;
@property(nonatomic) BOOL showsGlyphBounds;
@property(nonatomic) BOOL showsLineMetrics;
@property(nonatomic) BOOL dimsSubstitutedGlyphs;
@property(retain, nonatomic) UIColor *color;
@property(nonatomic) CGFloat arcDegree;
@property(nonatomic) CGFloat shiftH, shiftV;
@end
