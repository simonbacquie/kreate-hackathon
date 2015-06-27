# kreate-hackathon

Over a year ago, my coworkers and I were presented with a graph traversal puzzle. I came up with a fairly decent solution in PHP, but it couldn't handle the larger graphs. Even when reserving 2GB of RAM for PHP to run it with, PHP would run out of memory.

I've been at this for a long time. Today, I have a Ruby solution that's able to solve all 15 graphs on my 2012 dual-core machine in about half a second or less.

The best part is, I didn't even have to mess with any concurrency, threads, crazy functional languages--NONE of that. This solution is in object-oriented Ruby, using iteration, and hours of research on graph theory from Wolfram Alpha and tons of random university professors' course websites.

To run it:

    bundle install
    bundle exec ruby main.rb <problem_number>

Example:

    bundle exec ruby main.rb 5

There are a total of 15 problems. You can see the original graphs under the images/ folder, which are photographs from a whiteboard at my previous employer's office, plus my own vertex mapping stuff laid on top.
