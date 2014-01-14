//
//  ViewController.h
//  HelloUCD
//
//  Created by LUCA ALIBERTI on 08/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

NSArray *imagesArray;
NSArray *textArray;


static int displayedImageAndTextIndex;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.ucdLogo setUserInteractionEnabled:YES];
    imagesArray = [NSArray arrayWithObjects:
                 [UIImage imageNamed:@"largeUCDLogo.png"],
                 [UIImage imageNamed:@"Accomodation.jpg"],
                 [UIImage imageNamed:@"Sportcenter.jpg"],
                 [UIImage imageNamed:@"map.png"],
                 nil];	// Do any additional setup after loading the view, typically from a nib.
    displayedImageAndTextIndex = 0;
    textArray = [NSArray arrayWithObjects:@"HELLOUCD",@"ACCOMODATION",@"SPORTCENTER",@"MAP",nil];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageTapEvent:(UITapGestureRecognizer *)sender {
    //Animate the image for a short tap event
    displayedImageAndTextIndex++;
    self.ucdLogo.image = imagesArray [displayedImageAndTextIndex % [imagesArray count]];
    self.mainLabel.text = textArray [displayedImageAndTextIndex % [imagesArray count]];
    [self.mainLabel sizeToFit];
}
@end
