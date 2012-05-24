---
title: Identifiers API
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-identifiers
---

# Transform Identifier to URI 
<br />
## Description

The metadata objects are uniquely identified by the URI and Identifier. You can use this API to transform Identifiers to URI or vice versa. Identifiers doesn't change when you clone project from master to child.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/identifiers</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create a new project:

<pre>
{
    "identifierToUri": [
        "aavXZuyygoTi"
    ]
}
</pre>


##Response

200 OK and following array with identifiers - uri pairs:

<pre>
{
  "identifiers" : [
    {
      "identifier" : "aavXZuyygoTi",
      "uri" : "/gdc/md/PROJECT_ID/obj/3439"
    }
  ]
}
</pre>

-----

# Transform URI to Identifier
<br />
## Description

This is the vice versa. If you know the URI and need identifier, use this API request.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/identifiers</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create a new project:

<pre>
{
    "uriToIdentifier": [
        "/gdc/md/PROJECT_ID/obj/3439"
    ]
}
</pre>


##Response

200 OK and following array with identifiers - uri pairs:

<pre>
{
  "identifiers" : [
    {
      "identifier" : "aavXZuyygoTi",
      "uri" : "/gdc/md/PROJECT_ID/obj/3439"
    }
  ]
}
</pre>