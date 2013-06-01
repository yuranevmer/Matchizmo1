//
//  CardView.m
//  Matchizmo
//
//  Created by yura on 5/31/13.
//
//

#import "PlayingCardView.h"

@interface PlayingCardView ()

-(void) setup;
-(void) drawCard;



@end




@implementation PlayingCardView

@synthesize contents = _contents;
@synthesize suit = _suit;
@synthesize rank = _rank;
@synthesize isFaceUp = _isFaceUp;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}


-(void) setup
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self drawCard];
}

-(void) drawCard
{
    if (!self.isFaceUp) {
        UIImage* back = [UIImage imageNamed:@"lock.png"];
        CGRect frame = CGRectInset(self.bounds, (self.bounds.size.width-back.size.width)/2, (self.bounds.size.height - back.size.height)/2);
        [back drawInRect:frame];
        return;
    }
    
    if ([self.suit isEqualToString:@"♠"] || [self.suit isEqualToString:@"♣"]) {
        [[UIColor blackColor] setFill];
    } else {
        [[UIColor redColor] setFill];
    }
    
    NSString* rank = [self rankAsString];
    [rank drawAtPoint:CGPointMake(5, 2) withFont:[UIFont systemFontOfSize:14]];
    
    CGRect suitFrame = CGRectMake(0, 20, 10, 10);
    NSString* suit = self.suit;
    [suit drawInRect:suitFrame withFont:[UIFont systemFontOfSize:14]];
}

-(NSString*) rankAsString
{
    NSArray* rankStrings = [[NSArray alloc] initWithObjects:@"?", @"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",nil];
    NSString* str = [rankStrings objectAtIndex:self.rank];
    return str;
}



#pragma mark - 
#pragma mark setters

-(void) setSuit:(NSString *)suit
{
    _suit = [suit copy];
    [self setNeedsDisplay];
}
-(void) setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

-(void) setIsFaceUp:(BOOL)f
{
    _isFaceUp = f;
    [self setNeedsDisplay];
}




@end
