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
    CGRect myFrame = self.frame;
    myFrame.size = newWindow.frame.size;
    self.frame = myFrame;
    
    [super layoutSubviews];
}

-( void )layoutSubviews
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if( !window )
        return;
    
    CGRect myFrame = self.frame;
    myFrame.size = window.frame.size;
    self.frame = myFrame;
    
    [self layoutSubviewsInsideOut];
}

@end
