# bench.rb
# $Id: bench.rb,v 1.4 2013/11/17 01:58:21 masuhara Exp $

# This file provides methods that plots execution times of functions.
#
# For example, the next loop executes m1(p,v) and m2(p,w) for p=1..N,
# measures execution time of each method invocation, and plots two 
# curves of execution times.
#    for p in 1..N
#      run("m1",p,v)
#      run("m2",p,w)
#    end
#
# The interface of the method run is as follows.
#
# run(<method name>, <key parameter>[, <extra parameters>...])
#
# The method name is a name of a method to be executed.  The key
# parameter is the first argument to the method, as well as the x-axis
# of the graph.  The extra parameters are optional, and passed to the
# method when provided.
#
# The other methods provided are:
#
# reset() -- forgets benchmark results recorded so far.
#
# command(<cmd>) -- passes a <cmd> to Gnuplot.

require("benchmark")
require("tempfile")

# An instance of this class represents a set of benchmark results for
# one method.  
class Dataset

  def initialize(name)
    @name = name
    @file = Tempfile.new("plotdata"+name)
    @last_key = nil
    @table = {}
  end

  def rewrite()
    @file.truncate(0)
    keys=@table.keys().sort()
    for key in keys
      @file.printf("%f %f\n", key, @table[key])
      @last_key = key
    end
    @file.flush()
  end

  def add(key, seconds)
    @table[key]=seconds
    if @last_key == nil || @last_key < key
      @file.printf("%f %f\n", key, seconds)
      @file.flush()
      @last_key = key
    else
      rewrite()
    end
  end

  def close()
    @file.close()
    initialize(@name)
  end

  def pathname()
    @file.path()
  end

  def dump(out)
    keys=@table.keys().sort()
    for key in keys
      out.printf("%f %f\n", key, @table[key])
    end
  end
end

# An instance of the class represents a benchmarking session,
# consisting of a connection to the Gnulpot process, and a set of
# Datasets.
class Record
  attr_accessor :plotter

  def initialize()
    @record = {}
    @names = []
    @plotter = open("|gnuplot", "w")
    @plotter.print("set style data linespoints\n")
    # don't show the initial window when $gnuplot_noinitialize is non-nil.
    if !global_variables.member?("$gnuplot_noinitialize") ||
       !$gnuplot_noinitialize
      @plotter.print("plot sin(x)\n")
    else
      @plotter.print("set term dumb\n")
      @plotter.print("set output '/dev/null'\n")
    end
    @plotter.flush()
  end

  def reset()
    for d in @record.values()
       d.close()
    end
    @record = {}
    @names = []
  end

  def add_dataset(name)
    d = Dataset.new(name)
    @record[name] = d
    @names.push(name)
    send_plot_command()
    d
  end

  def add(name,key,seconds)
    d = @record[name]
    if !d
      d = add_dataset(name)
    end
    d.add(key,seconds)
    send_plot_command()
#    redraw()
  end

  def redraw()
    @plotter.print("replot\n")
  end

  def send_plot_command()
    command="plot "
    for name in @names
      d = @record[name]
      command += sprintf("'-' title '%s',", name)
    end
    command = command[0..(command.length-2)] + "\n"
    @plotter.print(command)
    for name in @names
      d = @record[name]
      d.dump(@plotter)
      @plotter.print("e\n")
    end
  end

  def command(c)
    @plotter.print(c + "\n")
    send_plot_command()
  end

  def parameter_to_string(parameters)
    s=""
    for x in parameters
      s+= x.to_s + ","
    end
    s[0..(s.length-2)]	# remove last comma
  end

  def run(name, key, *parameters)
    if !$record
      $record = Record.new
    end
    printf("%s(%s)...", name, key.to_s)
    procedure=Object.method(name)
    if parameters.size==0
      parameters=[key]
    end
    total = Benchmark.measure{ @result = procedure.call *parameters }.total
    printf("finished in %f seconds.\n", total)

    $record.add(name,key,total)
    v=@result; @result=nil; v
  end
end

$record = Record.new

def run(name,key,*parameters)
  $record.run(name,key,*parameters)
end

def reset()
  $record.reset()
end

def command(c)
  $record.command(c)
end

# version 1.4
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
