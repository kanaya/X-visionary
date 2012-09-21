//
//  VisionaryQTMovieView.m
//  Visionary
//
//  Created by Ichi Kanaya on 10/02/11.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "VisionaryQTMovieView.h"


@implementation VisionaryQTMovieView

- (void)awakeFromNib {
	[self registerForDraggedTypes: [NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
}

- (NSDragOperation)draggingEntered: (id <NSDraggingInfo>)sender {
	NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
	
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
	
    if ([[pboard types] containsObject: NSFilenamesPboardType]) {
		return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

- (BOOL)performDragOperation: (id <NSDraggingInfo>)sender {
	NSLog(@"YES");
	
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
	
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
	if ([[pboard types] containsObject: NSFilenamesPboardType]) {
        NSArray *files = [pboard propertyListForType: NSFilenamesPboardType];
		[controller loadMovieFrom: [files objectAtIndex: 0] to: self]; 
    }
    return YES;
}


@end
