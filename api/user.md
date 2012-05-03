---
title: User related resources in GoodData
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-user
---

# Create User 
<br />
## Description

To provision user to project you need to first provision new user to domain. You need to have your own domain. If you don't have your domain, but need one, please contact our [Support](http://support.gooddata.com).

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/account/domains/YOUR_DOMAIN/users</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create a new project:

<pre>
{
 "accountSetting":{
    "login": "user@login.com",
    "password":"PASSWORD",
    "verifyPassword":" PASSWORD ",
    "firstName":"FirstName",
    "lastName":"LastName",
    "timezone":"TIMEZONE|NULL",
    "country":"COUNTRY",
    "phoneNumber":"NUMBER",
    "ssoProvider":"SSO-PROVIDER"
 }
}
</pre>


##Response

201 Created HTTP Status + URI of created User:

<pre>
{
"uri" : "/gdc/account/profile/USER_ID"
}
</pre>

-----

# Add User to Project
<br />
## Description

Resource for provision user to the specific Project.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/projects/PROJECT_ID/users</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create a new project:

<pre>
{ "user" : {
     "content" : {
           "status":"ENABLED",
           "userRoles":["/gdc/projects/PROJECT_ID/roles/ROLE_ID"]
                 },
     "links"   : {
           "self":"/gdc/account/profile/USER_ID"
                }
    }
}
</pre>

##Response

200 OK HTTP Status + following JSON formatted result:  

<pre>
{"projectUsersUpdateResult":{
    "successful":["/gdc/account/profile/PROFILE_ID"],
    "failed":[]}
}
</pre>

-----

# Disable / Enable User in Project 
<br />
## Description

Resource for Disabling or Enabling Users in given Project.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/projects/PROJECT_ID/users</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create a new project:

<pre>
{
    "users": [
        {
            "user": {
                "content": {
                    "status": "DISABLED"
                },
                "links": {
                    "self": "/gdc/account/profile/USER-ID"
                }
            }
        }
    ]
}
</pre>

##Response

200 OK HTTP Status + following JSON formatted result:  

<pre>
{"projectUsersUpdateResult":{
    "successful":["/gdc/account/profile/PROFILE_ID"],
    "failed":[]}
}
</pre>

----- 

# List all Domain Users
<br />
## Description

The domain admin can list all users that exist in given domain. 

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/account/domains/DOMAIN_NAME/users</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Empty

##Response

200 OK HTTP Status + JSON formatted list of all users in domain

-----

# Delete User
<br />
## Description

Resource for deleting the specified user.

##Request

HTTP Request

**DELETE**  
<pre>https://secure.gooddata.com/gdc/account/profile/USER_ID</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Empty

##Response

200 OK HTTP Status

