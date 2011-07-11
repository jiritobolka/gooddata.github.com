---
title: Defining column with transformation element
excerpt: Transforming column with CL tool feature
layout: post
---

# {{ page.title }}
_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

As you certainly know when you work with GoodData CL tool for managing projects and data you have to create schema `XML config file` for defining your dataset. You know there are several elements associated with column element for example `<name>`, `<title>`, `<ldmType>` and there is also `<transformation>` element. What would be probably new for you is how you can also use this element for defining the column. 

The main purpose of this blogpost is to show you an option of using `JAVA` language syntax inside `<transformation>` element and create "computed value" in column based on other columns in your `XML config file`. For basic example imagine you want to join together user's `First name` and `Last name` into one `Name` column. You can join these two text fields and the rows in column is automatically filled by "computed value" with the definition in `<transformation>` element. You should use the `<![CDATA[...]]>` element inside because of non-XML code. As you can see below:

{% highlight xml %}
<transformation><![CDATA[ lastname+", "+firstname]]></transformation>
{% endhighlight %}


The feature loads all columns by name and you can then use them for creating "computed value". This is done by `JEXL technology` and you can use any of [JEXL statements](http://commons.apache.org/jexl/reference/syntax.html).


**More detailed example using Java**

As you can see below we have `XML config file` for the Opportunity dataset which is prepared for SugarCRM Analytics. Besides "standard" column `stage` (won't be uploaded because of `IGNORE` ldmType) which defines stage of every sales opportunity (final stage would acquire value `Open`, `Closed Won` and `Closed Lost`) we've prepared also three columns which will be computed from the `stage` column using `<transformation>` element.

{% highlight xml %}
<schema>
  <name>Opportunity</name>
  <columns>
     ...
     ...
      <column>
        <name>stage</name>
        <title>Opportunity Type</title>
          <ldmType>IGNORE</ldmType>
      </column>
      <column>
        <name>status</name>
        <title>Opportunity Status</title>
          <ldmType>ATTRIBUTE</ldmType>
          <folder>Opportunity</folder>
          <transformation><![CDATA[ (stage.indexOf("Closed")>=0)?((stage.indexOf("Won")>=0)?("Won"):("Lost")):("Open")]]></transformation>
      </column>
      <column>
        <name>isclosed</name>
        <title>Opportunity Is Closed</title>
          <ldmType>ATTRIBUTE</ldmType>
          <transformation><![CDATA[(stage.indexOf("Closed")>=0)?("true"):("false")]]></transformation>
          <folder>Opportunity</folder>
      </column>
      <column>
        <name>iswon</name>
        <title>Opportunity Is Won</title>
          <ldmType>ATTRIBUTE</ldmType>
          <folder>Opportunity</folder>
          <transformation><![CDATA[(stage.indexOf("Won")>=0)?("true"):("false")]]></transformation>
      </column>
  </columns>
</schema>
{% endhighlight %}

What we did is fill the `<transformation>` element with `Java` code that do the job. In `status` column we would like to have the status information which could be `Won`, `Lost` or `Open`. Following `Java` code secure that

`<![CDATA[ (stage.indexOf("Closed")>=0)?((stage.indexOf("Won")>=0)?("Won"):("Lost")):("Open")]]>`

Finally we've got the `iswon` and `isclosed` columns that show us simple true or false values based on the `stage` column. Here is the code with an easy condition

`<![CDATA[(stage.indexOf("Closed")>=0)?("true"):("false")]]>`  

respectively

`<![CDATA[(stage.indexOf("Won")>=0)?("true"):("false")]]>`.)

(**Note:** Remember to use `<![CDATA [...]]>` element for non-problem parsing.)

Well and this is it! Now you know how to basically use the `<transformation>` element. See you next time.