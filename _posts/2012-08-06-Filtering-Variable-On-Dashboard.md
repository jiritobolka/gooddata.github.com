---
title: Using Variable to Filter by a Child Table
excerpt: Follow the example to learn the variable metric trick.
layout: post
---

# {{ page.title }}

_by Eric Albanese_

Sometimes you have the situation where you need to filter a handful of metrics from a child table. Below is an example model.

<p>
<center><img src="{{ site.root }}/images/posts/example_model.png" alt="Example Model" width="450"></center>
</p>

For most cases, someone would be looking to sum up donations by a user. After that, they may want to then compare that to how many events someone has attended. Both of these can easily be accomplished by a SUM of Donations.Amount and COUNT of Event.ID. Nothing special here.

But what if someone wants to do a deeper dive into the people that attended a specific event? Basic metrics will let you know how many people came along with any demographic information in the users table. However, what if you want to look at the total amount of donations from people who attended that event? As the tables are not directly linked, it's normally not possible.

<p>
<center><img src="{{ site.root }}/images/posts/see-the-dashboard-filter.png" alt="Dashboard Filter Example" width="600"></center>
</p>

In this situation, each user may have attended several events along with making several donations. Because of the 1:N relationship between Users and Events, it probably didn't make sense to try to change the data model to denormalize the tables.

By using variables and a metric filter, we can create a filter on our dashboard to sort by events. The overall idea is to make a metric that does a count of how many events each user is a part of, then filter on that. If a person attended an event (and with the list now being filtered down to just that item), we'll get a value of 1 which we can now use to filter upon.

The first step is to make a Variable. You can name this whatever you'd like; in this situation I'll name it "Event Filter". Set this as a filtered variable, and select the field in the Event table you'll want to see on the dashboard. Using Event.EventName works here.

Next, you'll need to create a metric that aggregates this. Create a new metric, named "Event Filter Metric", and set it up in this format:

`SELECT COUNT(EVENT.ID) by USER.ID, ALL OTHER WHERE Event Filter Variable`

<p>
<center><img src="{{ site.root }}/images/posts/event-filter-metric.png" alt="Metric for Event Filter" width="600"></center>
</p>

It's a count of the ID of the child table (Event), by the ID of the parent table, filtered by the variable we just made. Go into each report on your dashboard, and add in a Numeric Range Filter. For the attribute, select the high level Connection Point - User.ID in this situation. For the metric, select Event Filter Metric where > 0. Hit save.

<p>
<center><img src="{{ site.root }}/images/posts/filter.png" alt="Connected Datasets" width="600"></center>
</p>

Finally, go to your dashboard and add on a Variable filter for the item you just made on the dashboard. 

Now, whenever you use the variable filter, you can filter the results based on the membership of that event. One thing to watch out for is orphaned records in the Donations table. Any Donations that are not linked to a User will show up in all reports, regardless of the filter. This can be fixed with a second filter on all reports. Another note is that this will NOT double count donations. If you select two groups, and there is some membership overlap, the double counted members will not have their donations be doubled.