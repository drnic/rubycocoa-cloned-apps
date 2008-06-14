#
#  CollectionView.rb
#  IconView
#
#  Created by Dr Nic on 14/06/08.
#  Copyright (c) 2008 Dr Nic Academy Pty Ltd. All rights reserved.
#

require 'osx/cocoa'

class CollectionView < OSX::NSCollectionView
  include OSX
  def setSubviewSize(size)
    self.setMaxItemSize(NSSize.new(size, size))
    self.setMinItemSize(NSSize.new(size, size))
  end
end
