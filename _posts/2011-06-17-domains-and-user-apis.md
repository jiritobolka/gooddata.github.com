---
title: New User APIs 
excerpt: We have just released the new User APIs
layout: post
---

# {{ page.title }}
_by ZD ([@zsvoboda](http://twitter.com/#!zsvoboda))_

The [CL Tool 1.2.30](https://github.com/gooddata/GoodData-CL/downloads) adds a new <code>CreateUser</code> command that allows you to programmatically create a new GoodData users. No registration forms, no confirmation e-mails. We can't obviously allow an ordinary Joe to start creating thousands of new GoodData users. This is why we came up with the concept of the GoodData domain. GoodData domain is identified by it's name (usually a company name of a GoodData partner). It is associated with an authorized GoodData account (username) that can create the new users in the domain. Initially the users can be only created. Later we will allow user modifications, association to a project etc.

You'll need to request a new domain from GoodData before you can use the new <code>CreateUser</code> command. <a href="mailto:support@gooddata.com">Let us know</a> if you need one. Then you can simply run the command from a CL Tool script:

<code>CreateUser(domain="...", username="...", password="...", firstName="...", lastName="...", company="...", phone="...", country="...", position="...", ssoProvider="...");</code> 

I think that the most of the command's parameters are self-explanatory. Just in case:

- domain - the GoodData users domain. The domain needs to be created by GoodData admins and associated with your GoodData account
- username   - the new user's username
- password   - the new user's password
- firstName   - the new user's first name
- lastName   - the new user's last name
- company   - (optional) the new user's company name
- phone   - (optional) the new user's phone
- country   - (optional) the new user's country (e.g. 'cz' or 'us;ca')
- position   - (optional) the new user's position
- ssoProvider - (optional) the new user's SSO provider (e.g. SALESFORCE)
- usersFile - (optional) writes the new user's URI to the specified file
- append - (optional) should the users file be appended (default is false)

There is obviously a nice REST API under the new command. Feel free to dig into the [CL tool source code](https://github.com/gooddata/GoodData-CL/blob/master/backend/src/main/java/com/gooddata/integration/rest/GdcRESTApiWrapper.java) to figure it out.
 