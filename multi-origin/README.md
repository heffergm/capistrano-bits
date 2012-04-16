# Capistrano: change remote origin to allow deployment from different repositories
* credit to https://github.com/outoftime for the idea, i just wrapped it in a handy command line line switch

## Rationale
* when Github was having a variety of issues we decided it would be a good idea to set up an internal repo to deploy from
* with this setup, and a post-receive mirror hook in whichever we decide to push to, you can easily deploy from the location or your choice with a simple command line ENV var: ```REPO=local```, which in this case means don't deploy from github, which is otherwise set as the default.

