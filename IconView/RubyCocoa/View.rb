#
#  View.rb
#  IconView
#
#  Created by Dr Nic on 14/06/08.
#  Copyright (c) 2008 Dr Nic Academy Pty Ltd. All rights reserved.
#

require 'osx/cocoa'

class View <  OSX::NSView
  include OSX
  attr_accessor :selected, :delegate
  alias_method :selected?, :selected

  # TODO - what's this do?
  def copyWithZone(zone)
    viewCopy = View.allocWithZone(zone).initWithFrame(frame)
    viewCopy.delegate = delegate
    viewCopy.selected = selected
    viewCopy
  end
  
  # overrides NSView to draw rectangle if selected?
  def drawRect(rect)
    if selected?
      NSColor.grayColor.set
      NSFrameRect(NSInsetRect(bounds, 1.0, 1.0))
    end
    super_drawRect rect
  end
  
  def hitTest(point)
  	# don't allow any mouse clicks for subviews in this view
    if NSPointInRect(point, self.convertRect_toView(bounds, superview))
      self 
    else
      nil
    end
  end
  
  def mouseDown(event)
    # TODO - super_mouseDown doesn't exist?
    super_mouseDown(event)
    NSLog(event.clickCount.to_s)

    # check for double-clicks
    if event.clickCount > 1
      NSLog(self.delegate.inspect)
      self.delegate.doubleClick(self) rescue nil if self.delegate
    end
  end
end
