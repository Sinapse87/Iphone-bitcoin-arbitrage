//
//  ViewController.h
//  HelloUCD
//
//  Created by LUCA ALIBERTI on 08/01/2014.
//  Copyright (c) 2014 UCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)imageTapEvent:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *ucdLogo;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@end
