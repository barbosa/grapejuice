//
//  GJDivView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJDivView.h"

@implementation GJDivView

-( void )willMoveToSuperview:( UIView* )newSuperview
{
    [super willMoveToSuperview: newSuperview];

    if( !newSuperview )
    {
        CGRect myFrame = self.frame;
        myFrame.origin = CGPointZero;
        myFrame.size.height = 0.0f;
        myFrame.size.width = newSuperview.frame.size.width;
        self.frame = myFrame;
    }
}

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
    self.frame = myFrame;
}

@end
