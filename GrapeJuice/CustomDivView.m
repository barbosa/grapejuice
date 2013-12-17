//
//  CustomDivView.m
//  GrapeJuice
//
//  Created by Thiago Pontes on 12/17/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "CustomDivView.h"

@implementation CustomDivView

-(void) layoutSubviews
{
    [super layoutSubviews];
    CGRect currentFrame = self.frame;
    currentFrame.origin.x = 170.f;
    self.frame = currentFrame;
}

@end
