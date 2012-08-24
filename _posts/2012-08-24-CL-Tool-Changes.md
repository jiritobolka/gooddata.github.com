---
title: CL Tool 1.2.58 Changes
excerpt: CL Tool Release update. Summaries all changes and new features.
layout: post
---

# {{ page.title }}

We would like to tell you that we released a new CL tool version `1.2.58`. This new version contains one new feature:

* You are able to use two new parameters with the Attribute column type in XML configuration files. Since the version 1.2.58 you can directly specify `LABEL` that the `ATTRIBUTE` will be sorted by and also specify sorting type (ASC | DESC).

Let me show you quick example from the GoodData Quotes Demo Project. What you want to do is to sort the `SYMBOL` column (this is Attribute type) by its Label column `COMPANY` 

{% highlight xml %}
...
...
<column>
           <name>COMPANY</name>
           <title>Company</title>
           <ldmType>LABEL</ldmType>
           <reference>SYMBOL</reference>
           <folder>Quotes</folder>
</column>
<column>
           <name>SYMBOL</name>
           <title>Symbol</title>
           <ldmType>ATTRIBUTE</ldmType>
           <sortLabel>COMPANY</sortLabel>
           <sortOrder>DESC</sortOrder>
           <folder>Quotes</folder>
</column>
...
...
{% endhighlight %}

As you can see, the process is very simple and straightforward. Let us know how it works for you and [download the latest CL Tool from Github now](https://github.com/gooddata/GoodData-CL/downloads)!
