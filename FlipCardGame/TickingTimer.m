//
//  TickingTimer.m
//  FlipCardGame
//
//  Created by Liu Yang on 11/4/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "TickingTimer.h"

@interface TickingTimer()
{
    
}

@property float elapsedTime;
@property BOOL working;

@end

@implementation TickingTimer

+ (TickingTimer*)create
{
    TickingTimer *timer = [[TickingTimer alloc] initWithFontNamed:@"Arial"];
    
    timer.fontColor = [UIColor colorWithRed:0.3f green:0.5f blue:0.9f alpha:1.0f];
    timer.fontSize = 24;
    timer.elapsedTime = 0;
    timer.working = NO;
    timer.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    [timer updateText];
    
    return timer;
}

- (void)start
{
    self.working = YES;
}

- (void)restart
{
    self.working = YES;
    self.elapsedTime = 0;
}

- (void)stop
{
    self.working = NO;
}

- (void)update:(float)delta
{
    if (self.working)
    {
        self.elapsedTime += delta;
        [self updateText];
    }
}

- (void)updateText
{
    self.text = [NSString stringWithFormat:@"%.2f", self.elapsedTime];
}

@end
