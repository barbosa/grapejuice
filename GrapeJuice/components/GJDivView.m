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

@implementation GJDivView

-( void )layoutSubviews
{
    [self layoutSubviewsInsideOut];
}

@end
