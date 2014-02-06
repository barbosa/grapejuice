//
//  UIView+HtmlLayout.h
//  GrapeJuice
//
//  Created by Daniel Alves on 17/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJStyle;

typedef NS_ENUM(NSInteger, HtmlLayoutType) {
    HtmlLayoutTypeInline = 0,
    HtmlLayoutTypeBlock = 1,
};

@interface UIView( HtmlLayout )

-( void )layoutSubviewsInsideOut;
-( void )drawBordersOnRect:( CGRect )rect withStyle:( GJStyle* )style;

+ (HtmlLayoutType)htmlLayoutType;

@end

