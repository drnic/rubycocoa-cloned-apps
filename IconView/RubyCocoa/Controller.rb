#
#  Controller.rb
#  IconView
#
#  Created by Dr Nic on 14/06/08.
#  Copyright (c) 2008 Dr Nic Academy Pty Ltd. All rights reserved.
#

require 'osx/cocoa'

class Controller < OSX::NSObject
  include OSX
  kvc_accessor :path, :icons, :selectedIndexes
  
  ib_outlets :collectionView
  
  def init
    if super_init
      path = icons = selectedIndexes = nil
      self
    end
  end
  
  def awakeFromNib
    self.path = NSURL.fileURLWithPath(NSHomeDirectory())
    self.setIconsForPath
  end
  
  ib_action :doChangePath do |pathControl|
    # NSParameterAssert(pathControl.isKindOfClass(NSPathControl))
    self.path = pathControl.clickedPathComponentCell.URL
    self.setIconsForPath
  end
  
  ib_action :doubleClick do |sender|
    NSLog("doubleClick: #{self.selectedIndexes.inspect}")
    return if self.selectedIndexes.count > 1
    
    # cycle through the icon dictionaries, finding the correct path
    self.icons.each_with_index do |icon, i|
      if selectedIndexes.containsIndex i
        pathAsString = self.icons[i]["path"]
        NSLog(pathAsString)
        self.path = NSURL.fileURLWithPath(pathAsString)
        self.setIconsForPath
      end
    end
  end
  
  ib_action :setIconSize do |iconSize|
    size = iconSize.floatValue
    @collectionView.setSubviewSize size
  end
  
  def pathAsString
    self.path.path
  end
  
  def setIconsForPath
    error = nil
    path = pathAsString
    files = NSFileManager.defaultManager.contentsOfDirectoryAtPath_error(path, error)
    if error
      NSLog("Error #{error} for path #{path}")
      return
    end
    
    self.icons = files.inject(NSMutableArray.array) do |mem, file|
      unless file.hasPrefix(".")
        filepath = path.stringByAppendingPathComponent file
        mem << NSDictionary.dictionaryWithObjectsAndKeys(
          NSWorkspace.sharedWorkspace.iconForFile(filepath), "image",
          filepath, "path",
          file, "filename",
          nil
        )
      end
      mem
    end
  end
end
