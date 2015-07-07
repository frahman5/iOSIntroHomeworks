//
//  HWViewController.m
//  Homework1
//
//  Created by Faiyam Rahman on 9/11/14.
//  Copyright (c) 2014 FaiyamLearningiOS. All rights reserved.
//

#import "HWViewController.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface HWViewController ()
@property (strong, nonatomic) IBOutlet UITextField *firstWord;
@property (strong, nonatomic) IBOutlet UITextField *secondWord;
@property (strong, nonatomic) NSMutableDictionary *portsDict;
@property (strong, nonatomic) IBOutlet UILabel *pairWord;

@property (strong, nonatomic) IBOutlet UITextField *wholeWord;
@property (strong, nonatomic) IBOutlet UILabel *separatedWords;

@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initalize the dictionary
    self.portsDict = [[NSMutableDictionary alloc] init];
}

- (IBAction)combine:(id)sender {
    // Make sure the user entered two words
    if ([self.firstWord.text isEqualToString:@""] ||
        [self.secondWord.text isEqualToString:@""]) {
        self.pairWord.text = @"You must enter TWO words!";
        return;
    }
    // add the portmanteau to the dictionary
    NSString *portmanteau = [[NSString alloc] initWithString:self.firstWord.text];
    portmanteau = [portmanteau stringByAppendingString:self.secondWord.text];
    [self.portsDict setObject:@[[self.firstWord.text capitalizedString],
                                [self.secondWord.text capitalizedString]]
                       forKey:[portmanteau lowercaseString]];
    
    // Update the user
    self.pairWord.text = portmanteau;
    
    // Play a sound effect
    AVAudioPlayer *audioPlayerObj;
    
    NSString *filePath;
    
    filePath= [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] resourcePath]];
    
    if(!audioPlayerObj)
        audioPlayerObj = [AVAudioPlayer alloc];
    
    NSURL *acutualFilePath= [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",filePath,
                                                    @"ByYourSidePt1.aiff"]];
    
    NSError *error;
    
    [audioPlayerObj initWithContentsOfURL:acutualFilePath error:&error];
    
    [audioPlayerObj play];
    // log updated info to console
    NSLog(@"%@%@", self.firstWord.text, self.secondWord.text);
    NSLog(@"The dictionary is: %@", self.portsDict);
    

}


- (IBAction)showPieces:(id)sender {
    
    // Clear the nonactive text
    self.pairWord.text = @"";
    
    // check if portmanteau is in dictionary keys and respond appropriately
    NSString *checkWord = [self.wholeWord.text lowercaseString];
    if ([[self.portsDict allKeys] containsObject: checkWord]) {
        // Construct answer
        NSArray *answerArray = [self.portsDict objectForKey:checkWord];
        NSString *answerString = [[[[NSString alloc]
                                    initWithString: [answerArray objectAtIndex:0]]
                                    stringByAppendingString:@"\n"]
                                    stringByAppendingString:[answerArray objectAtIndex:1]];
        // Serve it up tothe user
        self.separatedWords.text = answerString;
    } else if ([self.wholeWord.text isEqualToString:@""]){
        self.separatedWords.text = @"You must enter a portmanteau dummy -.-";
    } else {
        // Let the user know he sucks
        self.separatedWords.text = @"Oops! You haven't taught me that word yet :(";
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
