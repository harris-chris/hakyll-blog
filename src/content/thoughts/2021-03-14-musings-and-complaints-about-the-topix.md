---
author: "Chris"
desc: "Musings and complaints about the TOPIX"
keywords: "SQL, data"
lang: "en"
stylesheet: "layout"
title: "Musings and complaints about the TOPIX"
updated: "2021-03-14"
---
... so I would advise you, Sir, to study algebra, if you are not an adept already in it: your head would get less *muddy*

Samuel Johnson, quoted by Boswell

I have been dealing with some Japanese stock market data these past couple of weeks. The most commonly-used Japanese stock index is the TOPIX, comprised of the shares of about 2000 companies and published by the Tokyo Stock Exchange. Like other equity indices (in the finance industry, we tend to refer to shares, or what the layperson might call 'stocks', as 'equities'; originally 'stocks and shares' meant 'bonds and equities'), the companies within the TOPIX index are categorized along various lines, including their major business activity - say 'Banks', 'Forestry', etcetera. 

The Topix has a few such breadkowns, but the main one is the so-called 'TOPIX Sector indices', with thirty-three sector categories with names such as 'Fishery', 'Agriculture and Forestry', 'Mining', etcetera. They are, inevitably, a bit of a mix of primary (B2B) and seconary (B2C) industries. In my eyes, this list of sectors, as well as the general premise in play, actually serve as something of a what-not-to-do when designing a categorization system.

The most striking thing when looking through the sectors is how outdated they now appear. For example, three of the thirty-three sectors are given over to moving goods around:
*Marine Transportation*; *Air Transportation*; *Warehousing & Harbor Transportation Services*
whereas the whole of the IT Sector, plus some more - which tends to be around 25 - 30% of the US stock market, apparently resides in the innocuous-sounding *Information & Communication* sector. Bear in mind that these sectors would have been originally designed to contain a roughly equal share of the total market. Effectively, this is a snapshot of what some economist-bureaucrat thought an economy should look like, back when the categories were created (if I recall correctly, 1977). There is a significant failure of imagination here - was it really impossible to imagine that *Pulp & Paper* or *Rubber Products* would not always be a major chunk of the Japanese economy? That goods-producing sectors might not always dominate services sectors?

If we look at other sector classification systems, for example the MSCI, which usually impresses me with its logical design - we see that, although it is impossible to design an entirely future-proofed classification system, efforts have been made to keep things a little more conceptual, and to stick to sectors that should, until we all upload ourselves into cyberspace, have some on-going presence in our lives: *Energy*, *Consumer Discretionary*, *Health Care*, *Real Estate*.

There learning point which puts itself forward here is that a sector breakdown should have some kind of a timestamp, and be some kind of a time series - that, even if Topix could not have picked a more future-proofed list of sectors, they could at least have future-proofed themselves by acknowledging that this is their perception of which sectors should be represented *right now*, and that it might therefore change in future. But presumably my imaginary economist-bureaucrat did not implement such a system for the same reason that he created such a rigid set of sectors: he was unable to conceive of an economy significantly different from the one he was seeing from his window at the time.

The greater problem here, though, is that the people who manage the stock exchange are the same people who publish the stock index (in both cases, the Tokyo Stock Exchange). This is an unneccessary coupling (it doesn't really even have any obvious synergies) and serves to make the exchange/TOPIX/TOPIX categories an inseparable monolith that is now frozen in place. Other economic areas have these two functions being fulfilled by different parties - eg, the New York Stock Exchange are not the same people who publish the Dow Jones or the S&P 500, who are in fact not the same people who publish the aformentioned MSCI indices. Hence there is a competitive free market in index providers, making it much more likely that the sectors are going to get updated and we're not going to be stuck with the 'Pulp and Paper' sector for all time.

I'm sure a category theorist would also suggest that these sectors be applied as tags to the companies - meaning that a single company could belong to multiple sectors, rather than being pigeonholed into a single one - but that would mean that the total sector allocation would then be greater than 100%, and that may not suit the TSE's purposes, so I'm prepared to let them off that charge.
