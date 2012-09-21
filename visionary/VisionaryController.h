//
//  VisonaryController.h
//  Visionary
//
//  Created by Ichi Kanaya on 10/02/11.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QTKit/QTKit.h>
#import <QuartzCore/QuartzCore.h>

@interface VisonaryController: NSObject {
	IBOutlet NSView *mainView;
	IBOutlet NSButton *playPauseButton;
	IBOutlet QTMovieView *movieView00;
	IBOutlet QTMovieView *movieView01;
	IBOutlet QTMovieView *movieView02;
	IBOutlet QTMovieView *movieView03;
	IBOutlet QTMovieView *movieView04;
	IBOutlet QTMovieView *movieView05;
	IBOutlet QTMovieView *movieView06;
	IBOutlet QTMovieView *movieView07;
	IBOutlet QTMovieView *movieView08;
	IBOutlet NSButton *watchCheckBox00;
	IBOutlet NSButton *watchCheckBox01;
	IBOutlet NSButton *watchCheckBox02;
	IBOutlet NSButton *watchCheckBox03;
	IBOutlet NSButton *watchCheckBox04;
	IBOutlet NSButton *watchCheckBox05;
	IBOutlet NSButton *watchCheckBox06;
	IBOutlet NSButton *watchCheckBox07;
	IBOutlet NSButton *watchCheckBox08;
	IBOutlet NSButton *listenCheckBox00;
	IBOutlet NSButton *listenCheckBox01;
	IBOutlet NSButton *listenCheckBox02;
	IBOutlet NSButton *listenCheckBox03;
	IBOutlet NSButton *listenCheckBox04;
	IBOutlet NSButton *listenCheckBox05;
	IBOutlet NSButton *listenCheckBox06;
	IBOutlet NSButton *listenCheckBox07;
	IBOutlet NSButton *listenCheckBox08;
	CALayer *backgroundLayer;
	NSMutableArray *movieViews;
	NSMutableArray *watchCheckBoxes;
	NSMutableArray *listenCheckBoxes;
	NSMutableArray *movies;
	BOOL isPlayingMovies;
	int numberOfDisplayedMovies;
}

- (IBAction)playPause: (id)sender;
- (IBAction)stepForward: (id)sender;
- (IBAction)stepBackward: (id)sender;
- (IBAction)gotoBeginning: (id)sender;
- (IBAction)watchCheckBoxChanged: (id)sender;
- (IBAction)listenCheckBoxChanged: (id)sender;

- (IBAction)play: (id)sender;
- (IBAction)pause: (id)sender;

- (void)loadMovieFrom: (NSString *)filename to: (id)sender;

@end
