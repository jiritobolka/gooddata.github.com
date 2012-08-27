---
title: GoodData Project specific FTP Access
layout: documentation
stub: docs-ftp
---

# {{ page.title }}

Following documentation describes the GoodData **project specific** data storage. Use it to send us your data files for your project.

## What is GoodData Storage?

GoodData Storage is cloud storage for your data before executing ETL processes on it.
 
## What do I need to use GoodData Storage?

- You need to have your GoodData credentials (username and password)  
- You need to be an admin for the relevant GoodData project  
- You need to have the Id of the relevant GoodData project  
 
## What files can I upload to GoodData Storage?

- Valid row-based CSV
- Well formed XML (adding a schema is helpful)

## How can I access GoodData Storage?

You can access GoodData Storage using **WebDAV** protocol. You can access through command-line utilities, FTP client software (i.e. Cyberduck), or Finder (on Mac OS X).  

## Credentials

**SERVER:** secure-di.gooddata.com  
**USERNAME:** your GoodData username  
**PASSWORD:** your GoodData password  
**PROJECT:** Id of your GoodData project (will be provided by your GoodData implementation team)  

**Note:** If you don't have your GoodData account yet, register yourself [here](https://secure.gooddata.com/registration.html).

## Instructions

### 1. Cyberduck with WebDAV

Using Cyberduck client to connect via WebDAV:

<p>
<center><img src="{{ site.root }}/images/docs/webdav.png" alt="Cyberduck-WebDAV" class="no-border"></center>
</p>

### 2. Finder

Open Finder Window
Select Go from menu, then Connect to Server 
Fill in your server address (https://secure-di.gooddata.com/project-uploads/PROJECT)

<p>
<center><img src="{{ site.root }}/images/docs/ftp3.png" alt="OSX-WebDAV" class="no-border"></center>
</p>

And click Connect. Use your GoodData email and password to authenticate and you should be in.

## How to upload your files:

Create a folder called “waiting” so we know these files are waiting to be loaded. Once a file is loaded, we will move it to the “loaded” folder.

To be sure you are operating within GoodData best practices there are only 2 simple rules to follow:

1. upload your files as a single zipped file so we know we have all data to start the transformation

2. the name of the file is (name)_(timestamp).zip so we can distinguish the files loaded in different days

**Note:** When your file is zipped, we cannot unzip it until it is all uploaded. This ensures we don’t start transforming your files before you finish your uploading. You also save the bandwidth and your time!

