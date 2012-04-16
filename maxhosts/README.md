# Maxhosts

## Rationale
* if you deploy to large number of hosts, whether you use github or an internal repo, you may find you want/need to throttle the number of concurrent hosts running :update_code at the same time
* to do so, you can set a default (20 in the example) or set your preference via env var: MAXHOSTS (e.g. MAXHOSTS=100)

