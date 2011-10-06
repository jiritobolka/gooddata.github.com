---
title: MongoDB Behind the Scene
excerpt: Read more about why and how we use the Mongo DB.
layout: post
---

# {{ page.title }}

_by Roman Pichlik_

Some time ago, [Jiri Tobolka](http://twitter.com/jirtob) wrote a nice [introduction](http://developer.gooddata.com/blog/2011/09/13/Notifications-API/) to the Notifications API on the GoodData platform. I would like to share with you the technical details behind the scenes, especially some details about the storage engine we've used for the notifications data...

There are three main entities in the Notification domain model - _ChannelConfiguration_, _Subscription_ and _Trigger_. Their relationships are on the next picture.

<center><img src="{{ site.root }}/images/posts/mongo-1.png" alt="Reports"></center>

We had been facing the issue of how to persist these entities. In the GoodData platform we keep most of data in the good old relational database (RDBMS), but we are all aware of the constraints. One year ago, we did a proof of concept for storing the data out of the relational database because the characteristics of the data. 

Data didn't fit into the relational model. Let me explain it in the Notifications model example.
We mentioned that the Notifications consisted of three entities. If we had chosen a relational database for storing them, we would have probably ended up with a normalized schema as you can see in the next picture.

<center><img src="{{ site.root }}/images/posts/mongo-2.png" alt="Reports"></center>

There are seven tables if we count the join tables required for many-to-many relationships. Such a normalized schema would cause a couple of problems. We would have to add a new table for every new channel. We would also have to use the left outer join for querying subscription with associated channels and use cascade deletion on a database level or in application logic because of referral integrity. 

We could store these entities as BLOBs but in this case, it wouldn't be the best option because we wouldn't be able to query such documents e.g. get me all notifications for project X.

## Document Oriented Databases

The mental shift here is to realize that we deal with documents. We store, get, update, query and delete documents. We have been looking for a document oriented database. There are great NoSQL databases like Riak, Cassandra, Redis, HBase but most of them are key/value oriented. That means that if we were to use some of these NoSQL options would have to transform our documents to key/value structures with almost zero benefits over the conventional RDBMS.

Even with a document oriented database some concepts are similar to RDBMS. Documents are organized in collections. Collections are something like database tables in RDBMS. A collection allows you to store documents with different structure or even type. Opposite to a database table where the structure is determined by columns and their types. We can say that document fields correspond with table columns, but there are differences such as, no strict type or schema. In general, there are no schema requirements for your documents, fields or collections. We call these databases schema-less.

It brings some advantages and disadvantages or things that should be kept in mind. When you want to add new fields in a new version of a document, you can migrate the old versions on the fly in runtime and reduce server downtime, for example. On the other hand, there are no data consistency constraints on the storage level and you can enforce them only in an application logic.

Let's go back and see how the Notifications documents can be stored in a document-oriented database. There are two collections for channels and subscriptions. Documents are self-contained. A subscription document contains trigger definitions and meta definitions, for example. The relationship between channels and subscriptions are expressed weakly. Only an ID of a related channel document is held. There is no foreign key constraint. Documents can be updated or deleted independently and consistency is checked in an application logic.

<center><img src="{{ site.root }}/images/posts/mongo-3.png" alt="Reports"></center>

If we are talking about a document oriented database then there are two well known solutions _MongoDB_ and _CouchDB_. The fundamental difference between _MongoDB_ and _CouchDB_ is in querying and accessing the data. The _CouchDB_ queries are expressed as Map/Reduce functions. Queries are special documents called views that contain defined Map/Reduce functions. You won't be able to query data unless you define a view. The _MongoDB_ queries are expressed as structured JSON-objects. _MongoDB's_ approach is more declarative opposite to _CouchDB_. You can define indexes over stored documents and a get performance boost when querying over fields in these indexes. _MongoDB_ allows dynamic queries where an index does not exist. That's very similar to RDBMS world. In addition _MongoDB_ supports Map/Reduce as well, but it's intended for data processing, not querying.

Documents in _CouchDB_ are accessed over HTTP and REST interface. _MongoDB_ uses a proprietary binary protocol on top of TCP/IP and therefore language specific driver is required.

## MongoDB

After considering all requirements and technological constraints we chose _MongoDB_ over _CouchDB_. The main reasons are:

- querying capabilities - In general, querying data in _MongoDB_ is more of a natural way than thinking in Map/Reduce.
- driver - performance, very handy for clients
- scalability - _MongoDB_ supports (no hacks) sharding functionality by default. That's very important for a SAAS provider such as GoodData.
- tools - backup/restore/monitoring utilities, administration console, JSON and JavaScript as a first class citizen

_MongoDB_ was successfully deployed on the production servers and developer machines. We use _MongoDB_ with enabled journaling even if it has some performance penalties.  This is not problem since we have mostly read operations. The second option would be deploy _MongoDB_ in a cluster with replicating nodes. _MongoDB_ supports auto-sharding, so we can shard data on a project base in the future.

