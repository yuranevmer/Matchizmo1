//
//  SecondCardGameViewController.m
//  Matchizmo
//
//  Created by yura on 5/29/13.
//
//





#import "SecondCardGameViewController.h"
#import "ContainerView.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface SecondCardGameViewController ()

-(void) setupUI;
-(void) updateUI;
-(void) relayoutCards;


@property (nonatomic,retain) CardMatchingGame* game;
@property (nonatomic,retain) NSMutableArray* cardButtons;
@property (nonatomic, retain) ContainerView* containerView;



@end

@implementation SecondCardGameViewController
@synthesize game = _game;
@synthesize cardButtons = _cardButtons;
@synthesize containerView = _containerView;


#define CARD_COUNT 12


-(void) startNewGame
{
    
    for (UIView* v in self.containerView.subviews) {
        [v removeFromSuperview];
    }
    self.game = nil;
    PlayingCardDeck* newDeck = [[[PlayingCardDeck alloc] init] autorelease];
    self.game = [[CardMatchingGame alloc] initWithCardCount:CARD_COUNT usingDeck:newDeck gameMode:2];
    
    for (int i = 0; i<CARD_COUNT; i++) {
        CGRect frame = CGRectMake(0, 0, 60, 80);
        PlayingCardView* p = [[PlayingCardView alloc] initWithFrame:frame];
        
        
        PlayingCard* card = (PlayingCard*)[self.game cardAtIndex:i];
        p.suit = card.suit;
        p.rank = card.rank;
        
        /*
        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipCard:)];
        [p addGestureRecognizer:recognizer];
        */
        
        [self.containerView addSubview:p];
    }
    
}

-(void) flipCard:(UITapGestureRecognizer*)sender
{
    [self.game flipCardAtIndex:[self.containerView.subviews indexOfObject:sender.view]];
    
    [self updateUI];
    NSLog(@"Tap--- %@", sender);
       
}
-(void) updateUI
{
    for (PlayingCardView* p in self.containerView.subviews) {
        int index = [self.containerView.subviews indexOfObject:p];
        Card* card = [self.game cardAtIndex:index];
        p.isFaceUp = card.isFaceUp;
        if (card.isUnplayable) {
            p.alpha = 0.3;
        }
    }
}

-(void) setupUI
{
    
    self.containerView = [[ContainerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.containerView];
    
    self.containerView.horisontalSpacing = 10;
    self.containerView.verticalSpacing = 10;
    self.containerView.centered = YES;
    self.containerView.topBorder = 100;
    
    UIButton* b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.frame = CGRectMake(30, 20, 100, 30);
    [b setTitle:@"New Game" forState:UIControlStateNormal];
    [self.view addSubview:b];

    [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)click:(id) sender{
    
    [self startNewGame];
}


-(void) loadView
{
    [super loadView];
    [self setupUI];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:@"SUPER" image:nil tag:0];
        self.tabBarItem = item;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}



@end
