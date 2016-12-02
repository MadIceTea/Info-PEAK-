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
# $Id: error_tests.rb,v 1.4 2012/09/07 04:31:46 masuhara Exp $
#-------------------------------------------------------------------------------

# test cases with illigal data

module TestCases
  
  module_function

  @exception_table = {}
  
  # A string, instead of an image array.
  def test_with_string1; show("Hello!") end
  @exception_table[:test_with_string1]=RuntimeError
  # An array of string.
  def test_with_string2; show(["Hello"]) end
  @exception_table[:test_with_string2]=RuntimeError
  # An array of array of string.
  def test_with_string3; show([["Hello"]]) end
  @exception_table[:test_with_string3]=RuntimeError
  # An array of array of an integer and a string.
  def test_with_string4; show([[0,"Hello"]]) end
  @exception_table[:test_with_string4] = TypeError
  # An array of array of an integer and a string.
  def test_with_string5; show([[0],["Hello"]]) end
  @exception_table[:test_with_string5] = TypeError
  # An array of array of an integer and a string.
  def test_with_string6; show([[[0,0,0],[0,0,"Hello"]]]) end
  @exception_table[:test_with_string6] = TypeError
  
  # One dimensional array.
  def test_with_1D_array; show([0]) end
  @exception_table[:test_with_1D_array]=RuntimeError
  
  # Elements out of the [0,1] range.
  def test_with_element_LT_0; show([[-1]]) end
  def test_with_element_GT_1; show([[1.1]]) end
  def test_with_element_LT_1_color; show([[[0,0,-1.1]]]) end
  def test_with_element_GT_1_color; show([[[0,0,1.1]]]) end

  # An array of Bignum.
  def test_with_bignum; show([[10**40]]) end
  
  # An irregular array.
  # The second row is shorter than the first row.
  def test_with_irregular_array2D1; show([[0.1,0.9], [0.5]]) end
  # The first row is shorter than the second row.
  def test_with_irregular_array2D2; show([[0.5], [0.1,0.9]]) end
  # The second row is shorter than the first row.
  def test_with_irregular_array3D1; show([[[0,0,0],[1,1,1]],
                                          [[0,0,0]]]) end
  # The first row is shorter than the second row.
  def test_with_irregular_array3D2; show([[[0,0,0]],
                                          [[0,0,0],[1,1,1]]]) end

  # The first element has only two numbers.
  def test_with_irregular_array3D3; show([[[0,1]]]) end
  # The first element has more than 3 numbers.
  def test_with_irregular_array3D4; show([[[0,1,0.5,0.7]]]) end

  # Updating an element with a string
  def test_update_with_string;
    a=[[1,0,1],[0,1,0]]
    show(a)
    a[1][2]="hello"
  end
  @exception_table[:test_update_with_string] = TypeError

  # Updating an element with a number less than zero
  def test_update_with_LTZ;
    a=[[1,0,1],[0,1,0]]
    show(a)
    a[1][2]=-3
  end

  # Updating an element with a number more than one
  def test_update_with_GT1;
    a=[[1,0,1],[0,1,0]]
    show(a)
    a[1][2]=1.1
  end

  # Updating an element at the position outside of the image
  def test_update_out_of_range1;
    a=[[1,0,1],[0,1,0]]
    show(a)
    a[0][3]=0.5
  end
  @exception_table[:test_update_out_of_range1] = NoMethodError

  # Updating an element at the position outside of the image
  def test_update_out_of_range2;
    a=[[1,0,1],[0,1,0]]
    show(a)
    a[2][0]=0.5
  end
  @exception_table[:test_update_out_of_range2] = NoMethodError
  
  # Updating an element with a string in a color image
  def test_update_with_string3D;
    a=[[[1,0,1],[0,1,0]]]
    show(a)
    a[0][1][2]="hello"
  end
  @exception_table[:test_update_with_string3D] = TypeError

  # Updating an element with a nil object in a color image
  def test_update_with_object3D2;
    a=[[[1,0,1],[0,1,0]]]
    show(a)
    a[0][1]=nil
  end
  @exception_table[:test_update_with_string3D2] = TypeError

  # Updating an element with a two numebrs array in a color image
  def test_update_with_rg;
    a=[[[1,0,1],[0,1,0]]]
    show(a)
    a[0][1]=[1,1]
  end

  def test_update_with_int_and_string;
    a=[[[1,0,1],[0,1,0]]]
    show(a)
    a[0][1]=[1,1,"hello"]
  end


  def expected_error(method_name)
    @exception_table[method_name.intern]
  end

end

include(TestCases)

def run_tests
  TestCases.methods.select{ |m| m =~ /^test_with_/ }.each do |m|
    puts("=#{m}" + "="*10)
    method = TestCases.method(m)
    begin
      method.call()
    rescue => e
      case e
      when TestCases.expected_error(m)
        # do nothing
      else
        puts e.class
        puts e
        puts(e.backtrace.join("\n"))
      end
    end
    
  end
end
