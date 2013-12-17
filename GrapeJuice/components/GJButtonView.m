//
//  GJButtonView.m
//  GrapeJuice
//
//  Created by emerson on 12/17/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJButtonView.h"

// grapejuice
#import "NSString+Utils.h"

#import "GJLayout.h"
#import "GJStylesheet.h"
#import "GJStyle.h"

@interface GJButtonView()

@property( nonatomic, readwrite, strong )NSString* mappedText;

@end

@implementation GJButtonView

-( id )initWithFrame:( CGRect )frame
{
    self = [super initWithFrame: frame];
    if( self )
    {
        if( ![self buildGJButtonView] )
            return nil;
    }
    return self;
}

-( id )initWithCoder:( NSCoder* )aDecoder
{
    self = [super initWithCoder: aDecoder];
    if( self )
    {
        if( ![self buildGJButtonView] )
            return nil;
    }
    return self;
}

-( BOOL )buildGJButtonView
{
    mappedButton = [UIButton buttonWithType: UIButtonTypeSystem];
    if( !mappedButton )
        return  NO;
    
    // We MUST call super here since we override addSubview
    [super addSubview: mappedButton];

    mappedButton.frame = self.bounds;
    mappedButton.autoresizingMask = UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;;
    
    return YES;
}

-( void )consumesChildHtmlNode:( OGElement* )element
{
    OGElement* child = element.children.firstObject;
    if ([child isKindOfClass: [OGText class]])
    {
        OGText* textNode = ( OGText* )child;
        self.mappedText = [textNode.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if( self.mappedText.length > 0 )
        {
            [mappedButton setTitle: self.mappedText forState:UIControlStateNormal];
            [mappedButton setTitle: self.mappedText forState:UIControlStateDisabled];
            [mappedButton setTitle: self.mappedText forState:UIControlStateHighlighted];
            [mappedButton setTitle: self.mappedText forState:UIControlStateReserved];
            [mappedButton setTitle: self.mappedText forState:UIControlStateSelected];
            [mappedButton setTitle: self.mappedText forState:UIControlStateApplication];
        }
    }
}

-( void )addSubview:( UIView* )view
{
    // Cannot add subviews to buttons, so we do nothing here
}

-( void )layoutSubviews
{
    CGSize textSize = [self.mappedText sizeNeededWithFont: mappedButton.titleLabel.font
                                                   insets: UIEdgeInsetsZero
                                                 maxWidth: mappedButton.superview.frame.size.width
                                            lineBreakMode: mappedButton.titleLabel.lineBreakMode
                                         andTextAlignment: mappedButton.titleLabel.textAlignment];

    GJStyle* style = [self.layout.stylesheet computedStyleForTag: self.layout.tag
                                                         classes: self.layout.classes];

    textSize.width += style.paddingLeft + style.paddingRight;
    textSize.height += style.paddingTop + style.paddingBottom;

    if (style.backgroundColor)
        [self setBackgroundColor: style.backgroundColor];
    
    CGRect myFrame = self.frame;
    myFrame.size = textSize;
    self.frame = myFrame;

    [mappedButton layoutSubviews];
}

@end




















































