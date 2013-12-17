//
//  NSString+Utils.m
//  GrapeJuice
//
//  Created by Daniel Alves on 17/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "NSString+Utils.h"

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
