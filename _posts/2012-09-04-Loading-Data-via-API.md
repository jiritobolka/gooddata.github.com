---
title: Loading Data via API
excerpt: How to load API using REST API resource
layout: post
---

# {{ page.title }}

Let’s take a closer look at how you can use the GoodData API for loading your data into your project. If you already know how to create new [Analytical Project](http://developer.gooddata.com/blog/2011/07/26/MAQL-description/) directly using MAQL or the CL Tool, you will definitely be interested the next step, that is, to load the data. In order to load the data via the API, it’s necessary to follow the steps below: 

## Prepare the Data and Manifest

To upload the data successfully, you need to create the so-called SLI manifests for each dataset. These manifests map the data columns to the data model. The SLI manifests are automatically generated by the Platform. The easiest way how to obtain it, is from the following URL; using this simple GET request:

`https://secure.gooddata.com/gdc/md/{project-id}/ldm/singleloadinterface/{dataset}/manifest/`

and save the response content as `upload_info.json`. See the example from the **Quotes Demo** Project below. 

<pre>
{ "dataSetSLIManifest": {
  "parts":   [
        {
      "columnName": "id",
      "mode": "FULL",
      "populates": ["label.quotes.id"],
      "referenceKey": 1
    },
        {
      "columnName": "company",
      "mode": "FULL",
      "populates": ["label.quotes.symbol.company"]
    },
        {
      "columnName": "symbol",
      "mode": "FULL",
      "populates": ["label.quotes.symbol"],
      "referenceKey": 1
    },
        {
      "columnName": "sector",
      "mode": "FULL",
      "populates": ["label.quotes.sector"],
      "referenceKey": 1
    },
        {
      "columnName": "industry",
      "mode": "FULL",
      "populates": ["label.quotes.industry"],
      "referenceKey": 1
    },
        {
      "columnName": "market",
      "mode": "FULL",
      "populates": ["label.quotes.market"],
      "referenceKey": 1
    },
        {
      "columnName": "quote_date",
      "mode": "FULL",
      "populates": ["quote.date.mdyy"],
      "constraints": {"date": "yyyy-MM-dd"},
      "referenceKey": 1
    },
        {
      "columnName": "open_price",
      "mode": "FULL",
      "populates": ["fact.quotes.open_price"]
    },
        {
      "columnName": "high_price",
      "mode": "FULL",
      "populates": ["fact.quotes.high_price"]
    },
        {
      "columnName": "low_price",
      "mode": "FULL",
      "populates": ["fact.quotes.low_price"]
    },
        {
      "columnName": "close_price",
      "mode": "FULL",
      "populates": ["fact.quotes.close_price"]
    },
        {
      "columnName": "volume",
      "mode": "FULL",
      "populates": ["fact.quotes.volume"]
    },
        {
      "columnName": "adjusted_close_price",
      "mode": "FULL",
      "populates": ["fact.quotes.adjusted_close_price"]
    },
        {
      "columnName": "quote_date_dt",
      "mode": "FULL",
      "populates": ["dt.quotes.quote_date"]
    }
  ],
  "file": "data.csv",
  "dataSet": "dataset.quotes",
  "csvParams":   {
    "quoteChar": "\"",
    "escapeChar": "\"",
    "separatorChar": ",",
    "endOfLine": "\n"
  }
}}
</pre>

Prepare the CSV file with the data you want to upload and include the column header. Remember that columns in manifest and CSV file **must have the same name and order**. It also must fit the SLI manifest that you've previously downloaded. See the example CSV data file below

<p>
<center><img src="{{ site.root }}/images/posts/quotes-csv.png" alt="Sample Data" width="650"></center>
</p>

## Date Facts in GoodData Project

In GoodData, dates are also represented as facts. What does this mean for loading? This means you need to prepare your data file to fit this structure. 

If you are loading the GoodData Project using the CL Tool, you’ll be able to notice that every dataset that is connected to date dimension includes also date Fact. Thanks to this you can easily use formulas like “Today - 1” in your reports. As you can see below date dimension fact is calculated as number of days since 1900-01-01.

| date | id |  
+---------------+----+  
| 1900-01-01 | 1 |  
| 1900-01-02 | 2 |  
| 1900-01-03 | 3 |  
| 1900-01-04 | 4 |  
| 1900-01-05 | 5 |  
| 1900-01-06 | 6 |  

As you can see, the date id is the number of days between 1/1/1900 and today (including today, so it is +1). So before you'll start the data loading process, remember to transform the data to this specific form.

When you have the CSV file and SLI Manifest prepared, compress these two files to the upload.zip archive.

## Transfer Data to WebDAV

Put the archive to the WebDav user specific storage: 

a) Firstly, create new directory on WebDav (this is not mandatory but it is better for orientation):

<pre>
curl -i --insecure -X MKCOL -v https://username%40email.com:PASSSWORD@secure-di.gooddata.com/uploads/new-directory/
</pre>

b) Put the compressed files (csv + manifest)

In the Second step, you need to **PUT** the archive that you've previously created to the WebDav storage. See the curl example below, or use any of WebDav clients to access and transfer the data package:

<pre>
curl -i --insecure -X PUT --data-binary @upload.zip -v https://user.name%40gooddata.com:PASSWORD@secure-di.gooddata.com/uploads/new-directory/upload.zip
</pre>

## Run the Load task in the API 

**POST**  
`https://secure.gooddata.com/gdc/md/{project-id}/etl/pull`

Header: Content-Type: application/json  
Body: 
<pre>
{"pullIntegration":"new-directory"}
</pre>

The data loading should start immediately. You just need to poll the resource where you can get the asynchronous loading status

**GET**  
`https://secure.gooddata.com/gdc/md/{project-id}/etl/task/{etl-task-id}`  

Header: Content-Type: application/json  

If the returning status is OK, you can go directly to your Project and check the data. The GoodData Upload API is also documented on our [API Documentation Portal](http://docs.gooddata.apiary.io/#dataupload). Let us know how it works! 

