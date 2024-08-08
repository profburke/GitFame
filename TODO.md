### TODO

- `ArgumentParser` thinks the tool name is `git-fetcher` since the struct is named `GitFetcher`.
    - But, of course, the tool name is 'gitfame' and I'm not going to let a software package force me to change the name of my struct. So figure out how to configure `ArgumentParser`.
- On error, it should return a non-zero exit code. Figure out how to get the Darwin/Linux `exit()` -- Xcode keeps insisting on using some other `exit()` function (from `ArgumentParser`, I think :( )
- Run on Linux, Windows, and iOS, watchOS (_don't be silly_) ..., etc.
