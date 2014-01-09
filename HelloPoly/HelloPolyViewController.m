//
//  HelloPolyViewController.m
//  HelloPoly
//
//  Created by comp41550 on 09/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "HelloPolyViewController.h"
#import "PolygonShape.h"

@interface HelloPolyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) PolygonShape *polygonShapeModel;
@property (weak,nonatomic) IBOutlet UILabel *numSidesLabel;
@end

@implementation HelloPolyViewController

- (PolygonShape *)polygonShapeModel
{
    if (!_polygonShapeModel)
    {
        _polygonShapeModel = [PolygonShape new];
    }
    return _polygonShapeModel;
}

- (void)updateUI
{
    self.displayLabel.text = self.polygonShapeModel.name;
    [self.displayLabel sizeToFit];
}

- (IBAction)increaseSides:(id)sender {
    NSLog(@"current polygon: %@", self.polygonShapeModel.description);
    self.polygonShapeModel.numberOfSides = self.polygonShapeModel.numberOfSides + 1;
    [self updateUI];
}


- (IBAction)decreaseSides:(id)sender {
    self.polygonShapeModel.numberOfSides--;
    [self updateUI];
    NSLog(@"Decrease");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
