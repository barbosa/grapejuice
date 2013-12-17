//
//  GJTextView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJTextView.h"

// grapejuice
#import "GJLayout.h"
#import "GJStyle.h"
#import "GJStylesheet.h"
#import "NSString+Utils.h"

@implementation GJTextView

-( id )initWithFrame:( CGRect )frame
{
    self = [super initWithFrame: frame];
    if( self )
    {
        self.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return self;
}

-( id )initWithCoder:( NSCoder* )aDecoder
{
    self = [super initWithCoder: aDecoder];
    if( self )
    {
        self.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return self;
}

-( void )layoutSubviews
{
    CGRect myFrame = self.frame;

    SEL layoutGetter = @selector(layout);
    if( [self.superview respondsToSelector: layoutGetter] )
    {
        GJLayout* layout = ( GJLayout* )[self.superview performSelector: layoutGetter];
        self.style = [layout.stylesheet computedStyleForTag: layout.tag classes: layout.classes];
    }
    
    if( _style )
        self.textColor = _style.color;
    else
        self.textColor = [UIColor blackColor];
    
    if( self.text.length <= 0 )
    {
        myFrame.size = CGSizeZero;
    }
    else
    {
        CGSize sizeNeededForText = [self.text sizeNeededWithFont: self.font
                                                          insets: UIEdgeInsetsZero
                                                        maxWidth: self.superview.frame.size.width
                                                   lineBreakMode: self.lineBreakMode
                                                andTextAlignment: self.textAlignment];

        CGFloat nLines = ceil( sizeNeededForText.height / ceil( self.font.lineHeight ));

        self.numberOfLines = nLines;
        myFrame.size = sizeNeededForText;
    }
    
    self.frame = myFrame;
    
    [super layoutSubviews];
}

@end


















































