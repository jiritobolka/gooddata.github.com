---
title: Disconnecting Datasets directly using MAQL
excerpt: Learn how to quickly disconnect and reconnect datasets.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

This short tip will help you understand how to edit the data model in your Project. If you are creating data models in GoodData, no matter if it’s for your own analytical purposes or for your clients, you sometimes need to make some model changes. Imagine that you need to change the reference between two data sets. Do you know how to simply do that?

Have a look at the following data model:

<p>
<center><img src="{{ site.root }}/images/posts/reconnected-dataset.png" alt="Connected Datasets" width="600"></center>
</p>

For training purposes, we are going to disconnect the Employee dataset from the Salary dataset and then connect it back again. In the same way, you are able to connect the dataset to the different dataset. The first option how to achieve this is to edit your CL Tool XML Config files, use the CL Tool to GenerateUpdateMAQL, ExecuteMAQL and finally reload the data to the Project. The second way how to do it is running the MAQL manually via the REST API. On the

`https://secure.gooddata.com/gdc/md/PROJECT_ID/ldm/manage`

you can simply paste the following MAQL DDL statement:

`ALTER ATTRIBUTE {attr.employee.employee} DROP KEYS {f_salary.employee_id};`  
`SYNCHRONIZE {dataset.salary};`

`{attr.employee.employee}` - identifies the dataset  
`{f_salary.employee_id}` - identifies the dataset column representing the foreign key

**Note:** (To identifiy correct columns and dataset identifiers, go to the `https://secure.gooddata.com/gdc/md/PROJECT_ID/query/` where you can browse metadata objects and find the correct identifier) For our example, you can browse the dataset columns in `https://secure.gooddata.com/gdc/md/PROJECT_ID/query/columns` and find the `{f_salary.employee_id}` by clicking on the link. You can also see that this is the foreign key column and copy its identifier for your usage.

This query will drop the keys in Salary dataset and disconnect the Employee dataset from it. All you need to know is the correct name of the dataset and the foreign key column. If you want to read more about creating the GoodData model using MAQL DDL, [read this article](http://developer.gooddata.com/blog/2011/07/26/MAQL-description/). See the resulting data model:

<p>
<center><img src="{{ site.root }}/images/posts/disconnected-dataset.png" alt="Disconnected Datasets" width="600"></center>
</p>

As you can see, we just successfully disconnected two datasets. Now, let’s see how to connect them back together. Running a similar but not the same query on your data model will do this. See the MAQL query:
 
`ALTER ATTRIBUTE {attr.employee.employee} ADD KEYS {f_salary.employee_id};`  
`SYNCHRONIZE {dataset.salary};`

Remember to synchronize the dataset because you are changing the physical data model. As you can see on the picture below, model is same as in the beginning of the tutorial and you can load the data back into the Project. 

<p>
<center><img src="{{ site.root }}/images/posts/reconnected-dataset.png" alt="Reconnected Datasets" width="600"></center>
</p>

Feel free to ask any questions to discuss the MAQL usage below!


