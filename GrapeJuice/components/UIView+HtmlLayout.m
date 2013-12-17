//
//  UIView+HtmlLayout.m
//  GrapeJuice
//
//  Created by Daniel Alves on 17/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "UIView+HtmlLayout.h"

@implementation UIView( HtmlLayout )

-( void )layoutSubviewsInsideOut
{
    CGFloat yCounter = 0.0f;
    for( UIView* subview in self.subviews )
    {
        [subview layoutSubviews];
        
        CGRect subviewFrame =  subview.frame;
        subviewFrame.origin.y = yCounter;
        subview.frame = subviewFrame;
        
        yCounter += subviewFrame.size.height;
    }
    
    CGRect myFrame = self.frame;
    myFrame.size.height = yCounter;
    myFrame.size.width = self.superview.frame.size.width;
    self.frame = myFrame;
}

@end
