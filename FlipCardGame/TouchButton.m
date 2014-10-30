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
    
    button.userInteractionEnabled = YES;
    
    return button;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touch = [[touches anyObject] locationInNode:self.parent];
        
    if (CGRectContainsPoint(self.frame, touch))
    {
        self.hot = YES;
        self.touching = YES;
        [self setTexture:self.textureDown];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touch = [[touches anyObject] locationInNode:self.parent];
    
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.touching)
    {
        self.action();
    }
    
    [self setTexture:self.textureNormal];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setTexture:self.textureNormal];
}

@end
