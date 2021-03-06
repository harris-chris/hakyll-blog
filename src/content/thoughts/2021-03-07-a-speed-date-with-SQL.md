---
author: "Chris"
desc: "A speed date with SQL"
keywords: "SQL, data"
lang: "en"
stylesheet: "layout"
title: "A speed date with SQL"
updated: "2021-03-09"
---
I recently did a five-month "data engineering" course provided by Udacity, which brought me into close orbit with SQL, a technology that I had obviously been aware of but not used to any great extent before. Since this post contains more criticism than praise, let me first say that I speak as somebody who has not yet had their ideas re-forged much in the smithy of practical reality. There are many things in life whose merits are not obvious at first glance. I am happy to be corrected or contradicted, and I'm sure at least part of what I have written below is wrong for reasons I do not yet understand. Here I'm speaking here purely about SQL as a language/concept, rather than at the earthier level of implementation.

**Works in theory**
I generally like technologies with some academic backing, which SQL has. Its aims can be expressed in a few quite comprehensible axioms about normalisation of the data and eliminating duplication. This, to me, is very appealing - it sets out its stall about what it aims to do. This means you can quickly assess it versus peer technologies, it means you can decide whether it suits your way of thinking or not, and it gives you some principles to follow when you're structuring your data.

**Dimensions capped at 2**
I think the first thing that surprised me was that it handles two-dimensional data only. Both in the database itself and at the point of input/output, everything must be representable as a table. This is probably not a huge limitation for storing business data - which I believe is its original use case - but it is at the very least a significant limitation for mathematical (and, consequently, finance) use, where n-dimensional arrays are entirely normal. Dimensions beyond two can obviously be hacked but this is not ideal.

**Not a natural fit for hierarchical data**
Another thing which makes SQL an imperfect match for financial data is that it has no native concept of hierarchies. It cannot express the idea that an object holds an uncertain number of other objects - eg that object A holds objects AA, AB and AC, and that, say, object AB in turn holds ABA and ABB. As with three-dimensional data, this kind of hierarchy can, ultimately, be re-created using SQL's structure of tables and foreign key relationships, but it is an unnatural fit and consequently hard to reason about. A JSON, though not without deficiencies of its own, is a good way to store hierchical data.

**Type system a bit peculiar**
The type system felt like it might have been tacked on to over time, and didn't seem to adhere to modern naming definitions (there is, oddly, a type which calls itself 'decimal', despite most or maybe all the numeric types being base 10). Modern languages are pretty unambiguous on this and tend to just say float64, int32, etcetera, which is clearer.

**Is it also an analysis tool?**
SQL seemed slightly unable to decide whether it wanted to limit itself to data storage/retrieval, or to stray over into analysis. It does not just bring you back the data you ask for - it also provides a limited set of operations on that data, like sum or average. I believe in the Unix principle of modularity - that a technology should do just one thing, and then hand off periperal tasks to other specialized packages. SQL's tendency to offer data analysis as well as retrieval, though on some level understandable and probably quite practical, irked me slightly. Possibly the SQL folk would justify it by saying that these operations reduce down the data to be retrieved prior to analysis, and so improve performance. For any serious analysis, you will require a (separate) analysis tool anyhow.

**Optimization more art than science**
It seems frustrating that it is necessary to move away from the academically pure landscape of a fully normalized database in order to improve performance (or even to make performance acceptable, in many cases). It also seems surprising that a human is the one who chooses these de-normalizations, which seem to be more art than science. Ideally the human view of the database would always be a fully normalized one, and optimizations could then be made behind-the-scenes via some kind of optimization process. I realize the same is true for many NoSQL databases, and I'm sure that the process of optimization to some extent requires an understanding of the use case, which only a human can really have.

These are mostly criticisms, but for a 1970s technology, I think SQL has aged remarkably well, and has an admirable concision and tidiness to it. 
