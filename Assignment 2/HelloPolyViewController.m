//
//  HelloPolyViewController.m
//  HelloPoly
//
//  Created by comp41550 on 09/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "HelloPolyViewController.h"
#import "PolygonShape.h"
#import "PolygonView.h"

@interface HelloPolyViewController () <PolygonViewDelegate>
@property (weak, nonatomic) IBOutlet PolygonView *polygonView;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) PolygonShape *polygonShapeModel;
@property (weak,nonatomic) IBOutlet UILabel *numSidesLabel;
@property (weak,nonatomic) NSString *numSidesText;
@property (weak,nonatomic) NSUserDefaults *defaults;
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

- (NSArray *)pointsInRect:(CGRect)rect
{
    return [self.polygonShapeModel pointsInRect:rect];
}

- (void)updateUI
{
    self.displayLabel.text = self.polygonShapeModel.shapeName;
    _numSidesText = [NSString stringWithFormat:@" : %i", self.polygonShapeModel.numberOfSides];
    self.numSidesLabel.text = [@"Number of sides" stringByAppendingString:_numSidesText];
    
    [self.numSidesLabel sizeToFit];
    
    [self.displayLabel sizeToFit];

    [self.polygonView setNeedsDisplay];
}

- (IBAction)increaseSides:(UIButton *)sender {
 
    self.polygonShapeModel.numberOfSides ++;
    NSLog(@"current polygon: %@", self.polygonShapeModel.description);
    [self updateUI];
}


- (IBAction)decreaseSides:(UIButton *)sender {
    self.polygonShapeModel.numberOfSides--;
    NSLog(@"current polygon: %@", self.polygonShapeModel.description);
    [self updateUI];
}


-(void)handleNotification:(NSNotification*)notification {
    NSString *name = notification.name;
    if ( [name isEqual:UIApplicationDidEnterBackgroundNotification] ) {
        [_defaults setObject:[NSNumber numberWithInt:self.polygonShapeModel.numberOfSides] forKey:@"numberOfSide"];
        [_defaults synchronize];
    }
}
         
         
- (void)viewDidLoad
{
    [super viewDidLoad];
        // you can also attempt to read stored values form disk here
        // perform all your other initialization that you already have
    
    /* RESTORING VARIABLES IN NSUSER DEFAULT AND INITIALISING OBSERVER FOR DIDENTERBACKGROUND METHOD
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    _defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *lastNumberOfSide = [_defaults objectForKey:@"numberOfSide"];
    self.polygonShapeModel.numberOfSides = [lastNumberOfSide intValue];
     **/
    
    [self updateUI];
}
                                  
- (void)applicationWillTerminate:(UIApplication *)application
{
    [_defaults setObject:[NSNumber numberWithInt:self.polygonShapeModel.numberOfSides] forKey:@"numberOfSide"];
    [_defaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
                                  
