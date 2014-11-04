//
//  TickingTimer.h
//  FlipCardGame
//
//  Created by Liu Yang on 11/4/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TickingTimer : SKLabelNode

@property (readonly) float elapsedTime;

+ (TickingTimer*)create;

- (void)start;
- (void)restart;
- (void)stop;
- (void)update:(float)delta;

@end
