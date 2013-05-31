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


@interface SecondCardGameViewController ()

-(void) setupUI;
-(void) updateUI;
-(void) relayoutCards;


@property CardMatchingGame* game;
@property NSMutableArray* cardButtons;
@property (nonatomic, retain) ContainerView* containerView;



@end

@implementation SecondCardGameViewController
@synthesize game = _game;
@synthesize cardButtons = _cardButtons;
@synthesize containerView = _containerView;


#define CARD_COUNT 12


-(void) startNewGame
{
    self.game = nil;
    PlayingCardDeck* newDeck = [[[PlayingCardDeck alloc] init] autorelease];
    self.game = [[CardMatchingGame alloc] initWithCardCount:CARD_COUNT usingDeck:newDeck gameMode:2];
}






-(void) setupUI
{
    int width = 30;     int horisontalBorder = 10;
    int height = 50;    int verticalBorder = 10;
    
    self.containerView = [[ContainerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.containerView];
    
    for (int i = 1; i <=12; i++) {
        
        //UILabel* label = [[UILabel alloc] initWithFrame:frame];
        //label.text = [NSString stringWithFormat:@"%i",i];
        //[self.view addSubview:button];
        //UILabel* label = [[UILabel alloc] initWithFrame:frame];
        
        
        CGRect frame = CGRectMake(0, 0, 60, 80);
        PlayingCardView* card = [[PlayingCardView alloc] initWithFrame:frame];
        card.rank = 10;
        card.suit = [NSString stringWithFormat:@"%i",i];
        [self.containerView addSubview:card];
    }
    
    
    self.containerView.horisontalSpacing = 10;
    self.containerView.verticalSpacing = 10;
    self.containerView.centered = YES;
    self.containerView.topBorder = 100;
    
    
    CGRect frame = CGRectMake(20, 20, 200, 20);
    UIButton* b = [[UIButton alloc] initWithFrame:frame];
    b.backgroundColor = [UIColor yellowColor];
    b.titleLabel.text = @"trattata";
    [self.view addSubview:b];
    
    [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)click:(id) sender{
    
    NSLog(@"Click ---");
    UIView* v = [self.containerView.subviews objectAtIndex:0];
    [v removeFromSuperview];  
    //self.containerView.centered = NO;
    //self.containerView.topBorder = 200;
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
