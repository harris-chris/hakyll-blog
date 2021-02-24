---
author: "Chris"
desc: "Flirtations with typed and untyped languages"
keywords: "typing, scala, python"
lang: "en"
stylesheet: "layout"
title: "Flirtations with typed and untyped languages"
updated: "2021-02-22T12:00:00Z"
---
One thing which I cannot stop thinking about - and, to the regret of both myself and those around me, talking about - is type systems. Colleagues have, I think, learned to avoid going even remotely near this topic, for fear of provoking unnecessarily-aggressively-worded opinions from me on this matter.

One distinction I think I should get out the way early is that within typed languages, there is the good and the bad, the new and the old. Java and C have type systems, but these were originally created to help the compiler, not the programmer. You are serving the type system, not vice-versa. I know of two mainstream languages that I think have genuinely good type systems as integral parts of the language - Scala and Haskell - and a number that have type systems that have been well-thought through but suffer somewhat from having been retrofitted (eg, Python and Typescript). 

A properly integarted type system is a tremendous boon to the software engineer (or the library user), particularly with an IDE using the appropriate LSP. If you have not had this pleasure of coding in this way, it feels like a more experienced, more intelligent coder is sitting next to you, gently pointing out your mistakes as you make them. The vast majority of your errors are revealed before you even compile, let alone before you unit test. By contrast, (say) Python is much more demanding of attention, and punishes typos:

```
securities = 10
securitles = securities + 1
assert(securities == 11)
```
A typed langauge is not simply a dynamic language plus a type system (this is the approach that Python has tried to take, and it has its shortcomings). There are some syntatic constructs which only really work with typed languages. Proper pattern matching is an obvious example, which is a core feature of the typed functional languages, and a pleasure to use. So are typeclasses.

My early forays into coding were done as an adjunct to my finance job and were exclusively in Jupyter notebook, using Python, as loosely-typed a language as one could hope to find. Having not programmed since the hard days of the late 90s, I was borderline euphoric about how easy it was to crank out working code. In Jupyter, you are constantly seeing the output of your work, and mistakes reveal themselves quickly, so Python's loosey-goosey dynamic nature was not a huge obstacle, although it led to some embarassing mistakes from time to time. 

Then I tried to write a library in Python. As it grew, dynamic typing increasingly became a liability. Refactoring was hard and dangerous. If you had to adjust your function signatures, you had to be very careful to check that you refactored every single location that those functions were used. If you failed to do this but were lucky, the code would not work. If you were unlucky, it would work but give erroneous output. 

After a while I discovered the typing module and mypy, and embraced those. But Python's type system was (I think still is) imperfect. I wanted to use what I now know to be traits to have it all cohere, but these were quite clumsy - I think they fell somewhere between an abstract base class and a protocol. I relied more and more on unit tests to give me reassurance. Maintaining, writing and running these used up a lot of my time.

Later on I discovered Scala, as strictly-typed a language as one could hope to find. Again I was borderline euphoric about how easy it was to catch errors and refactor. It might seem like there is some overhead to maintaining the type system, but this apparent overhead is mostly because the type system is forcing you to answer hard questions about your design that you should be able to answer anyway. In a dynamic language, you can store up trouble for yourself by just sweeping these questions under the carpet. 

Later on I tried to write an array typeclass in Scala. Typing arrays is, I now realize, an infamously hard problem. I certainly found it hard at first. To support the idea that arrays could be `n`-dimensional, but also that the top-level element of an `n`-dimensioned array is an `n-1`-dimensioned array, you have to use some form of dependent typing, an experimental language feature that most type systems won't support at all. At some point I realized that 90% of my time was spent trying to make the type system work, and about 10% trying to actually code. I didn't mind this too much - the whole project was something of an intellectual exercise, and it was mind-bending fun even to try - but it felt like I was out on a limb that was both thin and obscure. 

Having witnessed these two extremes, overall I have to come down, probably quite hard, on the side of static typing. I don't believe that the type system is making me do extra work. I think of it as though the type system is a framework for thought, for sketching out processes and concepts. In Scala, you can sketch out the entire design of a program just by writing all the traits, with their method signatures, as code, with 'holes' for the implementation. It will type-check, and it serves as an excellent way of prototyping an architecture before even beginning to write it. As IDEs improve, this should be a tailwind for static typing (an IDE can infer much less about what is going on in a dynamic language, and therefore help you much less). The one thing that I think challenges this position is the increasing popularity of notebooks like Jupyter. But more on that in another post.

