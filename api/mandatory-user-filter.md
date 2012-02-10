---
title: Mandatory User Filters
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-muf
---

# Create new Mandatory User Filter
<br />
## Description

The API Resource for creating new Mandatory User Filter.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/obj</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload will create new filter object:

<pre>
{
    "userFilter": {
        "content": {
            "expression": "[/gdc/md/PROJECT_ID/obj/OBJECT_ID]=[/gdc/md/PROJECT_ID/obj/OBJECT_ID/elements?id=ELEMENT_ID]"
        },
        "meta": {
            "category": "userFilter",
            "title": "User Filter Name"
        }
    }
}
</pre>


##Response

200 OK HTTP Status

-----

# Assign Filter to User
<br />
## Description

The API Resource for assigning the Mandatory User Filter to a specific user.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/userfilters</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload will create new filter object:

<pre>
{ 
"userFilters": {
        "items": [
            {
                "user": "/gdc/account/profile/USER_ID",
                "userFilters": [
                    "/gdc/md/PROJECT_ID/obj/USER_FILTER_OBJECT_ID"
                ]
            }
        ]
    }
}
</pre>


##Response

200 OK HTTP Status and following JSON with information about records updated:

<pre>
{
  "userFiltersUpdateResult": {
      "failed": [],
      "successful": [
           "/gdc/account/profile/PROFILE_ID"
        ]
    }
}
</pre>

-----

# Get a List of User Filters
<br />
## Description

The API Resource for listing all existing Mandatory User Filters.

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/query/userfilters</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

No body is needed.

##Response

200 OK HTTP Status and following JSON with the list of Mandatory User Filters:

<pre>
{
    "query": {
        "entries": [
            {
                "link": "/gdc/md/PROJECT_ID/obj/FILTER_OBJECT_ID",
                "author": "/gdc/account/profile/USER_ID",
                "tags": "",
                "created": "2012-01-16 11:08:13",
                "deprecated": "0",
                "summary": "",
                "title": "User Filter Name",
                "category": "userFilter",
                "updated": "2012-01-16 11:08:13",
                "contributor": "/gdc/account/profile/USER_ID"
            }
        ],
        "meta": {
            "summary": "Metadata Query Resources for project 'PROJECT_ID'",
            "title": "List of userfilters",
            "category": "query"
        }
    }
}
</pre>

