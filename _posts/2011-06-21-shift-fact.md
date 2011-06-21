---
title: Modeling Technique - Pushing FACTs Down the Hierarchy
excerpt: Improving clarity and performance of your data models
layout: post
---

# {{ page.title }}
_by ZD ([@zsvoboda](http://twitter.com/#!zsvoboda))_

This article shows a special data modeling trick that leads to simpler and more usable data models. This technique is applicable to data models that perform computations on facts in different datasets. Let me demonstrate the technique on a simple data model. 

![Initial Data Model]({{ site.root }}/images/posts/2011-06-21-original.ldm.png)

We need to combine the <code>Quarterly Bonus</code> and the <code>Payment</code> facts in a single report. One option is to follow the [M:N modeling technique that we have mentioned earlier](http://developer.gooddata.com/blog/2011/01/21/m-to-n-relationships-in-gooddata/). This technique is suitable for situations when we can't change the data model of the project. The option that I'm introducing in this article require the project's data model change. However it leads to more usable metrics and overall better performance. The first step is that we need to push the <code>Employee</code> dataset's facts to the <code>Salary</code> dataset. Here is the new model:

![New Data Model]({{ site.root }}/images/posts/2011-06-21-new.ldm.png)

Let me emphasize that there are 205 employee records and 3876 salary records in my test data. This means that the 205 different <code>Quarterly Bonus</code> values are somewhat duplicated (de-normalized) in the 3876 salary records. We need to handle the duplicities in our metrics definitions. Here are the metrics:

- Salary Paid : <code>SELECT SUM(Payment)</code>
- Employee Quarterly Bonus : <code>SELECT MIN(Bonus (Quarterly)) BY Employee, Quarter/Year (Payment)ALL IN ALL OTHER DIMENSIONS</code>
- Bonus Paid : <code>SELECT SUM(Employee Quarterly Bonus)</code>

The MIN aggregation in the <code>Employee Quarterly Bonus</code> metric converts all duplicate <code>Quarterly Bonus</code> values to a single value per Employee and Quarter. As all these values should be the same, we could also use the MAX or AVG aggregation.

Here is the report with all metrics computed on my test data:

![Test Report]({{ site.root }}/images/posts/2011-06-21-report.png)
