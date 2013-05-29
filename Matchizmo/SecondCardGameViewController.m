//
//  SecondCardGameViewController.m
//  Matchizmo
//
//  Created by yura on 5/29/13.
//
//





#import "SecondCardGameViewController.h"

@interface SecondCardGameViewController ()

-(void) setupUI;
-(void) updateUI;
-(void) relayoutCards;


@property CardMatchingGame* game;
@property NSMutableArray* cardButtons;




@end

@implementation SecondCardGameViewController
@synthesize game = _game;
@synthesize cardButtons = _cardButtons;



#define CARD_COUNT 12


-(void) newGame
{
    self.game = nil;
    PlayingCardDeck* newDeck = [[[PlayingCardDeck alloc] init] autorelease];
    self.game = [[CardMatchingGame alloc] initWithCardCount:CARD_COUNT usingDeck:newDeck gameMode:2];
}






-(void) setupUI
{
    int width = 30;     int horisontalBorder = 10;
    int height = 50;    int verticalBorder = 10;
    
    
    
    for (int i = 0; i < 2; i++) {
        CGRect frame = CGRectMake(width *i, height*i, width, height);
        UIButton* button = [[UIButton alloc] initWithFrame:frame];
        button.backgroundColor = [UIColor redColor];
        //UILabel* label = [[UILabel alloc] initWithFrame:frame];
        [self.view addSubview:button];
    }
    
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
    [self setupUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end