---
title: Measuring report execution time
excerpt: Example of how it is possible to measure the report execution time 
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob)) & Tomas Svarovsky([@fluke77](http://www.svarovsky-tomas.com))_

Hello everybody, 

Today, I have something a little bit different for you. You've probably already heard about our GoodData Ruby tool which is already available. The Ruby tool is still in development and doesn't support all of the CL Tool features. Anyway, there are still some interesting use cases that you can do with it, especially, if you like to play around with Ruby.

What can be done with the Ruby Tool? You can create new projects, add users, execute reports etc. If you are interested, the GoodData Ruby tool is available on GitHub, so you can fork your repository and collaborate on development.

Let's go back to today's example. Several weeks ago, we needed to check the execution time of all reports in our Project and we decided to use the Ruby tool for this use case. Well, our goal is following: We are going to measure report execution time for a specific project and we’d like to know which reports are being computed longer than, in our example, let's say 5 seconds.

## Using the Ruby Tool

The Ruby tool is available as a Ruby  gem, so if you don't have it installed, do it right now. Use 

{% highlight ruby %}
sudo gem install gooddata
{% endhighlight %}

Now, lets build the script that will do the business. In the beginning of the script, you need to include all gems that will be needed.

{% highlight ruby %}
require 'rubygems'  
require 'gooddata'  
require 'benchmark'  
require 'logger'  
require 'pp'  
{% endhighlight %}

Once we required all necessary gems, we need to initialize the variable where we’ll store the Project ID and then connect to GoodData using your credentials and the Project ID

{% highlight ruby %}
pid = "projectID"  

GoodData::connect 'user@email.com', 'password'  
GoodData::use pid  
{% endhighlight %}

Now, we are connected to the GoodData API and we can use the Ruby Tool functionality. It's time to GET the [list of reports](http://developer.gooddata.com/api/report.html) and then send every report to the GoodData executor and measure the total report execution time using the [Benchmark](http://ruby-doc.org/stdlib-1.9.3/libdoc/benchmark/rdoc/Benchmark.html) module:

{% highlight ruby %}
result = GoodData::get "/gdc/md/#{pid}/query/reports"  
reports = result["query"]["entries"].map {|r| GoodData::Report[r["link"]]}  

long_running_reports = reports.find_all do |report|  
  measurement = Benchmark.realtime do  
    result = report.execute  
 end  
  puts measurement  
  measurement > 5  
end

puts "Reports that took more than 5 secs to compute (#{long_running_reports.count})"  
long_running_reports.each {|r| puts r.title}  
{% endhighlight %}

As a result, you can see a list of reports that took longer than 5 seconds to compute. For sure you don't need to print the names you can do whatever you want and use reports in your application. Do you want to try it? [Download](https://gist.github.com/1565384) the script.

Check the example result:

<p>
<center><img src="{{ site.root }}/images/posts/computedReportsMeasurement.png" alt="Computed Reports Measure"></center>
</p>

Well, do you like it? Do you want to see more examples like this? Let us know and if you like it, share it!