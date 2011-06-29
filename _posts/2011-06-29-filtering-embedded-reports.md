---
title: Filtering Embedded Reports &amp; Dashboards via HTTP Parameters
excerpt: Filter embedded reports and dashboards via HTTP URL parameters 
layout: post
---

# {{ page.title }}
_by ZD ([@zsvoboda](http://twitter.com/#!zsvoboda))_

*NOTE:* This article previews the functionality that we are going to release in the Release 56 (~ 7/18/2011). Let me know if you are interested in beta testing this functionality. I can invite you to a beta server. 

The embedded reports can be filtered via a their IFrame URL parameters. This blogpost demonstrates the new functionality on a simple example.

We will start with a simple Salesforce report that shows opportunity amount sliced by the lead source and the opportunity stage.

![Salesforce Report]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-1.png)

Let's grab the report's embedding URL from the embed dialog. We will just cherry-pick the URL from the IFrame _src_ attribute for now as we'll put it directly to the browser.

<code>https://secure.gooddata.com/reportWidget.html#project=/gdc/projects/Project4&report=/gdc/md/Project4/obj/20887</code>

![Report URL]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-1.png)

We put the IFrame URL to the browser and the report appears in a separate tab.

![Embedded Report]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-3.png)

Now we want to filter the report by the _StageName_ attribute. We need to first determine the unique identifier that we'll use for identifying the attribute in the filter. To be precise, we'll filter by something what we call label. The labels contain the human readable names. The attributes are technically just unique numbers. Most attributes have just one label. However there might be attributes with multiple labels (e.g. _Person_ with a _Firstname_, _Lastname_, and _SSN_). The _StageName_ has two labels and we will filter by the label that contains the stage name.

First, we need to enumerate all labels associated with the _StageName_ attribute. Let's go to the _Manage_ section of the GoodData UI, select the _Data_ tab and find the _StageName_ attribute. 

![StageName]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-4.png)

Note the <code>/gdc/md/Project4/obj/738</code> suffix of the page's URL. This is the GoodData metadata server's URL of the _StageName_ attribute. Every object has its own unique URL. Now we will take a look at the _StageName's_ definition in the gray pages. We'll just append the _StageName_ unique URL to the GoodData server's URL  <code>https://secure.gooddata.com/gdc/md/Project4/obj/738</code> and open the result in the browser:

![StageName Grey Pages]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-5.png)

We can see that the _StageName_ attribute has two labels (attributeDisplayForms) and that the identifier of the stage name label is <code>label.opportunity.stagename</code>.

Yes, I know that we need to display this information on the attribute's page to avoid the harakiri above and we'll do this ASAP.

Now once we have the label's identifier, we can use it in our report embedding URL. The usage is pretty straightforward:

<code>https://secure.gooddata.com/reportWidget.html?label.opportunity.stagename=Qualification#project=/gdc/projects/Project4&report=/gdc/md/Project4/obj/20887</code>

![Filtered Report]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-6.png)

We can also filter by two _StageName_ values. Please note that _Closed Won_ value must be URL-encoded because it contains the space.
 
<code>https://secure.gooddata.com/reportWidget.html?label.opportunity.stagename=Qualification&label.opportunity.stagename=Closed%20Won#project=/gdc/projects/Project4&report=/gdc/md/Project4/obj/20887</code>

![Filtered Report]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-7.png)

Multiple conditions with the same label are joined with the _OR_ logical operator. Multiple conditions with a different labels are _ANDed_.

<code>https://secure.gooddata.com/reportWidget.html?label.opportunity.stagename=Closed%20Won&label.opportunity.leadsource=Partner#project=/gdc/projects/Project4&report=/gdc/md/Project4/obj/20887</code>

![Filtered Report]({{ site.root }}/images/posts/2011-06-29-filtering-embedded-reports-8.png)




  
