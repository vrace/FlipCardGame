//
//  Piece.h
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define PieceTypeNum 4
typedef int PieceType;

@interface Piece : SKSpriteNode

@property (readonly) PieceType pieceType;

+ (Piece*)createWithType:(PieceType)type;

@end
