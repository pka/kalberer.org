#!/usr/bin/env just --justfile

serve:
    zola serve

deploy:
    cd ../kalberer-sysadmin && just deploy-web    
