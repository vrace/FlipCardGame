//
//  MainGameScene.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "MainGameScene.h"
#import "Board.h"
#import "Piece.h"

@interface MainGameScene()
{
    
}

@property Board *board;

@end

@implementation MainGameScene

- (void)didMoveToView:(SKView *)view
{
    self.board = [Board create];
    self.board.anchorPoint = CGPointMake(0, 0);
    self.board.position = CGPointMake(0, 0);
    [self addChild:self.board];
}

@end
