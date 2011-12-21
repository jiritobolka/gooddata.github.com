---
title: Metadata API resources in GoodData
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: metadata
---

# Export partial Metadata 
<br />
## Description

The resource for exporting selected metadata with all dependencies.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/maintenance/partialmdexport</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

<pre>
{
    "partialMDExport": {
        "uris": [
            "/gdc/md/PROJECT_ID/obj/OBJECT_ID"
        ]
    }
}
</pre>

##Response

200 OK HTTP Status + Metadata artifact that contains token and URI for task polling:

<pre>
{
    "partialMDArtifact": {
        "status": {
            "uri": "/gdc/md/PROJECT_ID/tasks/TASK_ID/status"
        },
        "token": "TOKEN_STRING"
    }
}
</pre>

-----

# Import partial Metadata
<br />
## Description

The resource for importing selected metadata based on the generated token.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/maintenance/partialmdimport</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

<pre>
{ 
"partialMDImport" : {
  "token" : "TOKEN_STRING",
   "overwriteNewer" : "BOOLEAN"
   "updateLDMObjects" : "BOOLEAN"
  }
}
</pre>

##Response

200 OK HTTP Status + URI of the async process status resource for polling

<pre>
{
"uri" : "/gdc/md/PROJECT_ID/etltask/TASK_ID"
}
</pre>