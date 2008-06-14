#
#  CollectionViewItem.rb
#  IconView
#
#  Created by Dr Nic on 14/06/08.
#  Copyright (c) 2008 Dr Nic Academy Pty Ltd. All rights reserved.
#

require 'osx/cocoa'

class CollectionViewItem < OSX::NSCollectionViewItem
  def selected=(flag)
    super_setSelected flag
    
    # tell the view that it has been selected
    if view.isKindOfClass(View.class)
      view.selected = flag
      view.setNeedsDisplay true
    end
  end
  alias_method :setSelected, :selected=
end
