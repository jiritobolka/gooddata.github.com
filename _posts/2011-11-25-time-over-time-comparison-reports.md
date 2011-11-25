---
title: Time over Time Comparison
excerpt: Blogpost describes how to create metrics for time over time comparison
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Hi everybody! No matter if you work on a killer Analytics App, or just started using GoodData, you’ll always want to learn something new. I hope I’ve got something for you. Today I would like to teach you how to use transformations in metrics. 

First, let me introduce the problem. Imagine you are a data analyst and you would like to create a time over time comparison report for your Sales Director to have a better overview of the company's sales data from your SalesForce CRM. Got it? Let's do it!

## Time over Time Comparison reports

What will you need? You'll definitely need some good data, and some knowledge on how to create these type of metrics with MAQL (our query language). Starting with one of the simplest metrics in Sales Analytics - `Amount[SUM]`. This metric is predefined by default in our Sales Analytics App and gives you a total amount of all opportunities for the last snapshot. Remember that in Sales Analytics, you need to specify the snapshot. Not sure what snapshots are about? [Read this article](http://developer.gooddata.com/blog/2011/07/29/Analyzing-Change/) first to be sure how to use it! 

Now, let's tune it up to see a time over time comparison! See the metrics below:

`SELECT Amount[SUM] FOR Previous(Quarter/Year(Closed))`

`SELECT Amount[SUM] FOR PreviousPeriod(Quarter/Year(Closed))`

The first metric computes a number for a previous specific period of time. If you use this metric side by side with the basic `Amount[SUM]` and slice them by Quarter/Year and Month/Year. The metric is used in the report shown below.

The second metric is different from the first one. The `FOR PreviousPeriod()` is used there. What is the difference between the FOR Previous and FOR PreviousPeriod statement? The FOR Previous is connected to the date dimension and gives you the aggregation based on previous time period from the date dimension. In our example, it gives you the same month but from the previous quarter. The FOR PreviousPeriod gives you a previous value based on records in report. See the examples in a report and tables below.

<p>
<center><img src="{{ site.root }}/images/posts/ForPreviousQuarter-report.png" alt="For Previous Quarter Report"></center>
</p>

Got it? Do you see the difference? The report above and metrics with Previous statements are based on Quarter level. In the tables below, you can see more examples to understand it clearly:

<p>
<center><img src="{{ site.root }}/images/posts/PreviousMonth.png" alt="For Previous Month"></center>
</p>

<p>
<center><img src="{{ site.root }}/images/posts/PreviousQuarter.png" alt="For Previous Quarter"></center>
</p>

<p>
<center><img src="{{ site.root }}/images/posts/PreviousYear.png" alt="For Previous Year"></center>
</p>

Anyway, what you can also use is a second parameter inside both statements. It's a number that tells the engine to skip the given number of the period. Again, for better understanding, see the example below:

`SELECT Amount[SUM] FOR PreviousPeriod(Quarter/Year(Closed),2)`

As you can see, with additional parameter added to the metric specification, it skips two Quarters and gives you the corresponding number.

Alternatively, it is also possible to compare against future dates using two other special MAQL functions: FOR Next() and FOR NextPeriod(). Both of these constructs function in the same was as FOR Previous() and FOR PreviousPeriod() above.

## Year to Date Reports

Another use that I would like to show you is Year to Date Reports and metrics. Using this special construct, you can create a metric with “This” as a day or “Yesterday”. For better understanding, let's see a simple example

`SELECT Amount [SUM] WHERE Quarter/Year(Closed) = {This}`

The metric above gives you Amount of all opportunities that were closed this Quarter. You can also use `{This} - 1` that is the same as `{Previous}` statement. Not enough? Let's combine it

`SELECT Amount [SUM] WHERE Quarter/Year(Closed) = {Previous} AND Day of Quarter = {This}`

In this example, `{Previous}` would mean "Previous (Last) Quarter" and `{This}` would refer to "Today as a numeric Day of the Quarter" (i.e., Day 62 of the quarter).

So, let your imagination work! Use transformation, be creative and...data driven ;) See you next time!