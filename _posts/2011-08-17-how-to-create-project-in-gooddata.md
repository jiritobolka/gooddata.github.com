---
title: Building a Project in GoodData
excerpt: High level overview on how to create projects on GoodData Platform
layout: post
---
# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

So you want to start analyzing your business data using the GoodData Platform and don't know where to start. Well, you have two different options to choose from to help you get started - use **Apps** that are based on prepared project templates or build a **custom project**. If you are not sure about how to start building your own custom project on the GoodData Platform, use our [Apps](http://www.gooddata.com/apps) or read about [building an app](http://www.gooddata.com/blog/building-an-app-part-1) non-programmatically. This is very easy and you can start analyzing your data within minutes. The second option is more technical and powerful.

Let's move on how to create a custom project. Imagine you have multiple data sources that you want to analyze using the GoodData Platform. Is it possible? Yes, it is. So, what are the steps to be taken?

You will start with defining a Logical Data Model. The Logical Data Model describes the structure of the data you'll report on. It contains one or more datasets that can be [connected together](http://developer.gooddata.com/gooddata-cl/examples/hr/). What is in a dataset? Each dataset consists of Facts and Attributes. Facts are numbers that we will aggregate later in metrics. Attributes are names and properties that describe your Facts. For example you can compute the SUM of the Payment fact and slice it by the Department attribute in the [HR demo](http://developer.gooddata.com/gooddata-cl/examples/hr/) that is outlined on the figure below.
<p>
<center><img src="{{ site.root }}/images/posts/	2011-06-21-new.ldm.png" alt="Logical Data Model Example"></center>
</p>

The big advantage of GoodData platform is the fact that the Physical Data Model (database tables and columns) is automatically generated from the Logical Data Model. Read more in [this article](http://developer.gooddata.com/blog/2011/07/26/MAQL-description/).

Once you define a Logical Data Model, you will need to load your data in your new project. You can use the **CL Tool** for the data loading. The CL Tool is powerful command-line tool for managing GoodData projects. It automates all common tasks that you'll need to perform on your project including the LDM creation, data loading, user provisioning etc. Read [this documentation](http://developer.gooddata.com/gooddata-cl/cli-commands.html) to find out how to Create, Update and [Clone your Project](http://developer.gooddata.com/blog/2011/06/06/project-cloning/), or upload the data.

The CL Tool is built on top of connectors that allow you to transfer data from CSV files, database (JDBC) or many SaaS applications connectors (Google Analytics, Pivotal Tracker, etc.). Find out more about basic usage of the CL Tool in one of our [previous blogpost](http://developer.gooddata.com/blog/2011/06/22/useCases-part1/).

Once you have your data inside the platform you are ready to create metrics. Metrics and Attributes are the foundation of every report that you build. Metrics are, as mentioned above, aggregated (SUM, AVG, MIN, MAX) Facts. We developed powerful multidimensional query language called MAQL that you can use to create any metric you'll need. Read [the metrics documentation](http://developer.gooddata.com/docs/maql.html) or [snapshotting blogpost](http://developer.gooddata.com/blog/2011/07/29/Analyzing-Change/) to get more insight.

<p>
<center><img src="{{ site.root }}/images/posts/Building-Project-On-Platform-Metrics.png" alt="Creating Metrics"></center>
</p>

This brings us to the key part of every project - **Reports** and **Dashboards**. Reports are built on top of three important concepts: aggregation (metrics) by attributes, filtering and visualization. Every time you build a report you have to specify WHAT (which [metric](http://developer.gooddata.com/docs/maql.html)) you want to analyze, and HOW (attribute) you want to slice it. See the picture below. The Filter button helps you to filter your report data.

<p>
<center><img src="{{ site.root }}/images/posts/Building-Project-On-Platform-Report.png" alt="Building Report"></center>
</p>

The last but not least step is to choose a suitable visualization for your aggregated data. GoodData offers a lot of visualization options including pie charts, bar charts, pivot tables and so on. You can also use the custom number formatting to visualize your data. See [this example](http://developer.gooddata.com/blog/2010/10/19/numbers-trends-on-dashboard/) and [the documentation](https://secure.gooddata.com/docs/html/reference.guide.reportoptions.formatting.html) for more information about this topic.

The final step is to organize your reports in a dashboard that presents them to a specific audience (e.g. your CEO). The best practice is to identify 3-5 most important company's KPIs (metrics) and put them on the first tab as headline report (one single number). The subsequent tabs usually show the KPIs sliced by time, departments etc. See the marketing dashboard example below.

<p>
<center><img src="{{ site.root }}/images/posts/Building-Project-On-Platform-Dashboard.png" alt="Dashboard"></center>
</p>

The dashboards and reports are often embedded into the web applications and portals that your users frequently use. You'll first need to create and invite your users to the new GoodData project. It can also be [done programmatically using the CL Tool](http://developer.gooddata.com/blog/2011/07/14/add-user-to-project/). Then you can embed the dashboards and reports to your existing web app. Check out [blogpost about embedding](http://developer.gooddata.com/blog/2011/06/29/filtering-embedded-reports/). You can even setup a Single Sign On (SSO) mechanism that will allow your users to log into their GoodData project once with your web app's credentials.

Now, let's sum up the whole process once again. To create an analytical project you have to do following steps:

1. Develop Logical Data Model
2. ETL process (Getting your data in)
3. Create metrics
4. Create reports
5. Create dashboards
6. Embed reports and dashboards
7. Maintain your project: e.g. add users to your project

That's it. Start building your own project and let us know how it worked for you!
