//
//  GJTextView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJTextView.h"

@implementation NSString( Utils )

-( CGSize )sizeNeededWithFont:( UIFont* )font
                       insets:( UIEdgeInsets )textInsets
                     maxWidth:( CGFloat )maxWidth
                lineBreakMode:( NSLineBreakMode )lineBreakMode
             andTextAlignment:( NSTextAlignment )textAlignment
{
    CGSize sizeConstraint = CGSizeMake(maxWidth - textInsets.left - textInsets.right, CGFLOAT_MAX);
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    paragraphStyle.alignment = textAlignment;
    
    CGSize sizeNeeded = [self boundingRectWithSize: sizeConstraint
                                           options: NSStringDrawingUsesLineFragmentOrigin
                                        attributes: @{ NSFontAttributeName: font,
                                                       NSParagraphStyleAttributeName: paragraphStyle }
                                           context: nil].size;
    
    sizeNeeded.width += textInsets.left + textInsets.right;
    sizeNeeded.height += textInsets.top + textInsets.bottom;
    
    // See -boundingRectWithSize:options:attributes:context: docs
    sizeNeeded.width = ceil(sizeNeeded.width);
    sizeNeeded.height = ceil(sizeNeeded.height);
    
    return sizeNeeded;
}

@end

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


















































