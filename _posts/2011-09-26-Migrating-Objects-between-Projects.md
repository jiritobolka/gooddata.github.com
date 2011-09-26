---
title: Migrating Selected Objects between Projects
excerpt: This article shows you how to easily migrate selected objects from one project to other.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Hi there! Do you have multiple projects based on one project template or multiple projects cloned from one master project? Do you dream of a simple way how to copy new metrics or reports between projects?

Selected object migration is a new feature that has been implemented in GoodData since our latest release which was Release 60. So this is the way how to start!

## Project Cloning

You probably know that it is possible to clone (export/import) the whole GoodData project. If not, find out more about [how to clone project](http://developer.gooddata.com/blog/2011/06/06/project-cloning/) in our previous blogpost.

## Export/Import Selected Objects

First of all, before we start migrating objects, keep in mind a few things.

1. Every object has its unique uri.
2. Projects must have the same logical data model if you want to migrate objects between them.
3. Migration works with metrics, reports and dashboards.

Imagine that you have a project template and several child projects (projects based on that template) that
you want to populate with new reports or metrics or dashboards. Sounds simple enough, doesn’t it? Let’s see how you can do it!

Here's a simple example. We created two HR projects (based on our well known [CL Tool example](http://developer.gooddata.com/gooddata-cl/examples/hr/), with the same LDM). Let’s say the first one is a sandbox project where we want to play around with metrics, prepare reports etc. The second one is customer’s project where we want to copy only objects (reports, metrics, etc.) that are prepared for the customer.

What we are going to do is to prepare a nice report in our “master” project and then we will copy this report to the child HR Demo Copy project. Follow this example and you'll know how to do it via the so called grey pages and also with the CL Tool!

We will skip the report creation part (you can read more about creating reports [here](http://developer.gooddata.com/blog/2011/08/17/how-to-create-project-in-gooddata/)) and will continue on with exporting. As you can see below, we’ve created two reports in the HR project (which is our sandbox) and we've decided that the Total Payment by Quarter report is ready and we want to copy it to the HR Demo Copy project.

<p>
<center><img src="{{ site.root }}/images/posts/migrating-metadata/2.png" alt="Reports"></center>
</p>

As you can see below, the HR Demo Copy is empty.

<p>
<center><img src="{{ site.root }}/images/posts/migrating-metadata/4.png" alt="New project"></center>
</p>

## Exporting objects

Our report is prepared and now we need to export it from the HR project.

We have several options how to export reports (or dashboards, metrics) from the project. The first option is to use the newly implemented CL Tool commands. The second option is to use our grey pages. Firstly, let’s see how to do it with CL Tool:

`UseProject(fileName="...");`  
`ExportMetadataObjects(tokenFile="...", objectIDs="...");`

**Note:** This functionality is available in the CL Tool 1.2.40 or higher.

This command exports metadata objects with all of its dependencies. The `tokenFile` is a file where the import token will be stored (you'll need it!). In `objectIDs` you will paste the comma separated list of the metadata object IDs. The Object ID is a number which is located on the end of i.e. report URL, as you will see below.

Remember that before the `ExportMetadataObjects` you must use the `UseProject` or the `OpenProject` command to open the source/master project.

If you are not familiar with the CL tool, choose the second option. You will need to go to the grey pages partial metadata export section which is located in the following url:

`https://secure.gooddata.com/gdc/md/<project-id>/maintenance/partial-md-export`

Here you can select the metadata objects that you would like to export based on it's uri.

<p>
<center><img src="{{ site.root }}/images/posts/migrating-metadata/8.png" alt="Object uri"></center>
</p>

Wait a second! Where can we find the object uri? It can be found in the url address. For example, if you copy the end of the open report url address, you will see something like this:

`/gdc/md/<project-id>/obj/<object-id>`

The object metadata information is stored in this url. 

**Remember:** When you use CL Tool for migration, you have to specify `<object-id>`, but when you want to do the same via grey pages you must specify the uri, which is the part of the url as you can see above.

In this example, the report metadata contains the author, title, uri etc. See the metadata page below, in our example ID of the exported object is :

<p>
<center><img src="{{ site.root }}/images/posts/migrating-metadata/5.png" alt="Export"></center>
</p>

Now, just simply paste the uri (you can paste multiple uris, one on each line) into the text input field and submit the request. The task that is invoked by you will generate an import token. You'll need to store it somewhere in order to import the report.

<p>
<center><img src="{{ site.root }}/images/posts/migrating-metadata/6.png" alt="Export"></center>
</p>

## Importing objects

It’s time to import our exported objects. Let's see how it can be done with the CL Tool and with the grey pages.
With CL Tool, use the `ImportMetadataObjects` command:

`UseProject(fileName="...");`  
`ImportMetadataObjects(tokenFile="...", overwrite="<true|false>", updateLDM="<true|false>");`

The command imports metadata objects from the token. The `tokenFile` is the file which was generated during the export. The import command has two options: `updateLDM` - if true, the attributes, facts names and descriptions are updated. The second option is `overwrite` - if true, the existing metadata are overwritten. Currently only `overwrite` = true is supported.

Remember that you must call the `UseProject` or the `OpenProject` command before the ImportMetadataObjects to specify the destination where you want to import it.

If you don’t want to use the CL Tool for this purpose, you can use the grey pages. Go to the

`https://secure.gooddata.com/gdc/md/<project-id>/maintenance/partialmdimport/`

Here you paste the token that was generated during the export. (see the screenshot below)

<p>
<center><img src="{{ site.root }}/images/posts/migrating-metadata/7.png" alt="Export"></center>
</p>

After submitting, you'll see the link that takes you to the page with the import task status. Here you can see if the import was successful or if something went wrong. If the import was successful, you can log into the HR Demo Copy project, go to the Reports section and check if the report is there.

<p>
<center><img src="{{ site.root }}/images/posts/migrating-metadata/9.png" alt="Export"></center>
</p>

As you can see the report was successfully migrated from one project to another.

So, that’s the selected object migration. Isn’t it easy?! Do you like it? Let us know what you think!