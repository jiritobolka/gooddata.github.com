---
title: Deleting Records from Datasets
excerpt: The article show multiple examples of DML language
layout: post
---

# {{ page.title }}

_by Michael Stencl & Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Not sure how to delete some data from your project? Well,we’ve already had an [introduction](http://developer.gooddata.com/blog/2011/05/03/deleting-data-from-project/) to this particular topic, but by popular demand, we’ve been asked for some more examples. So, today we’ll show you some more tips and how-tos! The MAQL DML (Data Manipulation Language) is here for you! Also known by it’s powerful nickname - Destructive MAQL. 

It should be used very carefully, because if you delete the attribute value, You won’t be able to roll-back it. We have several use-cases which explain how powerful the delete command is. The most important issue is the referential integrity corruption. 

When deleting rows from an attribute table. You must keep in mind which of the affected values are directly connected to the fact through the facts of table (in our HR example LDM is the facts of table Salary). See the most general syntax of the delete statement below:
			
`DELETE FROM {attribute.factsof} WHERE <condition>`
			
Now, you basically know what you can do by using it and it's to time to show you where to start. You want to start using it, right? GoodData doesn’t support running the DML statements from the UI, so you’ll need to navigate around the grey pages. The command line for running the DML statements is located in the following URL
			
`https://secure.gooddata.com/gdc/md/<project_id>/dml/`

You can alsi use our gray pages to use DML. See the screenshot below:

<p>
<center><img src="{{ site.root }}/images/posts/DML-Manage.png" alt="DML Gray Pages"></center>
</p>
			
We also extremely recommend you to validate your model before and after each DML statement to be sure no referential integrity errors are produced after your deletion. 

The following example deletes or destroys all of the rows in the Salary table:
			
`DELETE FROM {attr.salary.salary}`
			
This is a very unusual example because normally, we don’t like to delete all of the rows. 

We start with the condition construct. The conditions support most of the rational (>, <, =) and logical (AND, OR, NOT) operators. The left side of the condition can be defined from the fact element or the label defined on the attribute. The right hand side provides a value expression.
						
The following example shows one of the elementary situations where we delete all the rows from Salary facts of table, where the value of payment is lower or equal to 10000. For now, the lower or equal sign ("=<") is not supported in the DML conditioning.
						
`DELETE FROM {attr.salary.salary} WHERE {fact.salary.payment} < "10000" OR {fact.salary.payment}="10000";`

Another situation where the delete statement is very handy is when you need to delete all rows where the fact has zero value. This example is shown below:
						
`DELETE FROM {attr.salary.salary} WHERE {fact.salary.payment}=0;`
						
Think about a situation when you have some rows in fact tables where there are values of zero. In this situation, the facts Volume or Close price having zero value are affecting the resulting report. Then, we’ll need to delete all of the rows which have zero Volume or the Close Price is zero.
						
`DELETE FROM {attr.salary.salary} WHERE {fact.salary.payment}= 0 OR {label.salary.dt_payday} = "2010-02-29";`

Still in need of some more examples? OK, we have something for you. Another example on how to delete rows from an attribute is by using the defined attribute label. If we want to delete all rows where the name of the person (defined by label) is Ed or Lin, we use following statement.
						
`DELETE FROM {attr.employee.employee} WHERE {label.employee.employee.firstname} IN ("Ed","Lin");`
						
Another interesting use-case is deleting of the old data attribute values. For example when you need to delete all rows where the date is older than 1st January of 1999. See the example below
						
`DELETE FROM {attr.salary.salary} WHERE {label.salary.dt_payday} < "2006-02-01";`

The right handed side of the condtion ("2006-02-01") must have the same format as defined by the label otherwise an error will be reported.
						
Note that if you, by mistake, try to use anything other than a label in the condition of our delete statement, then an error occured. Note that you are not allowed to delete any rows from the date dimension provided by GoodData.

Delete all rows where for the 2010 (all the dates are between 1st Jan and 31st Dec 2010). Again, we have an example. See below:
						
`DELETE FROM {attr.salary.salary} WHERE {label.salary.dt_payday} BETWEEN "2010-01-01" AND "2010-12-31";`

If you want to delete any attribute value, you have to start by deleting the referencing attribute values of the attribute we’d like to delete. If you won't keep this workflow, referential integrity will be broken.

So, if you want to delete department with ID = 1, you  first have to delete all the employees who work in that department.
						
Remember, after you finish all the delete operations, it’s important to validate your model again. The validation shows you the actual status and checks the referential integrity of the whole model.
							
The validation is located in the grey pages of your projects which you can find in the following URL:
			
`https://secure.gooddata.com/gdc/md/<project_id>/validate/`

Let us know how it works! And for more information about MAQL, download our new Advanced MAQL Reference Guide

<center><a href="{{ site.root }}/docs/reference-guide/Adv_MAQL_Ref_Guide.pdf" class="greenButton" onClick="_gaq.push(['_trackEvent', 'PDF', 'Download', 'MAQL Reference Guide']);">Download the MAQL Reference Guide</a></center>

