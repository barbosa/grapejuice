//
//  GJBodyView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJBodyView.h"

// grapejuice
#import "UIView+HtmlLayout.h"

@implementation GJBodyView

-( void )willMoveToWindow:( UIWindow* )newWindow
{
    [self layoutSubviewsForWindow: newWindow];
}

-( void )layoutSubviews
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if( !window )
        return;
    
    [self layoutSubviewsForWindow: window];
}

-( void )layoutSubviewsForWindow:( UIWindow* )containerWindow
{
    CGRect myFrame = self.frame;
    myFrame.size = containerWindow.frame.size;
    self.frame = myFrame;
    
    [self layoutSubviewsInsideOut];
}

@end
