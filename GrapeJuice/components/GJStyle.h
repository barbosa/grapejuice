//
//  GJStyle.h
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJStyle : NSObject

@property (nonatomic) CGFloat marginTop;
@property (nonatomic) CGFloat marginRight;
@property (nonatomic) CGFloat marginBottom;
@property (nonatomic) CGFloat marginLeft;

@property (nonatomic) CGFloat paddingTop;
@property (nonatomic) CGFloat paddingRight;
@property (nonatomic) CGFloat paddingBottom;
@property (nonatomic) CGFloat paddingLeft;

@property (nonatomic) CGFloat borderTop;
@property (nonatomic) CGFloat borderRight;
@property (nonatomic) CGFloat borderBottom;
@property (nonatomic) CGFloat borderLeft;

@property (nonatomic) CGFloat borderRadius;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic, strong) UIColor* borderColor;

@property (nonatomic, strong) UIColor* backgroundColor;

+( GJStyle* )styleFromDictionary:( NSDictionary* )dictionary;

@end
