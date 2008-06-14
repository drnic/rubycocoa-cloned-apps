
#import "CollectionViewItem.h"
#import "View.h"

@implementation CollectionViewItem

-(void)setSelected:(BOOL)flag {
  [super setSelected:flag];
  
  // tell the view that it has been selected
  View* theView = (View* )[self view];
  if([theView isKindOfClass:[View class]]) {
    [theView setSelected:flag];
    [theView setNeedsDisplay:YES];
  }
}

@end
