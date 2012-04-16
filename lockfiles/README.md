# Lockfiles

## Rationale
* have lots of devs? I'm betting a couple have ended up deploying code to the same env at the same time, which generally results in a bit of a mess
* take care of it by creating a lockfile. It'll get created before deploy, then removed afterwards. Any attemptd to deploy while the lockfile is in place will fail with a message that deploys are locked by $USER.
* you can manually remove the lockfile via deploy:unlock

