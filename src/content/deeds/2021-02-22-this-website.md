---
author: "Chris"
desc: "This website"
keywords: "hakyll, haskell, web, nix"
lang: "en"
stylesheet: "layout"
title: "This website"
updated: "2021-02-23T12:00:00Z"
---
I'm not going to hold this website up as any kind of paradigm of anything, but it was an interesting project for me, being an intersection of four areas I (to some meaningful extent) lack knowledge or experience in:
- basic web design: eg html, css
- web servers: nginx is being used on the VPS
- haskell - the framework here is hakyll, after trying a few alternatives.
- deploying Nix remotely on a VPS
... not to mention the visual design element of creating a website.

I wanted to create a site that:
- is fundamentally about the written word - I realize that different people absorb information in different ways, but I am myself at heart a reader, and text is the original raison d'etre of the internet
- loads fast, keeps things simple (is text, links, fields and buttons), works on most devices
- is not distractingly ugly but aims for no higher

I'll briefly review the process and technologies at work here in case this is of use to anyone else.

**Hakyll**
I looked at a few website creation frameworks - IHP, Yesod, Obelisk, and this. IHP was very easy to get up and running, and used Nix, so that was great. It seemed well-designed and had some momentum. I liked it a lot, but it used a database on the back-end for maintaining posts and comments, and in the spirit of the principle of least power, I just wanted to crank out posts as markdown files in Vim. IHP is an opinionated framework - an approach I perfectly respect - and using Markdown files wasn't in it's current remit. It seemed viable to hack it to be so, but this seemed to go against the spirit of the project, so I moved away from it. The other frameworks I tried seemed to require you to have more background knowledge in web design than I possessed at the time - ie, any at all.

Hakyll seemed about right - it was simple, designed for static sites, easy to understand and fiddle around with. Getting Hakyll working with Nix was not trivial - even given that somebody has generously created a template specifically for this exact purpose - https://github.com/rpearce/hakyll-nix-template - but this turned out to be largely because I was underestimating how much memory the Haskell compiler requires (a lot - like about 10GB), and had no swapfile.

**HTML, CSS** 
My last foray into this area having been some time ago, I was pleasantly surprised by how easy this bit was. CSS seems to have had some updates - it now has a handy thing called a 'flexbox', who knew - and although these old-school technologies are a little verbose to use, I certainly did not feel obliged to bring in another package like tailwind.

**Nginx**
This is actually the first time I have used this. It exists as a pre-defined service on Nix, and was very easy to get up and running.

**Nix**
I think this is the first time that I have seen Nix go from an interesting yet time-draining curiosity with great potential, to a useful tool. I followed some excellent instructions here:
https://justinas.org/nixos-in-the-cloud-step-by-step-part-1
to deploy Nix and my site to a digitalocean droplet, and it could not have gone more smoothly. The reproducability of this is very appealing - if for whatever reason I had to set up a new VPS instance, it would be fast and straightforward to re-create the existing set-up.

The overall time invested in this was probably in the region of 12 hours, and would have been less if I had spent less time fretting and agonizing over technology choices (as is my usual wont), or if I had had a more complete understanding of the basics of web frameworks/servers.
