//
//  MainGameScene.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "MainGameScene.h"
#import "ScoreScene.h"
#import "Piece.h"
#import "TickingTimer.h"

@interface MainGameScene()
{
}

@property Board *board;
@property TickingTimer *timer;
@property NSTimeInterval lastTick;

@end

@implementation MainGameScene

- (void)didMoveToView:(SKView *)view
{
    self.board = [Board create];
    self.board.anchorPoint = CGPointMake(0, 0);
    self.board.position = CGPointMake(0, 0);
    [self addChild:self.board];
    
    self.timer = [TickingTimer create];
    self.timer.position = CGPointMake(self.size.width * 0.8f, CGRectGetMidY(self.frame));
    [self addChild:self.timer];
    
    self.lastTick = 0;
}

- (void)boardAction
{
    [self.timer start];
}

- (void)boardCompleted
{
    [self.timer stop];
    ScoreScene *scene = [ScoreScene scoreSceneWithSize:self.size score:self.timer.elapsedTime];
    
    SKAction *wait = [SKAction waitForDuration:1.0f];
    SKTransition *trans = [SKTransition fadeWithDuration:0.7f];
    SKAction *navigate = [SKAction runBlock:^{ [self.view presentScene:scene transition:trans]; }];
    
    [self runAction:[SKAction sequence:@[wait, navigate]]];
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.lastTick == 0)
    {
        self.lastTick = currentTime;
    }
    else
    {
        float delta = currentTime - self.lastTick;
        self.lastTick = currentTime;
    
        [self.timer update:delta];
    }
}

@end
