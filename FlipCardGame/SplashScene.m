//
//  SplashScene.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/30/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "SplashScene.h"
#import "TouchButton.h"
#import "GameScene.h"

@implementation SplashScene

- (void)didMoveToView:(SKView *)view
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Splash"];
    background.position = CGPointMake(0, 0);
    background.anchorPoint = CGPointMake(0, 0);
    
    [self addChild:background];
    
    CGSize size = view.frame.size;
    
    SKTexture *normal = [SKTexture textureWithImageNamed:@"Start_Normal"];
    SKTexture *down = [SKTexture textureWithImageNamed:@"Start_Down"];
    
    TouchButton *button = [TouchButton createWithNormal:normal down:down action:^{[self launchMainScene];}];
    button.position = CGPointMake(size.width / 2, size.height * 0.4f);
    [self addChild:button];
}

- (void)launchMainScene
{
    GameScene *scene = [GameScene sceneWithSize:self.frame.size];
    [self.view presentScene:scene transition:[SKTransition fadeWithDuration:0.3f]];
}

@end
