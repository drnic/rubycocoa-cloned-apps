//
//  Controller.m
//  IconView
//
//  Created by David Thorpe on 03/12/2007.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"

@implementation Controller

-(id)init {
  self = [super init];
  if (self != nil) {
    m_thePath = nil;
    m_theIcons = nil;
    m_theSelectedIndexes = nil;
  }
  return self;
}

-(void)dealloc {
  [m_thePath release];
  [m_theIcons release];
  [m_theSelectedIndexes release];
  [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////

-(NSMutableArray* )icons {
  return m_theIcons;
}

-(void)setIcons:(NSMutableArray* )theIcons {
  [theIcons retain];
  [m_theIcons release];
  m_theIcons = theIcons;
}

-(NSURL* )path {
  return m_thePath;
}

-(NSString* )pathAsString {
  return [[self path] path];
}

-(void)setPath:(NSURL* )thePath {
  [thePath retain];
  [m_thePath release];
  m_thePath = thePath;
}

-(CollectionView* )ibCollectionView {
  NSParameterAssert(m_ibCollectionView);
  return m_ibCollectionView;
}

////////////////////////////////////////////////////////////////////////////////

-(void)setIconsForPath {
  // fetch filenames
  NSError* theError = nil;
  NSString* thePath = [self pathAsString];
  NSArray* theFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:thePath error:&theError];
  if(theError) {
    NSLog(@"Error: %@: for path: %@",theError,thePath);
    return;
  }

  // create icons
  NSMutableArray* theIcons = [NSMutableArray array];
  for(NSString* theFilename in theFiles) {
    // ignore hidden files
    if([theFilename hasPrefix:@"."]) continue;
    // add the path
    NSString* theFilePath = [thePath stringByAppendingPathComponent:theFilename];
    NSDictionary* theDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [[NSWorkspace sharedWorkspace] iconForFile:theFilePath],@"image",
                                   theFilePath,@"path",
                                   theFilename,@"filename",
                                   nil];
    [theIcons addObject:theDictionary];
  }
  
  [self setIcons:theIcons];
}

-(NSIndexSet* )selectedIndexes {
  return m_theSelectedIndexes;
}

-(void)setSelectedIndexes:(NSIndexSet* )theSelectedIndexes {
  [theSelectedIndexes retain];
  [m_theSelectedIndexes release];
  m_theSelectedIndexes = theSelectedIndexes;
}

////////////////////////////////////////////////////////////////////////////////

-(void)awakeFromNib {
  // use home directory as the path
  [self setPath:[NSURL fileURLWithPath:NSHomeDirectory()]];
  // set the icons for this path
  [self setIconsForPath];
}

////////////////////////////////////////////////////////////////////////////////

-(IBAction)doChangePath:(id)sender {
  NSPathControl* theControl = sender;
  NSParameterAssert([theControl isKindOfClass:[NSPathControl class]]);
  [self setPath:[[theControl clickedPathComponentCell] URL]];
  [self setIconsForPath];
}

-(IBAction)doubleClick:(id)sender {
  if([[self selectedIndexes] count] > 1) {
    // do nothing for multiple select
    return;
  }
  // cycle through the icon dictionaries, finding the correct path
  NSUInteger i = 0;
  for(; i < [[self icons] count]; i++) {
    if([[self selectedIndexes] containsIndex:i]) {
      // select this path
      NSString* thePathAsString = [[[self icons] objectAtIndex:i] objectForKey:@"path"];
      NSParameterAssert(thePathAsString);
      [self setPath:[NSURL fileURLWithPath:thePathAsString]];
      [self setIconsForPath];
    }
  }
}

-(IBAction)setIconSize:(id)sender {
  CGFloat theSize = [sender floatValue];
  [[self ibCollectionView] setSubviewSize:theSize];
}

@end
