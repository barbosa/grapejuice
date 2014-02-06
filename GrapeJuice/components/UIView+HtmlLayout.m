//
//  UIView+HtmlLayout.m
//  GrapeJuice
//
//  Created by Daniel Alves on 17/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "UIView+HtmlLayout.h"

// grapejuice
#import "GJStyle.h"
#import "GJImgView.h"

@implementation UIView( HtmlLayout )

-( void )layoutSubviewsInsideOut
{
    CGFloat xCounter = 0.0f;
    CGFloat yCounter = 0.0f;
    
    BOOL isLastElementInline = NO;
    for( UIView* subview in self.subviews )
    {
        [subview layoutSubviews];
        
        CGRect subviewFrame =  subview.frame;
        
        if ([[subview class] htmlLayoutType] == HtmlLayoutTypeInline)
        {
            subviewFrame.origin.x = xCounter;
            xCounter += subviewFrame.size.width;
            
            if (isLastElementInline)
            {
                // if elemento nao cabe na tela, aumenta Y
            }
            else
            {
                subviewFrame.origin.y = yCounter;
                yCounter += subviewFrame.size.height;
            }
            
            isLastElementInline = YES;
        }
        
        if ([[subview class] htmlLayoutType] == HtmlLayoutTypeBlock)
        {
            xCounter = 0.0;
            subviewFrame.origin.x = xCounter;
            
            subviewFrame.origin.y = yCounter;
            yCounter += subviewFrame.size.height;
            
            isLastElementInline = NO;
        }

        subview.frame = subviewFrame;
    }
    
    CGRect myFrame = self.frame;
    myFrame.size.height = yCounter;
    
    if ([[self class] htmlLayoutType] == HtmlLayoutTypeBlock)
        myFrame.size.width = self.superview.frame.size.width;

    self.frame = myFrame;
}

-( void )drawBordersOnRect:( CGRect )rect withStyle:( GJStyle* )style
{
    if( style )
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if( style.borderTop > 0 )
        {
            CGFloat minY = CGRectGetMinY(rect) - ( style.borderTop / 2.0f );
            CGContextMoveToPoint( context, CGRectGetMinX(rect), minY );
            CGContextAddLineToPoint( context, CGRectGetMaxX(rect), minY );
            CGContextSetStrokeColorWithColor( context, style.borderColor.CGColor );
            CGContextSetLineWidth( context, style.borderTop );
            CGContextStrokePath( context );
        }
        
        if( style.borderBottom > 0 )
        {
            CGFloat maxY = CGRectGetMaxY(rect) + ( style.borderBottom / 2.0f );
            CGContextMoveToPoint( context, CGRectGetMinX(rect), maxY );
            CGContextAddLineToPoint( context, CGRectGetMaxX(rect), maxY );
            CGContextSetStrokeColorWithColor( context, style.borderColor.CGColor );
            CGContextSetLineWidth( context, style.borderBottom );
            CGContextStrokePath( context );
        }
        
        if( style.borderLeft > 0 )
        {
            CGFloat minX = CGRectGetMinX(rect) - ( style.borderLeft / 2.0f );
            CGContextMoveToPoint( context, minX, CGRectGetMinY( rect ) );
            CGContextAddLineToPoint( context, minX, CGRectGetMaxY( rect ) );
            CGContextSetStrokeColorWithColor( context, style.borderColor.CGColor );
            CGContextSetLineWidth( context, style.borderLeft );
            CGContextStrokePath( context );
        }
        
        if( style.borderRight > 0 )
        {
            CGFloat maxX = CGRectGetMaxX(rect) + ( style.borderRight / 2.0f );
            CGContextMoveToPoint( context, maxX, CGRectGetMinY( rect ) );
            CGContextAddLineToPoint( context, maxX, CGRectGetMaxY( rect ) );
            CGContextSetStrokeColorWithColor( context, style.borderColor.CGColor );
            CGContextSetLineWidth( context, style.borderRight );
            CGContextStrokePath( context );
        }
    }
}

+ (HtmlLayoutType)htmlLayoutType
{
    return HtmlLayoutTypeInline;
}

@end
















































