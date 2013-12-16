//
//  GJDivView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJDivView.h"

@implementation GJDivView

-( void )layoutSubviews
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
