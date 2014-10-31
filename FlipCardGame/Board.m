//
//  Board.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "Board.h"

@implementation Board

+ (Board*)create
{
    Board *board = [[Board alloc] initWithImageNamed:@"Board"];
    
    return board;
}

@end
