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
-(void) scaleCards:(UIPinchGestureRecognizer*)pinch;


@property (nonatomic,retain) CardMatchingGame* game;
@property (nonatomic,retain) NSMutableArray* cardButtons;
@property (nonatomic, retain) ContainerView* containerView;
@property (nonatomic, retain) UILabel* scoreLabel;
@property (nonatomic, retain) UILabel* flipsLabel;
@property (nonatomic) int flipsCounter;
@property (nonatomic) float lastScale;

@end

@implementation SecondCardGameViewController
@synthesize game = _game;
@synthesize cardButtons = _cardButtons;
@synthesize containerView = _containerView;
@synthesize scoreLabel = _scoreLabel;
@synthesize flipsLabel = _flipsLabel;
@synthesize flipsCounter;
@synthesize lastScale;

#define CARD_COUNT 12


#pragma mark -
#pragma mark game logig part

-(void) startNewGame
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
    self.flipsCounter = 0;
    
    for (UIView* v in self.containerView.subviews) {
        [v removeFromSuperview];
    }
    self.game = nil;
    PlayingCardDeck* newDeck = [[[PlayingCardDeck alloc] init] autorelease];
    self.game = [[CardMatchingGame alloc] initWithCardCount:CARD_COUNT usingDeck:newDeck gameMode:2];
    [self.game release];
    
    for (int i = 0; i<CARD_COUNT; i++) {
        
        CGRect frame = CGRectMake(0, 0, 60, 80);
        PlayingCardView* p = [[[PlayingCardView alloc] initWithFrame:frame] autorelease];
        PlayingCard* card = (PlayingCard*)[self.game cardAtIndex:i];
        p.suit = card.suit;
        p.rank = card.rank;
        
        UITapGestureRecognizer* recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipCard:)] autorelease];
        [p addGestureRecognizer:recognizer];
        
        [self.containerView addSubview:p];
    }
    
}

-(void) flipCard:(UITapGestureRecognizer*)sender
{
    self.flipsCounter++;
    [self.game flipCardAtIndex:[self.containerView.subviews indexOfObject:sender.view]];
    [self updateUI];
    NSLog(@"Tap--- %@", sender);
       
}
-(void) updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", self.game.score];
    
    
    for (PlayingCardView* p in self.containerView.subviews) {
        int index = [self.containerView.subviews indexOfObject:p];
        Card* card = [self.game cardAtIndex:index];
        p.isFaceUp = card.isFaceUp;
        if (card.isUnplayable) {
            p.alpha = 0.3;
            [p setUserInteractionEnabled:NO];
            //[p removeFromSuperview];
            //card.unplayable = NO;
        }
    }
}


-(void) setFlipsCounter:(int)c
{
    flipsCounter = c;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %i",self.flipsCounter];
    [self.flipsLabel sizeToFit];
}

-(void)click:(id) sender{
    
    [self startNewGame];
}


#pragma mark -

-(void) setupUI
{
    
    self.containerView = [[[ContainerView alloc] initWithFrame:self.view.bounds] autorelease];
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
    
    //additional info Labels
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, 0, 0)];
    [self.scoreLabel release];
    self.scoreLabel.text = @"Score: 0      ";
    [self.scoreLabel sizeToFit];
    self.scoreLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scoreLabel];
    
    self.flipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 40, 0, 0)];
    [self.flipsLabel release];
    self.flipsLabel.text = @"Flips: 0";
    [self.flipsLabel sizeToFit];
    self.flipsLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.flipsLabel];
    
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
    
    UIPinchGestureRecognizer* recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleCards:)];
    [self.view addGestureRecognizer:recognizer];

}

-(void)scaleCards:(UIPinchGestureRecognizer *)pinch
{
    if (!self.lastScale) {
        self.lastScale = 1.0;
    }
    float scale = 1 + (lastScale-pinch.scale);
    NSLog(@"scale %f", scale);
    //self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pinch.scale, pinch.scale);
    
    for (PlayingCardView* p in self.containerView.subviews) {
        p.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    }
    //[pinch setScale:1.0];
    [self.containerView setNeedsDisplay];
    self.lastScale = pinch.scale;
}




@end
