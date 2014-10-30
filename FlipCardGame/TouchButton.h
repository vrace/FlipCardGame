//
//  TouchButton.h
//  FlipCardGame
//
//  Created by Liu Yang on 10/30/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TouchButton : SKSpriteNode

+ (TouchButton*)createWithNormal:(SKTexture*)normalTexture down:(SKTexture*)downTexture action:(dispatch_block_t)action;

- (void)touchesBegan:(CGPoint)touch;
- (void)touchesMoved:(CGPoint)touch;
- (void)touchesEnded;
- (void)touchesCancelled;

@end
