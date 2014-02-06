//
//  GJSpanView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJSpanView.h"

// grapejuice
#import "UIView+HtmlLayout.h"
#import "GJLayout.h"
#import "GJStyle.h"
#import "GJStylesheet.h"

@interface GJSpanView ()

@property( nonatomic, readwrite, strong ) GJStyle* computedStyle;

@end

@implementation GJSpanView

-( void )layoutSubviews
{
    self.computedStyle = [_layout.stylesheet computedStyleForTag: _layout.tag classes: _layout.classes];
    
    self.layer.borderColor = _computedStyle.borderColor.CGColor;
    self.layer.borderWidth = _computedStyle.borderWidth;
    self.backgroundColor = _computedStyle.backgroundColor;
    [self layoutSubviewsInsideOut];
}

@end
