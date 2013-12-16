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
{
    CGSize sizeNeeded = [self sizeWithAttributes: @{ NSFontAttributeName: font }];
    
    // See [NSString boundingRectWithSize:options:attributes:context:} docs
    sizeNeeded.width = ceil(sizeNeeded.width);
    sizeNeeded.height = ceil(sizeNeeded.height);
    
    return sizeNeeded;
    
}

-( CGSize )sizeNeededWithFont:( UIFont* )font
                       insets:( UIEdgeInsets )textInsets
                     maxWidth:( CGFloat )maxWidth
             andLineBreakMode:( NSLineBreakMode )lineBreakMode
{
    return [self sizeNeededWithFont: font
                             insets: textInsets
                           maxWidth: maxWidth
                      lineBreakMode:lineBreakMode
                   andTextAlignment: NSTextAlignmentLeft];
}

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
                                           options: NSStringDrawingUsesLineFragmentOrigin //| NSStringDrawingUsesFontLeading
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

-( CGSize )sizeNeededWithFont:( UIFont* )font
               minScaleFactor:( CGFloat )minScaleFactor
               actualFontSize:( CGFloat* )actualFontSize
                     forWidth:( CGFloat )maxWidth
                lineBreakMode:( NSLineBreakMode )lineBreakMode
{
    CGSize sizeNeeded;
    CGFloat minFontSize = round(font.pointSize * minScaleFactor);
    if ( minFontSize < 1.0f )
        minFontSize = 1.0f;
        
        do
        {
            sizeNeeded = [self sizeNeededWithFont: font
                                           insets: UIEdgeInsetsZero
                                         maxWidth: maxWidth
                                 andLineBreakMode: lineBreakMode];
            
            *actualFontSize = font.pointSize;
            
            font = [UIFont fontWithName: font.fontName size: (*actualFontSize)-1];
            
        } while (( sizeNeeded.width > maxWidth ) && ( *actualFontSize > minFontSize ));
    
    return sizeNeeded;
}

@end



@implementation GJTextView

-( void )setText:( NSString* )text
{
    [super setText: text];
    
    [self layoutBasedOnText];
}

-( void )layoutBasedOnText
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
                                                        maxWidth: CGFLOAT_MAX
                                                   lineBreakMode: self.lineBreakMode
                                                andTextAlignment: self.textAlignment];
        
        myFrame.size = sizeNeededForText;
    }
    
    self.frame = myFrame;
}

@end


















































