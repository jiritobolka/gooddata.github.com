---
title: Developer News - Release 68
excerpt: See what we have and what is planned for the R68 and next releases.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

This Saturday, the Release 68 will be out and we’ve got some interesting topics, features and important information we’d like to share with you. Performance is something that we are constantly working on improving, because it is at the top of our priority list and it’s also necessary for creating awesome analytical solutions and Apps on the top of the GoodData Platform. As such, have a look at the following performance enhancements that we have in store for you in our latest release:

## PostgreSQL

We are migrating our platform to PostgreSQL. The migration is not complete yet but it will result in much faster platform performance. If you’d like to try it out to see how PostgreSQL projects work, you can do so in our “gray pages” or via the REST API.

In gray pages, we have a button for this option - take a look at the screenshot below:

`https://secure.gooddata.com/gdc/projects/`

<p>
<center><img src="{{ site.root }}/images/posts/PostgreSQL.png" alt="PostgreSQL Test"></center>
</p>

If you want to try it out via the REST API, use the [Project resource](http://developer.gooddata.com/api/projects-create.html) with the following payload:

<pre>
{
   "project" : {
      "content" : {
         "guidedNavigation": 1,
         "driver" : "Pg"
      },
      "meta" : {
         "summary" : "PG Test",
         "title" : "Test Project on PG"
      }
   }
}
</pre>

## The CSV uploader

<p>
<center><img src="{{ site.root }}/images/posts/CSVLoad.png" width="800" alt="CSV Load"></center>
</p>

<p>
<center><img src="{{ site.root }}/images/posts/CSVLoadUI.png" alt="CSV Load"></center>
</p>

During the next few releases, the current CSV functionality will be disabled. This feature is not compatible with the uploads that are made using the CL Tool. However,  you’ll still be able to use the [Python](http://support.gooddata.com/entries/110081-python-automated-upload-script-updated-08-25-2011) and [Java](http://support.gooddata.com/entries/95001-java-api-example-code) tools that are on the top of the old CSV loading API. If you are loading your data this way, we highly recommend to change the way you load your data because this old API will no longer be supported and we will completely stop supporting this functionality in the upcoming releases.

If you are interested in other features that are included in the Release 68, see the [Release Notes](http://support.gooddata.com/entries/21112747-release-68-notes-saturday-march-10-2012). We hope that you will be more than satisfied with the performance after this release. Let us know!