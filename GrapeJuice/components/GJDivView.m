//
//  GJDivView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJDivView.h"

// grapejuice
#import "UIView+HtmlLayout.h"
#import "GJLayout.h"
#import "GJStyle.h"
#import "GJStylesheet.h"

@implementation GJDivView

-( void )layoutSubviews
{
    GJStyle* computedStyle = [_layout.stylesheet computedStyleForTag: _layout.tag classes: _layout.classes];

    self.layer.borderColor = computedStyle.borderColor.CGColor;
    self.layer.borderWidth = computedStyle.borderWidth;
    self.backgroundColor = computedStyle.backgroundColor;
    [self layoutSubviewsInsideOut];
}

@end
