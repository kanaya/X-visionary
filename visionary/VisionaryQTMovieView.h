//
//  VisionaryQTMovieView.h
//  Visionary
//
//  Created by Ichi Kanaya on 10/02/11.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QTKit/QTKit.h>
#import "VisionaryController.h"

@interface VisionaryQTMovieView: QTMovieView {
	IBOutlet VisonaryController *controller;
}

@end
