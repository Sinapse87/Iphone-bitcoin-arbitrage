//
//  PhotoVC.h
//  FlickrBrowser
//
//  Created by comp41550 on 18/03/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"


@class PhotoVC;

@protocol photoVCDelegate <NSObject>
    - (void)photoVCDelegate:(PhotoVC *)photoVC didPressAddTOFavouriteButton:(NSURL *)photoURL;
@end

@interface PhotoVC : UIViewController

    @property (nonatomic, strong) NSURL *photoURL;
    @property (nonatomic, assign) id<photoVCDelegate> delegate;

    - (IBAction)addPhotoToFavouriteButtonPressed:(UIBarButtonItem *)sender;

@end
