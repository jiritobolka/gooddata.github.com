---
title: The Event Store Introduction
excerpt: High level overview on what is the Event Store
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Hello all you analysis ninjas! Today I'd like to start a huge topic which is very wide and will cover multiple blogposts. I would like to introduce you to a brand new data warehousing technology that we developed in the GoodData Platform. We have been using it internally some time and now, it’s time to release it to the public, so anyone of you GD developers, can start building analytics projects and apps using this new technology.

## Snapshotting

Remember earlier [Analyzing Changes](http://developer.gooddata.com/blog/2011/07/29/Analyzing-Change/) blogpost? I hope so! If you want to use the snapshotting technique you need to store all your data somewhere. By storing your complete data, you'll have access to all of the data snapshots in your storage and you will be able to analyze changes. 

Imagine that you have, let’s say, about 100k rows of data in your Salesforce application and you would like to upload it on regular basis (i.e. weekly). You also want to store all weekly loads, because you'll need to have the history of data values. This is very memory consuming process.

<p>
<center><img src="{{ site.root }}/images/posts/event-store/snapshots.png" alt="Reports"></center>
</p>

See the picture above. Only one row was changed, but we loaded all three rows. Until now, you've had to upload all of the data repeatedly which can be inefficient. In the classic data warehouse system, every record is loaded every time you upload your data. Every time you start loading data from the source system to your data warehouse, it will be a full load no matter if the data was changed or not. The size of your data warehouse increases very quickly.

We need something different. We need to use a better approach with more sophisticated technology. We need the Event Store!

## The New Era

At GoodData, we've worked very hard to develop a better data warehouse. Something that will help you work with a huge amount of data easily and dynamically. We needed something that won’t be wasting the data warehouse memory and also help you with the whole ETL process.

<p>
<center><img src="{{ site.root }}/images/posts/event-store/es_schema.png" alt="Data Integration"></center>
</p>

What we've created here is brand new data warehousing technology. It's called the EventStore. The EventStore decreases of the amount of data in your data warehouse but keeps all your historical data.

Imagine, you are using Salesforce as your CRM solution and you want to analyze your data to get some regular insights. You need to have your data up-to-date in your BI system. Also, you want to keep your historical data in order to look back in retrospect and as we have mentioned earlier, the classic approach fails here. How does the Event Store work?

The EventStore creates a special stream for every field. Every time you start loading your data that you had been previously downloaded from the source system (i.e. Salesforce, SugarCRM) the Event Store checks the corresponding stream. If there are some changes since the last upload, the Event Store will update them with a new record value. It also stores historic values.

<p>
<center><img src="{{ site.root }}/images/posts/event-store/record_stream.png" alt="Record Stream"></center>
</p>

As you can see, the size of your data warehouse will be increasing much slower, than if you use the classic storage.

The EventStore will enable you to load the data for a specific time period and with a specific granularity. You will be able to load for example all daily snapshots between beginning of the Quarter and Today. You can create another project and load a monthly snapshots from the EventStore here. As a result today, you will get a CSV file that you can upload to the GoodData Platform, create metrics, prepare reports and dashboards.

## More Features to Come

Keeping your data warehouse at a reasonable size while, at the same time, keeping your data history isn't the only feature. These are just basics. With Event Store, you will be able to make a transformation on an output and prepare pre-aggregated data or compute values. More features and integrations are coming up in a near future.

Stay tuned for the next blogpost of the Event Store series, where I will show you examples on how to start using Event Store in your projects. This is just a beginning.
