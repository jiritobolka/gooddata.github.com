---
title: Deleting Data from Project
excerpt: GoodData releases a new API for deleting data from analytical projects.
layout: post
---

# {{ page.title }}
_by ZD ([@zsvoboda](http://twitter.com/#!zsvoboda))_

The new data deletion API has been introduced in GoodData [Release 51](http://support.gooddata.com/entries/20068968-release-51-notes-wednesday-may-4-2011). The API is located at the following URL. <pre><code>https://secure.gooddata.com/gdc/&lt;your-project-id&gt;/dml/manage</code></pre>

You can also use the CL tool <code>ExecuteDml(maql="...")</code> command instead of invoking the API directly. 

Both <code>ExecuteDml</code>  and the API require a _MAQL DELETE_ statement that performs the data deletion. Lets start with a few examples:

<pre><code>
DELETE FROM {attr.opportunity.id} WHERE {fact.oppoprtunity.probability}&lt;0 OR {fact.oppoprtunity.amount}&lt;100;
DELETE FROM {attr.opportunity.id} WHERE {created.date.yyyymmdd}&lt;"2009-01-01";
DELETE FROM {attr.opportunity.id} WHERE {created.date.yyyymmdd} BETWEEN "2010-01-01" AND "2010-12-31";
DELETE FROM {attr.opportunity.id} WHERE {label.opportunity.salesrep} IN ("SMITH","CLOONEY");
</code></pre>

So the _DELETE_ syntax is 

<pre><code>
DELETE FROM &lt;attribute&gt; WHERE &lt;condition&gt;;
</code></pre>

where

* **&lt;attribute&gt;** - determines the data that will be deleted. If you want to delete whole record from a dataset, use the dataset's CONNECTION_POINT attribute.
* **&lt;condition&gt;** - identifies the records that will be deleted. 

Lets explain the _&lt;attribute&gt;_ in more detail on an example. The attribute _{attr.opportunity.id}_ is the CONNECTION_POINT of the _Opportunity_ dataset. The dataset also contains the _{attr.opportunity.status}_ attribute. The _{attr.opportunity.status}_ has the _{label.opportunity.status}_ label. Then the statement

<pre><code>
DELETE FROM {attr.opportunity.status} WHERE {attr.opportunity.status}="Open";
</code></pre>

deletes the single _Open_ value from the _{attr.opportunity.status}_ attribute. The dataset's records are preserved. This statement most probably breaks the referential integrity of the project as the records with the _Open_ status no longer reference any value in the {attr.opportunity.status} attribute. 

The statement

<pre><code>
DELETE FROM {attr.opportunity.id} WHERE {attr.opportunity.status}="Open";
</code></pre>

deletes all records with the attribute {attr.opportunity.status} equal to _Open_ .  


**WARNING:** The _MAQL DELETE_ command is translated to a corresponding SQL command. This might have certain unwanted side effects. For example, the following statement:

<pre><code>
DELETE FROM {attr.opportunity.id} WHERE {created.date.yyyymmdd}&gt;"John Doe";
</code></pre>

deletes all records from the _Opportunity_ dataset because the value _"John Doe"_ gets converted to a NULL date. Similarly, the statement:

<pre><code>
DELETE FROM {attr.opportunity.id} WHERE {label.opportunity.salesrep}&gt;"CLOONEY";
</code></pre>

deletes all opportunities that are associated with sales reps that come after _"CLOONEY"_ in the alphabet.

And the last one. You need to be the admin to invoke this API.  