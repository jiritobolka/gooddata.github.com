---
title: How to set up Dashboard Macros
excerpt: Learn how to quickly disconnect and reconnect datasets.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

## The situation

You would like to add some special features or functionality to a dashboard that you are creating for a client. Let's say, you want to add a custom widget to your dashboard. The widget is located on your servers and you would like to pass the http parameter into the widget. 

## How it works

This feature works with variable filters. You’ll need to set the variable filter to the dashboard. The variable filter that is set to the attribute value, will allow you to dynamically change the parameter that is used in a custom widget. 

## Setting up dashboard macro

1) Create new variable 

The first step is to create the new variable. Go to the Manage tab and click on the Variable link. Here is where you can create new variable. Name it, choose the Filtered Variable instead of Numeric Variable and select the attribute that you will use to filter the dashboard.

<p>
<center><img src="{{ site.root }}/images/posts/variable-filter.png" alt="Create New Variable" width="600"></center>
</p>

2) Get the variable identifier

If you've Saved Changes and the variable is successfully created, it is time to get the variable identifier. Within the variable page, you can easily edit the browser URI and move to the “grey pages” where you can try to...

<p>
<center><img src="{{ site.root }}/images/posts/variable-page.png" alt="Variable Page" width="600"></center>
</p>

See the browser URI and delete highlighted part.

`https://secure.gooddata.com/#s=/gdc/projects/<project-id>|objectPage|/gdc/md/<project-id>/obj/XXX`

`https://secure.gooddata.com/gdc/md/<project-id>/obj/XXX`

<p>
<center><img src="{{ site.root }}/images/posts/variable-object-uri.png" alt="Variable Object URI" width="600"></center>
</p>

On the picture below, you can see the “grey pages” where you can find the variable identifier. The identifier is unique for every object in the Platform. 

<p>
<center><img src="{{ site.root }}/images/posts/variable-object-grey-pages.png" alt="Grey Pages" width="600"></center>
</p>

3) Add variable to the dashboard

Now, go to the dashboard and add new Variable Filter. Select the variable that you've previously created and want to use in the filter.

<p>
<center><img src="{{ site.root }}/images/posts/variable-filter-dashboard.png" alt="Filter on Dashboard"></center>
</p>

4) Add Custom Web Content to Dashboard

Edit the dashboard and select Add Web Content from the top menu bar. The address that you can see in the picture below is the testing address provided by GoodData and you can use it for testing the Dashboard Macros.

You can replace the `identifier_placeholder` with your identifier (the one copied above) and click 'Save'. You can also pass the value selected in the filter to your own web server with a similar URL such as (replace `identifier_placeholder` with your variable identifier)

`https://your.webserver.foo.com/yourpage.php?your_key=%VARIABLE_VALUE(identifier-placeholder)%`

<p>
<center><img src="{{ site.root }}/images/posts/test-uri-macro.png" alt="Testing URI" width="450"></center>
</p>

5) Test it

Save the previous step and go back to the dashboard, where you can now test the new feature. Just drop down the filter tab and select the values that you want to filter. If everything works and attribute values are changing specifically as you are changing the 

<p>
<center><img src="{{ site.root }}/images/posts/all-values-macro.png" alt="All Values Macro" width="600"></center>
</p>

Now see the picture below, where “HQ Finance and Accounting” value is selected.

<p>
<center><img src="{{ site.root }}/images/posts/one-value-macro.png" alt="One Value Macro" width="600"></center>
</p>

Once you know how to use dashboard macros, you will be able to prepare some more creative and innovative dashboards for your clients!