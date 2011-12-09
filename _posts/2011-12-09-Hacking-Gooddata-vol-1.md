---
title: Keboola Academy - hacking GoodData vol 01
excerpt: The article describes how to use report execution and exporter API and how to integrate it.
layout: post
---

# {{ page.title }}

_by [Keboola](http://www.keboola.com)_

Hi, welcome to Keboola Academy! 

We love playing around with the GoodData platform. Recently for our friends at OpenBrand.com, we implemented an "artificial intelligence" solution powered by the GoodData engine.
OpenBrand needed to analyze their user behavior in their Brand Management application, apply some logic to it and use results as input data for their recommendation engine.
The logic is quite complicated, so we let GoodData take care of that :-)

<p>
<center><img src="{{ site.root }}/images/posts/KB_appschema.jpeg" alt="App Schema"></center>
</p>

So, please allow us to share with you how we managed to integrate an application with the extraneous GoodData BI platform.  
It's a bit tricky, but just follow the steps in this article, and you can accomplish the same thing quite easily.

Firstly, for the purposes of this article, we need to assume that you already have a GoodData project loaded with data, and that you know the IDs (URIs) of the GoodData reports that you want to use.  Also note that you must be authenticated prior to each API call as described [here](http://developer.gooddata.com/api/auth.html).

So, to get the report results from GoodData to our external application is a two step process.

First, we need to create a fresh report execution by using the GoodData "Cross-Tabulation" API. To do this, simply send a POST request to

`https://secure.gooddata.com/gdc/xtab2/executor3`

and add your report URI as a parameter.

GoodData should respond with a "200 Created" code and return a URI object.  Here is a sample request and response pair:


`POST https://secure.gooddata.com/gdc/xtab2/executor3`

`Accept: application/json`  
`Content-Type: multipart/form-data`  

`reportURI="/gdc/md/{PID}/obj/{report_ID}"`


Example result:
{% highlight ruby %}
{
     "reportResult2" : {
         ...
     
          "meta" : {
         ...
               "uri" : "/gdc/md/{PID}/obj/{report_result_ID}"
         ...
                   }
     }
}
{% endhighlight %}

Now that we have the up to date report results URI, we can send another POST method to the GoodData "Export" API (https://secure.gooddata.com/gdc/exporter/executor) to retrieve the raw data.

For example:

Request:

`POST https://secure.gooddata.com/gdc/exporter/executor`  

`Accept: application/json`  
`Content-Type: multipart/form-data`

`uri="/gdc/md/{PID}/obj/{report_result_ID}"`  
`format="csv"`

Response:
{% highlight ruby %}
{   
     "uri" : "/gdc/exporter/result/{PID}/{ID_of_raw_data}"
}
{% endhighlight %}

The response contains the URI that holds our raw data, and we can retrieve it with a GET request.
Note that if the response status is "202 Accepted", the data is not yet available.  In this case, wait a few seconds and try again.  
When the data is ready, we receive a response with status "200 OK" and the response body contain the raw data we want.

Request:

`GET /gdc/exporter/result/{PID}/{ID_of_raw_data}`

Good Luck!  
@Keboola  
<p>
<img src="{{ site.root }}/images/posts/KB_keboolaAcademy.png" alt="Keboola Academy" class="noborder">
</p>