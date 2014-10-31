//
//  Piece.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "Piece.h"

@interface Piece()
{
}

@property PieceType pieceType;
@property SKTexture *textureCover;
@property SKTexture *textureContent;

@end

@implementation Piece

+ (Piece*)createWithType:(PieceType)type
{
    
    NSString *filename = [NSString stringWithFormat:@"Piece%d", type];
    
    SKTexture *content = [SKTexture textureWithImageNamed:filename];
    SKTexture *cover = [SKTexture textureWithImageNamed:@"Cover"];
    
    Piece *piece = [[Piece alloc] initWithTexture:cover];
    
    piece.textureContent = content;
    piece.textureCover = cover;
    piece.pieceType = type;
    
    return piece;
}

@end
