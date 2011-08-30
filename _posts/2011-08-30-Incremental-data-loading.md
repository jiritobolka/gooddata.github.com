---
title: Incremental Data Loading
excerpt: The article describes the Incremental Data Loading and the Connection Point usage
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Well, you want to do some analytics. You will need to have complete and updated data. That means continuously loading your data which can seem difficult. However, this process can be fully automated using the GoodData CL Tool. Imagine you have a lot of data. It would be nonsense to do the full data load every time you want to update it. It would take too much time and can be very expensive. So what do we do? The solution is to use incremental data loading.

**How Incremental Data Loading Works**

Incremental data loading is a feature which is already implemented in the GoodData CL Tool. You can run it by adding parameter into the TransferData(incremental=”true”) command.  When you are uploading data using the Incremental Data Loading, the existing data won’t be deleted. The existing data will be merged/replaced with the new data that are being uploaded and new data will be appended to the existing data. The merging/replacing existing data with the new records is possible thanks to the `CONNECTION_POINT` of every record. How does it work?

The data that is being uploaded may contain records with the `CONNECTION_POINT` value that already exists in your project. As you probably know, the `CONNECTION_POINT` is a CL Tool's description of a column of your dataset (alternative to `ATTRIBUTE` and `FACT`). The data loading script simply compares the `CONNECTION_POINT` of existing records and replaces them with the new values. However, please keep in mind that if the incremental parameter is false, data loading script will delete all of the existing data and then load new data that you want to upload.

**Setting up the CONNECTION_POINT**

Now, let’s describe the `CONNECTION_POINT` functionality in more detail. The `CONNECTION_POINT` is basically the primary key of the data set. It can provide connections with other data sets (through the `REFERENCE` ldmType). If you are not familiar with joining data sets together, you can learn more about it [here](http://developer.gooddata.com/blog/2011/06/22/useCases-part2/) or see the XML schema example below.

{% highlight xml %}
<schema>
  <name>store</name>
  <columns>
    <column>
      <name>storeid</name>
      <title>StoreID</title>
      <ldmType>CONNECTION_POINT</ldmType>
      <folder>Store</folder>
    </column>
    <column>
      <name>store_name</name>
      <title>Store name</title>
      <ldmType>ATTRIBUTE</ldmType>
      <folder>Store</folder>
    </column>
      <name>employees</name>
      <title>Employees</title>
      <ldmType>FACT</ldmType>
      <folder>Store</folder>
    </column>
  </columns>
</schema>
{% endhighlight %}

The basic condition is to set it up correctly. Every single record of your data must have a unique value of the `CONNECTION_POINT`. If it doesn’t, records with the same value will be replaced during the loading. That means when you have three rows with the same CONNECTION_POINT value only the record that was uploaded last will be in your data. (replacing those two rows with the same value that was uploaded before the last record) As you can see on the example above, where the `StoreID` column is the `CONNECTION_POINT` of the dataset. 

**How to use Incremental data loading**

Let’s see two examples of how to use the incremental data loading. As we said in the beginning, you are probably in a situation where you need to update the data daily and you don’t want to keep uploading all of your data repeatedly.

**1st Example (Loading data for the last three days)**

The first use case is simple. You have the analytics application and upload the data 3 days back till today every day. So every day you use incremental data loading that includes the data from the last three days. What will the script do during the data load in this case?

It loads the data and if some of it already exists (has the same `CONNECTION_POINT` value) it will replace it with the new values. If the records you are uploading are completely new, the script will append them. 

This use case has another advantage. If the data load fails on any given day, the records will be added the next day. In this situation, the problem will be if data load fails 3 days in a row. If this occurs, the data will be missing from the application.

**2nd Example (Google Analytics)**

Another example is little bit more complex. It’s based on the specific behavior of Google Analytics. The most recent data from Google Analytics isn't usually up to date, so typically you will need to load the data from the day before everyday.

For example, yesterday we used the Google Analytics API to get the page views and visits by referrers. The API may return something like this:

2011-08-10,Google,500,30  
2011-08-10,Bing,50,15

Now, by adding the unique connection point to the records, our data load will look something like this:

ea3d273d6296684da21d3dc2aa82d0b7,2011-08-10,Google,500,30  
f4583c4214d22677d991e25d041336ea,2011-08-10,Bing,50,15

In this case, the `CONNECTION_POINT` is MD5 hash which is computed from the attributes and its values. It can be easily done with the `IDENTITY` `<transformation>` element. If you add the `IDENTITY` transformation to the dataset, the column that is transformed is automatically filled with the MD5 hash of every non-fact column (attributes, labels etc.). The transformation column is added to the dataset and uploaded regularly. See the definition of the transformation column on the example below.

{% highlight xml %}
<schema>
  <name>store</name>
  <columns>
    <column>
      <name>storeid</name>
      <title>StoreID</title>
      <ldmType>CONNECTION_POINT</ldmType>
      <transformation>IDENTITY</transformation>
      <folder>Store</folder>
    </column>
  ...
  </columns>
</schema>
{% endhighlight %}

The next day, we use the same query and it returns larger values which is normal because yesterday’s data may not have been completed. The result will be:

2011-08-10,Google,509,33  
2011-08-10,Bing,52,19

When we add our hash based `CONNECTION_POINT` to the data once again, we will get:

ea3d273d6296684da21d3dc2aa82d0b7,2011-08-10,Google,509,33  
f4583c4214d22677d991e25d041336ea,2011-08-10,Bing,52,19

Finally, we'll use the incremental data load to update yesterday's incomplete data. This is very useful if you need to replace incomplete data with complete data.

See you next time!
