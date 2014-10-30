//
//  TouchButton.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/30/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "TouchButton.h"

@interface TouchButton()
{
    
}

@property SKTexture *textureNormal;
@property SKTexture *textureDown;
@property BOOL touching;
@property BOOL hot;
@property (strong) dispatch_block_t action;

@end

@implementation TouchButton

+ (TouchButton*)createWithNormal:(SKTexture*)normalTexture down:(SKTexture *)downTexture action:(dispatch_block_t)action
{
    TouchButton *button = [[TouchButton alloc] initWithTexture:normalTexture];
    
    button.textureNormal = normalTexture;
    button.textureDown = downTexture;
    button.touching = NO;
    button.hot = NO;
    button.action = action;
    
    return button;
}

- (void)touchesBegan:(CGPoint)touch
{
    self.hot = NO;
    self.touching = NO;
    
    if (CGRectContainsPoint(self.frame, touch))
    {
        self.hot = YES;
        self.touching = YES;
        [self setTexture:self.textureDown];
    }
}

- (void)touchesMoved:(CGPoint)touch
{
    if (self.hot)
    {
        if (CGRectContainsPoint(self.frame, touch))
        {
            if (!self.touching)
            {
                self.touching = YES;
                [self setTexture:self.textureDown];
            }
        }
        else
        {
            if (self.touching)
            {
                self.touching = NO;
                [self setTexture:self.textureNormal];
            }
        }
    }
}

- (void)touchesEnded
{
    if (self.touching)
    {
        self.action();
    }
    
    [self setTexture:self.textureNormal];
}

- (void)touchesCancelled
{
    [self setTexture:self.textureNormal];
}

@end
