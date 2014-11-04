//
//  Piece.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "Piece.h"
#import "Board.h"

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
        if (![self hasActions])
        {
            [self flipToContent];
        
            if ([self.parent isKindOfClass:[Board class]])
            {
                Board *board = (Board*)self.parent;
                [board pieceFlipped:self];
            }
        }
    }
}

- (void)flipToContent
{
    [self runAction:[self flipToTexture:self.textureContent] withKey:@"flip"];
}

- (float)flipRemainingTime
{
    SKAction *action = [self actionForKey:@"flip"];
    return [action duration];
}

- (void)flipToCover:(float)wait
{
    wait += [self flipRemainingTime];
    SKAction *waitAction = [SKAction waitForDuration:wait];
    
    [self runAction:[SKAction sequence:@[waitAction, [self flipToTexture:self.textureCover]]]];
}

- (SKAction*)flipToTexture:(SKTexture*)texture
{
    NSString *file = @"click.wav";
    if (texture == self.textureCover)
        file = @"pew-pew-lei.wav";
    
    SKAction *sfx = [SKAction playSoundFileNamed:file waitForCompletion:NO];
    SKAction *shrink = [SKAction scaleXTo:0 duration:0.15f];
    SKAction *replace = [SKAction setTexture:texture];
    SKAction *unshrink = [SKAction scaleTo:1.0f duration:0.15f];
    
    return [SKAction sequence:@[sfx, shrink, replace, unshrink]];
}

- (void)vanish:(float)wait
{
    wait += [self flipRemainingTime];
    SKAction *waitAction = [SKAction waitForDuration:wait];
    SKAction *sfx = [SKAction playSoundFileNamed:@"effect_unswap.mp3" waitForCompletion:NO];
    SKAction *vfx = [SKAction runBlock:^{ [self.parent addChild:[self makeVanishVfx]]; }];
    SKAction *disappear = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[waitAction, vfx, sfx, disappear]]];
}

- (SKEmitterNode*)makeVanishVfx
{
    NSString *res = [[NSBundle mainBundle] pathForResource:@"Fire" ofType:@"sks"];
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:res];
    emitter.position = CGPointMake(self.position.x, self.position.y - self.size.height * 0.5f);
    return emitter;
}

@end
