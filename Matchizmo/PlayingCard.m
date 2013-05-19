//
//  PlayingCard.m
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString*) contents
{
    
    
    
    return [[[PlayingCard rankStrings] objectAtIndex:self.rank] stringByAppendingString:self.suit];
}


+(NSArray*) validSuits
{
    NSArray* suits = [[NSArray alloc] initWithObjects:@"♠",@"♣",@"♥",@"♦", nil];
    return suits;
}
+(NSUInteger) maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

@synthesize suit = _suit;
-(void) setSuit:(NSString*) suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

+(NSArray*) rankStrings
{
    NSArray* rankStrings = [[NSArray alloc] initWithObjects:@"?", @"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"10",@"J",@"Q",@"K",nil];
    return rankStrings;
}

-(void) setRank: rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
