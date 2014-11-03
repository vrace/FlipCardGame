//
//  Board.h
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Piece.h"

@interface Board : SKSpriteNode

+ (Board*)create;

- (void)pieceFlipped:(Piece*)piece;

@end
