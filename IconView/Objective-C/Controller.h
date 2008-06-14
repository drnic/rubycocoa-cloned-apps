#import <Cocoa/Cocoa.h>
#import "CollectionView.h"

@interface Controller : NSObject {
  NSURL* m_thePath;
  NSMutableArray* m_theIcons;
  NSIndexSet* m_theSelectedIndexes;
  
  // interface builder
  IBOutlet CollectionView* m_ibCollectionView;
}

-(IBAction)doChangePath:(id)sender;
-(IBAction)doubleClick:(id)sender;
-(IBAction)setIconSize:(id)sender;

@end
