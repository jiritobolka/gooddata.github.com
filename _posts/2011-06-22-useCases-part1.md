---
title: Using GoodData CL tool - Part 1
excerpt: Useful use cases for using GoodData CL tool (Part 1/2)
layout: post
---

# {{ page.title }}
_by Jiri Tobolka_

Today we will show you some useful scenarios for our `GoodData CL Tool`. This blogpost contains two use cases so you can learn how to correctly upload data file and how to update it later if you've made a mistake.  

**Example 1 - Uploading file (with incorrect ldm file)**

So let's start with first, simple but useful use case. You will need to have simple data file (ours has four fields) which we are about to upload to GoodData project (with incorrect ldmField attributes). We have `data.csv` data file:  

...  
Date, Revenue, Count, Store  
01/01/2010, 807.84, 816, SFO  
...  

It consists of one `DATE` field, one `ATTRIBUTE` field and two `FACT` fields. We'll create a project with this simple data file, generate an `XML config` file to define a data model and finally upload the data using `CL script` tool. The point is creating `incorrect XML file` with only one `FACT` type and three `ATTRIBUTES` which is incorrect.

(**Note:** You have to **manually edit XML** file after generating it to define the model schema before you create the data model.)

You can see the pre-prepared `CL script` down here:

{% highlight ruby %}
#1 - CREATE PROJECT
CreateProject(name="My New Project");
StoreProject(fileName="myProject.pid");

#2 - GENERATE XML FILES (DATA MODEL) - DO THIS STEP ONLY ONCE!!!
GenerateCsvConfig(csvHeaderFile="data.csv",configFile="schema.xml",separator=",");
{% endhighlight %}

After second section you have to **manually edit the XML** file to define schema. Here is the final XML file:

{% highlight xml %}
...
<columns>
    <column>
      <name>date</name>
      <title>Date</title>
      <ldmType>ATTRIBUTE</ldmType>
      <folder>Sales</folder>
    </column>
    <column>
      <name>revenue</name>
      <title>Revenue</title>
      <ldmType>ATTRIBUTE</ldmType>
    </column>
    <column>
      <name>count</name>
      <title>Count</title>
      <ldmType>FACT</ldmType>
      <folder>Sales</folder>
    </column>
    <column>
      <name>store</name>
      <title>Store</title>
      <ldmType>ATTRIBUTE</ldmType>
    </column>
  </columns>
...
{% endhighlight %}

(**Note:** as we define above you edited the schema.xml file incorrectly. It has wrong `ldmType` (as mentioned above) and also only two columns have folders assigned to them.)

Now execute the last two sections to create a data model with data XML config file and CSV data file, and finally load the data:  

{% highlight ruby %}
#1 - CREATE OR RETRIEVE PROJECT
RetrieveProject(fileName="myProject.pid");

#2 - CREATE DATA MODEL
UseCsv(csvDataFile="data.csv", configFile="schema.xml", hasHeader="true", separator=",");
GenerateMaql(maqlFile="file1.maql");
ExecuteMaql(maqlFile="file1.maql");

#3 - LOAD DATA
TransferData(incremental="false");
{% endhighlight %}

You can now see the resulting model in GoodData:

![Wrong model]({{ site.root }}/images/posts/model1.png)

**Example 2 - Updating the file and defining fields appropriately (same file as in example 1)**

In following example we'll work with the same file but we'll define the **XML config file correctly**. So what we do. 

Firstly we'll edit the `XML config file` with setting correct `ldmType` (Date as `DATE`, Revenue and Count as `FACT`, Store as `ATTRIBUTE`). 
Secondly we'll add the `<folder>` to the XML for all fields that miss this attribute to place field to appropriate folder on front end. 
Thirdly we'll create `Date MAQL` files generate the Date dimension and finally we'll run the `CL script` to update `MAQL` files. 
	
So after first step you will get the correct XML config file as you can see below:

{% highlight xml %}
...
<columns>
    <column>
      <name>date</name>
      <title>Date</title>
      <ldmType>DATE</ldmType>
      <datetime>false</datetime>
      <format>MM/dd/yyyy</format>
      <schemaReference>Date</schemaReference>
    </column>
    <column>
      <name>revenue</name>
      <title>Revenue</title>
      <ldmType>FACT</ldmType>
      <folder>Sales</folder>
    </column>
    <column>
      <name>count</name>
      <title>Count</title>
      <ldmType>FACT</ldmType>
      <folder>Sales</folder>
    </column>
    <column>
      <name>store</name>
      <title>Store</title>
      <ldmType>ATTRIBUTE</ldmType>
      <folder>Sales</folder>
    </column>
  </columns>
...
{% endhighlight %}

You see that all columns contain `<folder>` attributes and all `ldmType` fields are correct. We've also added the date `schemaReference` to the Date column to connect the dataset to Date dimension. Now we'll move to the final step of this example using following GoodData `CL script`: 
	
{% highlight ruby %}	
#1 - CREATE OR RETRIEVE PROJECT ID
RetrieveProject(fileName="myProject.pid");

#2 - CREATE DATE DIMENSIONS - DO THIS STEP ONLY ONCE!!!
UseDateDimension(name="Date", includeTime="false");
GenerateMaql(maqlFile="date.maql");
ExecuteMaql(maqlFile="date.maql");
TransferData();

#3 - UPDATE DATA MODEL
UseCsv(csvDataFile="data.csv", hasHeader="true", configFile="schema.xml",separator=",");
GenerateUpdateMaql(maqlFile="data.maql");
ExecuteMaql(maqlFile="data.maql");

#4 - LOAD DATA
TransferData(incremental="false");	
{% endhighlight %}

(**Note:** Remember the difference between `GenerateMaql` and `GenerateUpdateMaql`. The first one generates script describing data model from local config file. Second generate alter script that creates the columns available in the local configuration but missing in the remote GoodData project.)

After executing the whole `CL script` you can review the resulting model in GoodData. This is `correct model` and should looks as follows:

![Correct model with date dimension loaded]({{ site.root }}/images/posts/model2.png)

Well this is all for today, in [Part 2]({{ site.root }}/blog/2011/06/22/useCases-part2/) we'll show you how you can add field to the model and how to add a new dataset. 
Stay tuned for the next part!