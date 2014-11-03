//
//  ScoreScene.m
//  FlipCardGame
//
//  Created by Liu Yang on 11/3/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "ScoreScene.h"
#import "TouchButton.h"
#import "MainGameScene.h"

@implementation ScoreScene

+ (ScoreScene*)scoreSceneWithSize:(CGSize)size score:(float)score
{
    ScoreScene *scene = [[ScoreScene alloc] initWithSize:size];
    
    [scene initWithScore:score];
    
    return scene;
}

- (void)initWithScore:(float)score
{
    SKSpriteNode *canvas = [SKSpriteNode spriteNodeWithImageNamed:@"Board"];
    canvas.anchorPoint = CGPointZero;
    canvas.position = CGPointZero;
    [self addChild:canvas];
    
    SKLabelNode *textComplete = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    textComplete.text = @"Complete!";
    textComplete.fontSize = 65;
    textComplete.fontColor = [UIColor colorWithRed:0.3f green:0.5f blue:0.9f alpha:1.0f];
    textComplete.position = CGPointMake(CGRectGetMidX(self.frame),
                                        self.size.height * 0.7f);
    
    [self addChild:textComplete];
    
    SKLabelNode *textScore = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    textScore.text = [NSString stringWithFormat:@"Your time is %.2f seconds", score];
    textScore.fontSize = 24;
    textScore.fontColor = [UIColor colorWithRed:0.6f green:0.2f blue:0.9f alpha:1.0f];
    textScore.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height * 0.45f);
    [self addChild:textScore];
    
    TouchButton *button = [TouchButton createWithNormal:[SKTexture textureWithImageNamed:@"Again_Normal"]
                                                   down:[SKTexture textureWithImageNamed:@"Again_Down"]
                                                 action:^{ [self launchMainScene]; }];
    button.position = CGPointMake(self.size.width / 2, self.size.height * 0.3f);
    [self addChild:button];
}

- (void)launchMainScene
{
    MainGameScene *scene = [MainGameScene sceneWithSize:self.frame.size];
    
    SKAction *sfx = [SKAction playSoundFileNamed:@"pickup_star.wav" waitForCompletion:NO];
    SKAction *nextScene = [SKAction runBlock:^{ [self.view presentScene:scene transition:[SKTransition fadeWithDuration:0.7]]; }];
    
    [self runAction:[SKAction sequence:@[sfx, nextScene]]];
}

@end
