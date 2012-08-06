---
title: GoodData FTP Access
layout: documentation
stub: docs-ftp
---

# {{ page.title }}

<br />

For your convenience, we provide an access to the web storage, where you can put your data that will be loaded to your project in regular ETL process.

## Protocols

Protocols you can use:  
- SFTP  
- FTPS  
- WebDav  

## What to keep in mind

It is important to keep in mind that only people that are actually in the project can see or upload data. The user has to have the admin roles as well.

## Clients

You might have an appropriate client installed already. If not, there are plenty of options out there, see the [posibilities](http://en.wikipedia.org/wiki/Comparison_of_FTP_client_software) 

Many of our users use _Cyberduck_ (free, multi-platform).

## Credentials

**SERVER:** secure-di.gooddata.com  
**USERNAME:** your GoodData username  
**PASSWORD:** your GoodData password  
**PROJECT:** Id of your GoodData project (will be provided by your GoodData implementation team)  

**Note:** If you don't have your GoodData account yet, register yourself [here](https://secure.gooddata.com/registration.html).

## Instructions

### 1. Interactive command-line using sftp

connect to the server  
<code>
$ sftp PROJECT@USERNAME@SERVER
</code>  
provide your pass when asked  

copy file  
<code>
sftp> put file
</code>

exit interactive mode  
<code>
sftp> bye
</code>

**Note:** If you connect for the first time, you might get the following dialog:
The authenticity of host 'secure-di.gooddata.com (184.73.171.129)' can't be established.
RSA key fingerprint is 1d:2e:83:17:eb:73:f7:c8:5f:b1:e6:a9:c0:5d:ab:59.
Are you sure you want to continue connecting (yes/no)? 
You should answer yes.


### 2. Cyberduck for SFTP, FTPS, WebDAV

<p>
<center><img src="{{ site.root }}/images/docs/ftp1.png" alt="Cyberduck-SFTP" class="no-border"></center>
</p>

<p>
<center><img src="{{ site.root }}/images/docs/ftp2.png" alt="Cyberduck-FTPS" class="no-border"></center>
</p>

### 3. Finder
Open Finder Window
Select Go from menu, then Connect to Server 
Fill in your server address (https://secure-di.gooddata.com/project-uploads/PROJECT)


And click Connect. Use your GoodData email and password to authenticate and you should be in.

## How to upload your files:

Create a folder called “waiting” so we know these files are waiting to be loaded. Once a file is loaded, we will move it to the “loaded” folder.
To be sure you are operating within GoodData best practices there are only 2 simple rules to follow:

1. upload your files as a single zipped file so we know we have all data to start the transformation

2. the name of the file is (name)_(timestamp).zip so we can distinguish the files loaded in different days

**Note:** When your file is zipped, we cannot unzip it until it is all uploaded. This ensures we don’t start transforming your files before you finish your uploading. You also save the bandwidth and your time!


### What type of files can I upload?

- valid row-based CSV
- well formed XML (adding a schema is helpful)
