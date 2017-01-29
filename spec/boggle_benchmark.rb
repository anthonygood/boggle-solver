require "benchmark"
require_relative "../lib/boggle-solver"

describe Boggle::Solver do

  Benchmark.bm do |x|
    puts "3x3:\n==="
    puts "[C][A][T]\n[E][T][S]\n[R][E][L]"

    x.report { @bg = described_class.solve("CATETSREL") }
    puts @bg.found_words.count

    puts "4x4:\n==="
    puts "[V][C][A][T]\n[S][E][N][Y]\n[T][I][L][A]\n[A][I][R][T]"

    x.report { @bg = described_class.solve("VCATSENYTILAAIRT") }
    puts @bg.found_words.count

    puts "5x5:\n==="
    puts "[P][L][A][T][C]\n[H][A][E][R][D]\n[E][R][T][A][C]\n[K][A][I][J][M]\n[N][N][O][P][L]"

    x.report { @bg = described_class.solve("PLATCHAERDERTACKAIJMNNOPL") }
    puts @bg.found_words.count
  end
end
