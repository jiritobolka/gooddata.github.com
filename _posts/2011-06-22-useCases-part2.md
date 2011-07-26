---
title: Using GoodData CL tool - Part 2
excerpt: Useful use cases for using GoodData CL tool (Part 2)
layout: post
---

# {{ page.title }}
_by Jiri Tobolka_

In the [previous part]({{ site.root }}/blog/2011/06/22/useCases-part1/) of this series we've created a new project defined `incorrect XML config` file and finally we've updated that file correctly. This is second part of the series in which we'll be using basically the same data model and we'll update it. Again we have two Examples - first example is about adding new field to the model. In second example we will upload new dataset.

**Example 1 - Updating a file (adding new field)**

Let's get down the business. We have actually updated the original `data.csv` file and we added Customers `FACT` field. So updated `CSV file` should looks as follows:  

...  
Date, Revenue, Count, Store, Customers  
01/01/2010, 807.84, 816, SFO, 47  
...  

(**Note:** file has five fields - DATE field, ATTRIBUTE field and three FACT fields )

What we do next is manually updating the `XML config` file adding new column **to the end** of an XML file. (order is critical!)
Here is the updated XML file after adding new column: 

{% highlight xml %}
...
...
    <column>
      <name>store</name>
      <title>Store</title>
      <ldmType>ATTRIBUTE</ldmType>
      <folder>Sales</folder>
    </column>
    <column>
      <name>customers</name>
      <title>Customers</title>
      <ldmType>FACT</ldmType>
      <folder>Sales</folder>
    </column>
  </columns>
...
{% endhighlight %}

We actually have all parts prepared for updating the data model and for uploading data. We just need the `CL script` which has again several parts. It will update data model (`GenerateUpdateMaql()` for updating `MAQL` file) and load the data:

{% highlight ruby %}
#1 - CREATE OR RETRIEVE PROJECT ID
RetrieveProject(fileName="myProject.pid");

#2 - UPDATE DATA MODEL
UseCsv(csvDataFile="data.csv", hasHeader="true", configFile="schema.xml",separator=",");
GenerateUpdateMaql(maqlFile="file1.maql");
ExecuteMaql(maqlFile="file1.maql");

#3 - LOAD DATA
TransferData(incremental="false");
{% endhighlight %}

(**Note:** if you don't understand some script commands see our [CL tool documentation]({{ site.root }}/gooddata-cl/cli-commands.html) )

After execution we can see the result in GoodData. It wasn't so complicated, was it? So review the model and it's here with new `FACT` field:

![Model with customers]({{ site.root }}/images/posts/model3.png)

**Example 2 - Adding new dataset**

This example is ostensibly more complicated but it won't be a big problem at all. So...let's do it! Imagine you need to add new dataset to your model. You have two CSV files containing the data. First is our well known `data.csv` as mentioned above with five fields (Date, Revenue, Count, Store, Customers), second is new `store.csv` lookup file:

...
StoreID, Store Name, City, State, Employees
SFO, San Francisco Airport Store, San Francisco, CA, 18
...

As you can see there are 5 fields. StoreID is the `CONNECTION_POINT` that is referenced by Store `REFERENCE` in `data.csv`, Employees is `FACT` field and the rest are `ATTRIBUTES` fields.

(**Note:** remember the functionality of `CONNECTION_POINT` and `REFERENCE` ldmType. `CONNECTION_POINT` has same function as `primary key` and `REFERENCE` is analogy to `foreign key`.)  

What we do next is generating `store.xml` config file for our new lookup file containing the store information. We'll do this with `CL script` again:

{% highlight ruby %}
#1 - CREATE OR RETRIEVE PROJECT ID
RetrieveProject(fileName="myProject.pid");

#2 - GENERATE XML FILES (DATA MODEL) - DO THIS STEP ONLY ONCE!!!
GenerateCsvConfig(csvHeaderFile="store.csv",configFile="store.xml",separator=",");
{% endhighlight %}

Now we have to manually check and update the `store.xml` file that should looks as follows with StoreID as a `CONNECTION_POINT` `ldmType`:

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
    <column>
      <name>city</name>
      <title>City</title>
      <ldmType>ATTRIBUTE</ldmType>
      <folder>Store</folder>
    </column>
    <column>
      <name>state</name>
      <title>State</title>
      <ldmType>ATTRIBUTE</ldmType>
      <folder>Store</folder>
    </column>
    <column>
      <name>employees</name>
      <title>Employees</title>
      <ldmType>FACT</ldmType>
      <folder>Store</folder>
    </column>
  </columns>
</schema>
{% endhighlight %}

Last thing you have to do with `XML` files before executing final `CL script` is to update `Store` column in original `schema.xml` file. You should update it as follows adding `schemaReference` attribute:

{% highlight xml %}
...
<column>
  <name>store</name>
  <title>Store</title>
  <ldmType>REFERENCE</ldmType>
  <schemaReference>store</schemaReference>
  <reference>storeid</reference>
  <folder>Sales</folder>
</column>
...
{% endhighlight %}

Now we have all files prepared to finish this example with the `CL script` execution. We'll `retrieve project id`, then create new data model for `store.xml` lookup file, update existing data model for `schema.xml` file. Finally we'll load data. Remember that you **must load lookup file first**!

Here is the script:

{% highlight ruby %}
#1 - CREATE OR RETRIEVE PROJECT ID
RetrieveProject(fileName="myProject.pid");

#2 - CREATE DATA MODEL FOR LOOKUP FILE - store.xml
UseCsv(csvDataFile="store.csv", hasHeader="true", configFile="store.xml",separator=",");
GenerateMaql(maqlFile="store.maql");
ExecuteMaql(maqlFile="store.maql");

#3 - UPDATE DATA MODEL FOR EXISTING MODEL - file1.xml
UseCsv(csvDataFile="store.csv", hasHeader="true", configFile="schema.xml",separator=",");
GenerateUpdateMaql(maqlFile="file1.maql");
ExecuteMaql(maqlFile="file1.maql");

#4 - LOAD DATA (MUST LOAD LOOKUP FILE FIRST)
UseCsv(csvDataFile="data.csv", hasHeader="true", configFile="store.xml",separator=",");
TransferData(incremental="false");

UseCsv(csvDataFile="data.csv", hasHeader="true", configFile="schema.xml",separator=",");
TransferData(incremental="false");
{% endhighlight %}

And...That's it. We've added new dataset to our model. You can review the resulting model in GoodData:

![New dataset]({{ site.root }}/images/posts/model4.png)

So that's all for today. Stay tuned for next blogpost and enjoy coding!