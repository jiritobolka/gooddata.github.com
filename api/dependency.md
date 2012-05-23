---
title: Dependency API
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-dependency
---

# GET all objects that are used by specific object
<br />
## Description

This API can be used to GET all objects that are used by specific object such as dashboard, report etc. 

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/using/OBJECT_ID</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

No Request Payload required.

##Response

200 OK

<pre>
{
   "using" : {
      "edges" : [
         {
            "to" : 5,
            "from" : 38
         },
         {
            "to" : 49,
            "from" : 5
         },      
    ...

],
     "nodes" : [
	{
           "link" : "/gdc/md/j41cf2ph664i24r06zvj4f8rcpwoc7z5/obj/3439",
           "author" : "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d",
           "created" : "2011-12-22 11:04:45",
           "deprecated" : "0",
           "summary" : "",
           "updated" : "2011-12-22 11:04:46",
           "title" : "Department Salaries - Total",
           "category" : "report",
           "contributor" : "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d"
         },
{
           "link" : "/gdc/md/j41cf2ph664i24r06zvj4f8rcpwoc7z5/obj/3439",
           "author" : "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d",
           "created" : "2011-12-22 11:04:45",
           "deprecated" : "0",
           "summary" : "",
           "updated" : "2011-12-22 11:04:46",
           "title" : "Department Salaries - Total",
           "category" : "report",
           "contributor" : "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d"
         },
    ...
    ...
]
     }
}

</pre>

-----
