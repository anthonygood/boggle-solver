## Boggle Solver

A library for generating and solving boggle grids.

Pick some letters and solve a grid:
```rb
letters = Boggle::LetterPicker.pick_letters 16
Boggle::Solver.words_in letters
```
