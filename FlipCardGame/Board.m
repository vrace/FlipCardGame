//
//  Board.m
//  FlipCardGame
//
//  Created by Liu Yang on 10/31/14.
//  Copyright (c) 2014 Liu Yang. All rights reserved.
//

#import "Board.h"
#import "Piece.h"

const int CountRow = 4;
const int CountCol = 4;
const int CountTotal = CountRow * CountCol;

@interface Board()
{
    Piece *pieces[CountTotal];
}

@property Piece *hotPiece;
@property int finishCount;

@end

@implementation Board

+ (Board*)create
{
    Board *board = [[Board alloc] initWithImageNamed:@"Board"];
    
    [board initializeBoard];
    
    return board;
}

- (void)initializeBoard
{
    PieceType types[CountTotal] = { 0 };
    
    [self generateTypes:types count:CountTotal];
    
    // generates the piece and place them on the board
    for (int i = 0; i < CountTotal; i++)
    {
        pieces[i] = [self generatePiece:types[i] index:i];
        [self addChild:pieces[i]];
    }
    
    self.hotPiece = nil;
    self.finishCount = 0;
}

- (void)generateTypes:(PieceType*)types count:(int)count
{
    memset(types, 0, sizeof(PieceType) * count);
    
    // get pieces per type
    int ppt = count / PieceTypeNum;
    assert(ppt * PieceTypeNum == count);
    
    // fill types
    for (int i = 0; i < PieceTypeNum; i++)
    {
        int base = i * ppt;
        for (int k = 0; k < ppt; k++)
        {
            types[base + k] = i;
        }
    }
    
    // randomize
    for (int i = 0; i < count; i++)
    {
        int r = arc4random() % count;
        
        PieceType t = types[i];
        types[i] = types[r];
        types[r] = t;
    }
}

- (Piece*)generatePiece:(PieceType)type index:(int)index
{
    Piece *piece = [Piece createWithType:type];
    
    // place the piece in proper position
    
    int row = index / CountCol;
    int col = index % CountCol;
    
    int width = self.size.height / CountCol;
    int height = self.size.height / CountRow;
    
    int px = 20 + width * col + width / 2;
    int py = height * row + height / 2;
    
    piece.position = CGPointMake(px, py);
    
    return piece;
}

- (void)pieceFlipped:(Piece*)piece
{
    if (!self.hotPiece)
    {
        self.hotPiece = piece;
    }
    else
    {
        if (self.hotPiece.pieceType == piece.pieceType)
        {
            [piece vanish:0];
            [self.hotPiece vanish:[piece flipRemainingTime]];
            
            self.finishCount += 2;
            
            if (self.finishCount >= CountTotal)
            {
                if ([self.parent.class conformsToProtocol:@protocol(BoardEventHandler)])
                {
                    [(id)self.parent boardCompletedWithScore:0];
                }
            }
        }
        else
        {
            [piece flipToCover:0];
            [self.hotPiece flipToCover:[piece flipRemainingTime]];
        }
        
        self.hotPiece = nil;
    }
}

@end
