#import <Cocoa/Cocoa.h>

@interface View : NSView {
  BOOL m_isSelected;
  id m_theDelegate;
}

-(id)delegate;
-(void)setDelegate:(id)theDelegate;
-(void)setSelected:(BOOL)flag;
-(BOOL)selected;

@end

@interface NSObject (ViewDelegate)
-(void)doubleClick:(id)sender;
@end