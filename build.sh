#!/usr/bin/env bash

nix-build
cd generator && hakyll-site clean && hakyll-site build
ssh-add /data/ssh/digitalocean
scp -r /data/vap/hakyll-blog/result/* root@206.189.150.146:/var/www/justnothing.com

