---
layout: post
---

# BFS

Longer version - following [Wikipedia](https://en.wikipedia.org/wiki/Breadth-first_search):

```py
def search(neighbors, start, do):
    q = []
    q.append(start)
    while len(q) > 0:
        a = q.pop()
        do(a)
        a.checked = True
        for b in neighbors(a):
            if not b.checked:
                q.append(b)
```

Shorter version with generator - following Erez' advice:

```py
def bfs(start, neighbors):
    queue = [start]
    visited = {start}

    while queue:
        node = queue.pop(0)
        yield node
        for neighbor in neighbors(node):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
```
And another version, supporting priorities and rebuilding path leading to every reached node:

```py
from Queue import PriorityQueue
from itertools import count

def bfs(start, neighbors, priority=None):
    if priority is None:
        counter = count()
        priority = lambda node: next(counter)

    visited = {start}
    queue = PriorityQueue()
    queue.put((priority(start), start, None))

    while not queue.empty():
        _, node, prev = queue.get()
        yield node, prev

        for neighbor in neighbors(node):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.put((priority(neighbor), neighbor, node))
```

# Smali

Various attributes in method declaration. Enter folder with many smali files and run (`awk` is used to discard actual method names):

```sh
find -type f | xargs grep -h '^\.method ' | \
awk '{$NF=""}1' | sort -u
```

# Virtual memory

Peak virtual memory in MB:

```py
def get():
    # http://stackoverflow.com/a/938800/404099
    # VmPeak: 10000 kB
    scale = {'kb': 1. / 1024, 'mb': 1}
    with open('/proc/self/status') as f:
        status = f.readlines()
        vmpeak = next(s for s in status if s.startswith("VmPeak:"))
        , size, unit = vmpeak.split()
        return int(int(size) * scale[unit.lower()]) 

def limit(limit_mb=None):
    _, hard_limit = resource.getrlimit(resource.RLIMIT_AS)

    if limit_mb:
        limit_bytes = limit_mb * 1024* 1024
    else:
        limit_bytes = hard_limit

    resource.setrlimit(resource.RLIMIT_AS, (limit_bytes, hard_limit))
```
