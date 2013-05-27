//
//  ViewController.m
//  Matchizmo
//
//  Created by admin on 19.05.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (nonatomic) NSUInteger gameMode;
@property (nonatomic, retain) CardMatchingGame* game;
@property (retain, nonatomic) IBOutlet UILabel *flipsLabel;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) IBOutlet UILabel *historyLabel;
@property (retain, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (nonatomic) int flipCount;
@property (nonatomic, retain) PlayingCardDeck* deck;
@property (nonatomic, retain) NSArray* cardButtons;

@property (retain, nonatomic) IBOutlet UIButton *card1;
@property (retain, nonatomic) IBOutlet UIButton *card2;
@property (retain, nonatomic) IBOutlet UIButton *card3;
@property (retain, nonatomic) IBOutlet UIButton *card4;
@property (retain, nonatomic) IBOutlet UIButton *card5;
@property (retain, nonatomic) IBOutlet UIButton *card6;
@property (retain, nonatomic) IBOutlet UIButton *card7;
@property (retain, nonatomic) IBOutlet UIButton *card8;
@property (retain, nonatomic) IBOutlet UIButton *card9;
@property (retain, nonatomic) IBOutlet UIButton *card10;
@property (retain, nonatomic) IBOutlet UIButton *card11;
@property (retain, nonatomic) IBOutlet UIButton *card12;

-(void) updateUI;

@end


@implementation ViewController

@synthesize gameModeSegmentedControl = _gameModeSegmentedControl;
@synthesize gameMode = _gameMode;
@synthesize game = _game;
@synthesize flipsLabel;
@synthesize scoreLabel = _scoreLabel;
@synthesize historyLabel = _historyLabel;
@synthesize flipCount = _flipCount;
@synthesize deck = _deck;
@synthesize cardButtons = _cardButtons;
@synthesize card1 = _card1;
@synthesize card2 = _card2;
@synthesize card3 = _card3;
@synthesize card4 = _card4;
@synthesize card5 = _card5;
@synthesize card6 = _card6;
@synthesize card7 = _card7;
@synthesize card8 = _card8;
@synthesize card9 = _card9;
@synthesize card10 = _card10;
@synthesize card11 = _card11;
@synthesize card12 = _card12;

/*
-(CardMatchingGame*) game 
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck gameMode:self.gameMode];
    return _game;
}
 */

-(NSArray*) cardButtons
{
    _cardButtons = [[NSArray alloc] initWithObjects:_card1,_card2,self.card3,self.card4,self.card5,self.card6,self.card7,self.card8,self.card9,self.card10,self.card11,self.card12,nil];
    return _cardButtons;
}

- (IBAction)newGame:(id)sender {
    self.game = nil;
    self.deck = [[PlayingCardDeck alloc] init];
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck gameMode:self.gameMode];
    self.flipCount = 0;
    [self updateUI];
    self.gameModeSegmentedControl.enabled = YES;
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %i", self.flipCount];
}

-(PlayingCardDeck*) deck
{
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}
- (IBAction)gameModeChanged:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.gameMode = 2;
    } else if (sender.selectedSegmentIndex == 1) {
        self.gameMode = 3;
    }
    [self newGame:[NSNull null]];
}

-(void) updateUI
{
    UIImage* backImage = [UIImage imageNamed:@"lock.png"];
    for (UIButton* cardButton in self.cardButtons) {
        Card* card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setImage:backImage forState:UIControlStateNormal];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        cardButton.selected = card.isFaceUp;
        if (cardButton.selected) [cardButton setImage:nil forState:UIControlStateNormal];
        cardButton.enabled = !card.isUnplayable && !card.isFaceUp;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%i",self.game.score];
    self.historyLabel.text = self.game.lastFlipResult;
}




- (IBAction)flipCard:(UIButton*)sender 
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.gameModeSegmentedControl.enabled = NO;
    self.gameModeSegmentedControl.alpha = 0.7;
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self newGame:nil];
}

- (void)viewDidUnload
{
    [self setFlipsLabel:nil];
    [self setCard1:nil];
    [self setCard2:nil];
    [self setCard3:nil];
    [self setCard4:nil];
    [self setCard5:nil];
    [self setCard6:nil];
    [self setCard7:nil];
    [self setCard8:nil];
    [self setCard9:nil];
    [self setCard10:nil];
    [self setCard11:nil];
    [self setCard12:nil];
    [self setScoreLabel:nil];
    [self setHistoryLabel:nil];
    [self setGameModeSegmentedControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [flipsLabel release];
    [_card1 release];
    [_card2 release];
    [_card3 release];
    [_card4 release];
    [_card5 release];
    [_card6 release];
    [_card7 release];
    [_card8 release];
    [_card9 release];
    [_card10 release];
    [_card11 release];
    [_card12 release];
    [_scoreLabel release];
    [_historyLabel release];
    [_gameModeSegmentedControl release];
    [super dealloc];
}
@end
