//
//  MyDocument.m
//  Visionary
//
//  Created by Ichi Kanaya on 10/02/11.
//  Copyright Apple Inc 2010 . All rights reserved.
//

#import "VisionaryDoc.h"

@implementation VisionaryDoc

- (id)init 
{
    self = [super init];
    if (self != nil) {
        // initialization code
    }
    return self;
}

- (NSString *)windowNibName {
    return @"VisionaryDoc";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    // user interface preparation code
}

@end
