# Calculator

This repo is just a submission for an interview tech-challenge; don't expect to
find some amazing application that is going to vastly improve your life in any
meaningful way. :-)

## Implementation Notes

* The challenge requirements specify the use of Rails; I would likely not use
  Rails for something so simple if I had no expectation that the UX complexity
  would grow significantly any time soon.
  
* I originally wanted to just use `Calculator` instead of `Calculator::Simple`
  for the library class that does the actual calculation, but I forgot that
  Rails creates a module name based on whatever you pass in as the app name when
  running `rails new`. I was far enough in when I realized my blunder that it
  would have been a pain to rename things. Mea culpa. If this were going to be
  real production code, I'd fix it.
