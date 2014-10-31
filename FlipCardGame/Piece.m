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
    
    piece.userInteractionEnabled = YES;
    
    return piece;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.texture != self.textureContent)
    {
        [self flipToContent];
    }
}

- (void)flipToContent
{
    [self flipToTexture:self.textureContent];
}

- (void)flipToCover
{
    [self flipToTexture:self.textureCover];
}

- (void)flipToTexture:(SKTexture*)texture
{
    SKAction *shrink = [SKAction scaleXTo:0 duration:0.15f];
    SKAction *replace = [SKAction setTexture:texture];
    SKAction *unshrink = [SKAction scaleTo:1.0f duration:0.15f];
    
    [self runAction:[SKAction sequence:@[shrink, replace, unshrink]]];
}

@end
