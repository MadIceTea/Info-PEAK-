#-------------------------------------------------------------------------------
# Copyright (c) 2012 Hidehiko Masuhara.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the GNU Public License v3.0
# which accompanies this distribution, and is available at
# http://www.gnu.org/licenses/gpl.html
# 
# Contributors:
#     Hidehiko Masuhara - initial API and implementation
#
# $Id: isrb.rb,v 1.10 2012/10/01 09:21:39 masuhara Exp $
#-------------------------------------------------------------------------------

# to confirm if we are on JRuby
# http://stackoverflow.com/questions/1342535/how-can-i-tell-if-im-running-from-jruby-vs-ruby
if !(defined? RUBY_ENGINE && RUBY_ENGINE == "jruby")
  STDERR.puts "isrb2: run on top of JRuby."
  exit 1
end

require 'java'

ISRB_VERSION = '$Name: release_20121001 $'

module Isrb
  module_function               # let the following method definitions
                                # be defined as module's instance
                                # methods.

  def setup()
    p = ENV["ISRB_HOME"]
    err=nil
    if !(p && (File.exists?(q=File.expand_path("isrb.jar",p)) ||
    		   File.exists?(q=File.expand_path("bin",p))) &&
         begin
           $CLASSPATH << q
           import 'jp.ac.utokyo.c.graco.isrb.ImagePanel'
           true
         rescue NameError => e; err=e; false
         end)
      STDERR.puts("isrb: set the environment variable ISRB_HOME (#{p}).")
      if err then STDERR.puts(e.inspect) end
      java.lang.System.exit(1)
    end
    IRB.conf[:IRB_NAME] = "isrb"
    at_exit do
      ImagePanel.atExit()
    end
  end

  def show(array)
    if array.kind_of?(Array) && array.all?{|e| e.kind_of?(Numeric)}
      wrapper = [array]
      showGray(wrapper) 
      dummy = wrapper[0]        # install hooks
      array
    elsif array.kind_of?(Array) && array[0].kind_of?(Array) &&
        array[0][0].kind_of?(Numeric)
      showGray(array)           # 2D gray-scale
      array
    elsif array.kind_of?(Array) && array[0].kind_of?(Array) &&
        array[0][0].kind_of?(Array) && array[0][0][0].kind_of?(Numeric)
      showColor(array)          # 2D color
      array
    else
      raise "expected a 2- or 3-dimensional array, but got a #{array.class}"
    end
  end

  # to close all windows
  def close_all()
    ImagePanel.closeAll()
  end

  # to show a two dimensional array as a gray-scale image
  def showGray(array)
    get_frame_for(array).showGray(array.to_java(Java::double[]))
    hook(array)
  end

  # to show a three dimensional array as a full-color image
  def showColor(array)
    get_frame_for(array).showColor(array.to_java(Java::double[][])) 
    hook3d(array)               
  end

  # to obtain (or construct if absence) an ImagePanel object in Java
  # associated to the given array.
  def get_frame_for(array)
    if !(f = (array.instance_variable_get(:@isrb_frame)))
      f = ImagePanel.createFrame()
      array.instance_variable_set(:@isrb_frame, f)
    end
    f.enclosingFrame().setVisible(true)
    f
  end

  # to change the []= method of the given array so that it will notify
  # the frame whenever its element changes
  # TODO: boundary check
  def hook(array)
    def array.[](index)
      if ! @hooked
        self.each_with_index do |row, y|
          row.instance_variable_set(:@isrb_row, y)
          row.instance_variable_set(:@isrb_frame, @isrb_frame)
          def row.[]=(x, newValue)
            r = super
            @isrb_frame.updatePixel(x, @isrb_row, newValue,newValue,newValue)
            r
          end
        end
        @hooked = true
      end
      super
    end
  end


  def hook3d(array)
    def array.[](index)
      if ! @hooked
        self.each_with_index do |row, y|
          row.instance_variable_set(:@isrb_row, y)
          row.instance_variable_set(:@isrb_frame, @isrb_frame)
          def row.[]=(x, newValue) # newValue : double[3]
            r = super
            @isrb_frame.updatePixel(x, @isrb_row,
                                    newValue[0],newValue[1],newValue[2])
            r
          end# row.[]=
          row.each_with_index do |rgb, x|
            rgb.instance_variable_set(:@isrb_col, x)
            rgb.instance_variable_set(:@isrb_row, y)
            rgb.instance_variable_set(:@isrb_frame, @isrb_frame)
            def rgb.[]=(index, newValue)
              r = super
              @isrb_frame.updatePixel(@isrb_col, @isrb_row,
                                      self[0],self[1],self[2])
              r
            end# rgb.[]=
          end# row.each_with_index
        end# self.each_with_index
        @hooked = true
      end# if
      super
    end# def array.[]
  end# def hook3d
end

#a delegate at the top-level
def show(*args)
  Isrb.show(*args)
end

Isrb.setup()
