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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
        self.suit = @"1";
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
    
    if ([self.suit isEqualToString:@"♠"] || [self.suit isEqualToString:@"♣"]) {
        [[UIColor blackColor] setFill];
    } else {
        [[UIColor redColor] setFill];
    }
    
    CGRect rankFrame = CGRectMake(5, 2, 10, 10);
    NSString* rank = [self rankAsString];
    [rank drawInRect:rankFrame withFont:[UIFont systemFontOfSize:14]];
    
    CGRect suitFrame = CGRectMake(0, 20, 10, 10);
    NSString* suit = self.suit;
    [suit drawInRect:suitFrame withFont:[UIFont systemFontOfSize:14]];
    
    
    
}

-(NSString*) rankAsString
{
    NSArray* rankStrings = [[NSArray alloc] initWithObjects:@"?", @"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"10",@"J",@"Q",@"K",nil];
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

-(void) setIsFaceup:(BOOL)f
{
    _isFaceup = f;
    [self setNeedsDisplay];
}




@end
