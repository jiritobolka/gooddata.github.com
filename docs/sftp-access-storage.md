---
title: GoodData Project Secondary Access options
layout: documentation
stub: docs-ftp
---

# {{ page.title }}

You can also use SFTP and FTPS access as described below.

## Credentials

**SERVER:** secure-di.gooddata.com  
**USERNAME:** your GoodData username  
**PASSWORD:** your GoodData password  
**PROJECT:** Id of your GoodData project (will be provided by your GoodData implementation team)

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


### 2. Using Cyberduck client to connect via SFTP:

<p>
<center><img src="{{ site.root }}/images/docs/ftp1.png" alt="Cyberduck-SFTP" class="no-border"></center>
</p>

### 3. Using Cyberduck client to connect via FTPS:

<p>
<center><img src="{{ site.root }}/images/docs/ftp2.png" alt="Cyberduck-FTPS" class="no-border"></center>
</p>

