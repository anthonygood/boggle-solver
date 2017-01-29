require "boggle-solver/letter_picker"

describe Boggle::LetterPicker do
  it "picks letters" do
    expect(described_class.pick_letters(9).class).to be String
  end

  it "picks as many letters as you ask" do
    expect(Boggle::LetterPicker.pick_letters(9).length).to eq 9
  end
end