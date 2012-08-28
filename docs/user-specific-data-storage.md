---
title: GoodData User specific FTP Access
layout: documentation
stub: docs-ftp-user
---

# {{ page.title }}

Following documentation describes the GoodData **user specific** data storage. Using this approach, you are accessing the storage that is user-based, not project-based. User that has admin access to your project cannot see the data if you upload it to the **user specific** FTP storage. Here you can upload the data, that will be uploaded using the Data Loading API.

`https://secure.gooddata.com/gdc/md/{project-id}/etl/pull`

## Credentials

**SERVER:** secure-di.gooddata.com/uploads/  
**USERNAME:** your GoodData username  
**PASSWORD:** your GoodData password  

**Note:** If you don't have your GoodData account yet, register yourself [here](https://secure.gooddata.com/registration.html).

## How to connect

Using Cyberduck client to connect via WebDAV:

<p>
<center><img src="{{ site.root }}/images/docs/user-specific-storage.png" alt="User Storage" class="no-border"></center>
</p>

