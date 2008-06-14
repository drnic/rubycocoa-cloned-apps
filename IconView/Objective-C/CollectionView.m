#import "CollectionView.h"

@implementation CollectionView

-(void)setSubviewSize:(CGFloat)theSubviewSize {
  [self setMaxItemSize:NSMakeSize(theSubviewSize,theSubviewSize)];
  [self setMinItemSize:NSMakeSize(theSubviewSize,theSubviewSize)];
}

@end
