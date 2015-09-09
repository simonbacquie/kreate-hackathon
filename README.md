# kreate-hackathon

Over a year ago, my coworkers and I were presented with a graph traversal puzzle. To solve it, you have to find every possible path through the graph, where each edge of the graph has been crossed. Some of the graphs get more interesting, where there are edges that must be crossed twice, or edges that can only be crossed in one direction.

I came up with a fairly decent solution in PHP, but it couldn't handle the larger graphs. Even when reserving 2GB of RAM for PHP to run it with, PHP would run out of memory.

I've been at this for a long time. Today, I have a Ruby solution that's able to solve all 15 graphs on my 2012 dual-core machine in about half a second or less.

The best part is, I didn't even have to mess with any concurrency, threads, crazy functional languages--NONE of that. This solution is in object-oriented Ruby, using iteration, and logic I gleaned from hours of research on graph theory, from Wolfram Alpha and tons of random university professors' course websites.

To run it:

    ruby main.rb <problem_number>

Example:

    ruby main.rb 5

There are a total of 15 problems. You can see the original graphs under the `images/` folder, which are photographs from a whiteboard at my previous employer's office, plus my own vertex mapping stuff laid on top. The actual data structures representing the graphs can be seen under the `/json` folder.
