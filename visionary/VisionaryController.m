//
//  VisonaryController.m
//  Visionary
//
//  Created by Ichi Kanaya on 10/02/11.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <stdlib.h>
#import "VisionaryController.h"

@implementation VisonaryController

#define N_VIEWS 9

- (void)updatePlayButton {
	if (isPlayingMovies == YES) {
		[playPauseButton setTitle: @"||"];
	}
	else {
		[playPauseButton setTitle: @">"];
	}
}

- (void)hideInvisibleMovies {
	NSEnumerator *watchCheckBoxEnumerator = [watchCheckBoxes objectEnumerator];
	NSEnumerator *movieLayerEnumerator = [[backgroundLayer sublayers] objectEnumerator];
	NSButton *watchCheckBox;
	CALayer *movieLayer;
	while (watchCheckBox = [watchCheckBoxEnumerator nextObject]) {
		movieLayer = [movieLayerEnumerator nextObject];
		if ([watchCheckBox state] == NSOnState) {
			movieLayer.hidden = NO;
		}
		else {
			movieLayer.hidden = YES;
		}
	}
}

- (void)muteNotListeningMovies {
	NSEnumerator *listenCheckBoxEnumerator = [listenCheckBoxes objectEnumerator];
	NSEnumerator *movieEnumerator = [movies objectEnumerator];
	NSButton *listenCheckBox;
	QTMovie *movie;
	while (listenCheckBox = [listenCheckBoxEnumerator nextObject]) {
		movie = [movieEnumerator nextObject];
		if ([listenCheckBox state] == NSOnState) {
			[movie setMuted: NO];
		}
		else {
			[movie setMuted: YES];
		}
	}
}

- (void)arrangeMovieLayers {
	int divisionLevel = 1;
	int viewWidth = 1280;  // Pay attention!
	int viewHeight = 720;
	int subViewWidth, subViewHeight;
	if (numberOfDisplayedMovies > 4) {
		divisionLevel = 3;
	}
	else if (numberOfDisplayedMovies > 1) {
		divisionLevel = 2;
	}
	subViewWidth = viewWidth / divisionLevel;
	subViewHeight = viewHeight / divisionLevel;
	int i = 0;
	for (CALayer *layer in backgroundLayer.sublayers) {
		if (layer.hidden == NO) {
			int u = i % divisionLevel;
			int v = i / divisionLevel;
			layer.frame = CGRectMake(0, 0, subViewWidth, subViewHeight);
			layer.bounds = CGRectMake(0, 0, subViewWidth, subViewHeight); 
			layer.position = CGPointMake(u * subViewWidth + subViewWidth / 2, v * subViewHeight + subViewHeight / 2);
			++i;
		}
	}
}

- (void)setMovieToArrayAndMovieViewAndMovieLayer: (QTMovie *)movie at: (int)n {
	// QTMovie *currentMovie = [movies objectAtIndex: n];
	[movies replaceObjectAtIndex: n withObject: movie];
	[[movieViews objectAtIndex: n] setMovie: movie];
	[[[backgroundLayer sublayers] objectAtIndex: n] setMovie: movie];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(movieDidEnd:)
												 name: QTMovieDidEndNotification
											   object: movie];
}

- (void)movieDidEnd: (NSNotification *)notification {
	[self pause: self];
	[self gotoBeginning: self];
	isPlayingMovies = NO;
	[self updatePlayButton];
}

- (void)awakeFromNib {
	movies = [NSMutableArray arrayWithCapacity: N_VIEWS];
	movieViews = [NSMutableArray arrayWithCapacity: N_VIEWS];
	watchCheckBoxes = [NSMutableArray arrayWithCapacity: N_VIEWS];
	listenCheckBoxes = [NSMutableArray arrayWithCapacity: N_VIEWS];
	[movieViews addObject: movieView00];
	[movieViews addObject: movieView01];
	[movieViews addObject: movieView02];
	[movieViews addObject: movieView03];
	[movieViews addObject: movieView04];
	[movieViews addObject: movieView05];
	[movieViews addObject: movieView06];
	[movieViews addObject: movieView07];
	[movieViews addObject: movieView08];
	[watchCheckBoxes addObject: watchCheckBox00];
	[watchCheckBoxes addObject: watchCheckBox01];
	[watchCheckBoxes addObject: watchCheckBox02];
	[watchCheckBoxes addObject: watchCheckBox03];
	[watchCheckBoxes addObject: watchCheckBox04];
	[watchCheckBoxes addObject: watchCheckBox05];
	[watchCheckBoxes addObject: watchCheckBox06];
	[watchCheckBoxes addObject: watchCheckBox07];
	[watchCheckBoxes addObject: watchCheckBox08];
	[listenCheckBoxes addObject: listenCheckBox00];
	[listenCheckBoxes addObject: listenCheckBox01];
	[listenCheckBoxes addObject: listenCheckBox02];
	[listenCheckBoxes addObject: listenCheckBox03];
	[listenCheckBoxes addObject: listenCheckBox04];
	[listenCheckBoxes addObject: listenCheckBox05];
	[listenCheckBoxes addObject: listenCheckBox06];
	[listenCheckBoxes addObject: listenCheckBox07];
	[listenCheckBoxes addObject: listenCheckBox08];

	backgroundLayer = [CALayer layer];
	CGColorRef blackColor = CGColorCreateGenericGray(0, 0.8);
	backgroundLayer.backgroundColor = blackColor;
	CGColorRelease(blackColor);
	
	NSError *error;
	QTMovie *dummyMovie = [QTMovie movieWithFile: [[NSBundle mainBundle] pathForResource: @"sample"
																				   ofType: @"mov"]
										   error: &error];	
	int n;
	for (n = 0; n < N_VIEWS; ++n) {
		[movies addObject: dummyMovie];
		[[movieViews objectAtIndex: n] setMovie: dummyMovie];
		[[movieViews objectAtIndex: n] setControllerVisible: NO];
		
		QTMovieLayer *movieLayer = [QTMovieLayer layerWithMovie: dummyMovie];
		movieLayer.frame = CGRectMake(0, 0, 320, 180);  // !!!
		movieLayer.bounds = CGRectMake(0, 0, 320, 180);  // !!!
		movieLayer.position = CGPointMake(0, 0);
		[backgroundLayer addSublayer: movieLayer];
	}

	isPlayingMovies = NO;
	numberOfDisplayedMovies = 1;

	[self muteNotListeningMovies];
	[self hideInvisibleMovies];
	[self arrangeMovieLayers];
	
	[mainView setLayer: backgroundLayer];
	[mainView setWantsLayer: YES];
}

- (IBAction)playPause: (id)sender {
	if (isPlayingMovies == NO) {
		[self play: self];
		isPlayingMovies = YES;
	}
	else {
		[self pause: self];
		isPlayingMovies = NO;
	}
	[self updatePlayButton];
}

- (IBAction)stepForward: (id)sender {
	for (QTMovie *movie in movies) {
		[movie stepForward];
	}
}

- (IBAction)stepBackward: (id)sender {
	for (QTMovie *movie in movies) {
		[movie stepBackward];
	}
}

- (IBAction)gotoBeginning: (id)sender {
	for (QTMovie *movie in movies) {
		[movie gotoBeginning];
	}
}

- (IBAction)watchCheckBoxChanged: (id)sender {
	int n = 0;
	for (NSButton *checkBox in watchCheckBoxes) {
		if ([checkBox state] == NSOnState) {
			++n;
		}
	}
	numberOfDisplayedMovies = n;
	
	[self hideInvisibleMovies];
	[self arrangeMovieLayers];
}

- (IBAction)listenCheckBoxChanged: (id)sender {
	[self muteNotListeningMovies];
}

- (IBAction)play: (id)sender {
	for (QTMovie *movie in movies) {
		[movie play];
	}
}

- (IBAction)pause: (id)sender {
	for (QTMovie *movie in movies) {
		[movie stop];
	}
}

- (void)loadMovieFrom: (NSString *)filename to: (id)sender {
	int i;
	for (i = 0; i < N_VIEWS; ++i) {
		QTMovieView *movieView = [movieViews objectAtIndex: i];
		if (sender == movieView) {
			break;
		}
	}
	
	NSError *error;
	QTMovie *movie = [QTMovie movieWithFile: filename
									  error: &error];
	if (movie == nil) {
		NSLog(@"load error with %@", [error localizedDescription]);
	}
	[self setMovieToArrayAndMovieViewAndMovieLayer: movie at: i];
}


@end
