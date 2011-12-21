---
title: Manage Project's LDM
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-ldm
---

# Manage Logical Data Model
<br />
## Description

The resource for managing the Logical Data Model using [MAQL DDL](http://developer.gooddata.com/api/maql-ddl.html).

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/ldm/manage</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload is usage example:

<pre>
{
   "manage" : {
      "maql" : "CREATE ATTRIBTE {my_attribute}"
   }
}
</pre>


##Response

200 OK HTTP Status

##Code example

<pre>
$ curl --cookie cookies.txt \  --data-binary @- \  --header 'Accept: application/json' \  --header 'Content-Type: application/json' \ https://secure.gooddata.com/gdc/md/PROJECT_ID/ldm/manage EOR
{ "manage" : {  "maql" : "CREATE ATTRIBTE {my_attribute}"  }} EOR
</pre>

-----

# Project Validation
<br />
## Description

The resource for validating project after model changes (LDM/PDM).

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/validate/</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload is usage example, you can choose from what do you want to validate:

<pre>
{ "validateProject" : [ "IO", "LDM", "PDM" ] }
</pre>


##Response

201 Created HTT Status + URI of created Project:

<pre>
{"uri" : "/gdc/md/PROJECT_ID/validate/TASK_ID"}
</pre>

##Code example

<pre>
$ curl --cookie cookies.txt \  --data-binary @- \  --header 'Accept: application/yaml' \  --header 'Content-Type: application/json' \ https://secure.gooddata.com/gdc/md/PROJECT_ID/validate EOR
{ "validateProject" : [ "LDM", "PDM" ] } EOR
</pre>