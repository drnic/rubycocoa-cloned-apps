//
//  View.m
//  IconView
//
//  Created by David Thorpe on 03/12/2007.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

-(id)copyWithZone:(NSZone *)zone {
  View* theCopy = [[View allocWithZone:zone] initWithFrame:[self frame]];
  [theCopy setDelegate:[self delegate]];
  [theCopy setSelected:[self selected]];  
  return theCopy;
}

-(void)setSelected:(BOOL)flag {
  m_isSelected = flag;
}

-(id)delegate {
  return m_theDelegate;
}

-(void)setDelegate:(id)theDelegate {
  m_theDelegate = theDelegate;
}

-(BOOL)selected {
  return m_isSelected;
}

-(void)drawRect:(NSRect)rect {
  if([self selected]) {
    [[NSColor grayColor] set];
    NSFrameRect(NSInsetRect([self bounds], 1.0, 1.0));    
  }
  [super drawRect:rect];
}

-(NSView *)hitTest:(NSPoint)aPoint {
	// don't allow any mouse clicks for subviews in this view
  if(NSPointInRect(aPoint,[self convertRect:[self bounds] toView:[self superview]])) {
    return self;
  } else {
    return nil;    
  }
}

-(void)mouseDown:(NSEvent *)theEvent {
  [super mouseDown:theEvent];

  // check for click count above one
  if([theEvent clickCount] > 1) {
    if([[self delegate] respondsToSelector:@selector(doubleClick:)]) {
      [[self delegate] doubleClick:self];
    }
  }
}

@end
