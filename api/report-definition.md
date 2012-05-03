---
title: Report Definitions API resources
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: report-definition
---

# List of Report Definitions
<br />
## Description

This resource gives you a list of all report definitions that are in given project. You can retrieve individual Report definition, update it and then create new one or modify existing Report

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/query/reportdefinition</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Empty

##Response

200 OK HTTP Status + list of Report Definition

<pre>
{
    "query": {
        "entries": [
            {
                "link": "/gdc/md/PROJECT_ID/obj/REPORT_DEFINITION_ID",
                "author": "/gdc/account/profile/USER_ID",
                "tags": "",
                "created": "2011-02-11 03:37:40",
                "deprecated": "0",
                "summary": "",
                "title": "Name of report definition",
                "category": "reportDefinition",
                "updated": "2011-02-11 03:37:40",
                "contributor": "/gdc/account/profile/1"
            },
            {
                "link": "/gdc/md/PROJECT_ID/obj/REPORT_DEFINITION_ID",
                "author": "/gdc/account/profile/USER_ID",
                "tags": "",
                "created": "2011-04-04 08:02:55",
                "deprecated": "0",
                "summary": "",
                "category": "reportDefinition",
                "title": "Name of report definition",
                "updated": "2011-04-04 08:02:55",
                "contributor": "/gdc/account/profile/1"
            }
	...
	...
	...
        ],
        "meta": {
            "summary": "Metadata Query Resources for project 'PROJECT_ID'",
            "title": "List of reportdefinition",
            "category": "query"
        }
    }
}
</pre>
------

# Retrieve Report Definition
<br />
## Description

This resource allows you to retrieve individual Report definition that you can update. Then create new Report using it.

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/obj/REPORT_DEFINITION_URI</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Empty

##Response

200 OK HTTP Status + JSON with Report Definition

<pre>
{
    "reportDefinition": {
        "content": {
            "grid": {
                "sort": {
                    "columns": [],
                    "rows": []
                },
                "columnWidths": [],
                "columns": [
                    "metricGroup"
                ],
                "metrics": [
                    {
                        "format": "$#,##0",
                        "alias": "",
                        "uri": "/gdc/md/PROJECT_ID/obj/OBJECT_ID"
                    }
                ],
                "rows": []
            },
            "oneNumber": {
                "labels": {}
            },
            "format": "oneNumber",
            "filters": []
        },
        "links": {
            "explain": "/gdc/md/PROJECT_ID/obj/19526/explain"
        },
        "meta": {
            "author": "/gdc/account/profile/USER_ID",
            "uri": "/gdc/md/PROJECT_ID/obj/19526",
            "tags": "",
            "created": "2011-04-02 20:11:43",
            "identifier": "aip3O54Wbyjd",
            "deprecated": "0",
            "summary": "",
            "title": "Report Definition Name",
            "category": "reportDefinition",
            "updated": "2011-04-02 20:11:43",
            "contributor": "/gdc/account/profile/USER_ID"
        }
    }
}
</pre>
------

# Create/Update Report Definition
<br />
## Description

Use this to create new metric or modify existing Report definition. You have to POST a metric definition to the resources below.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/obj</pre>

to create new metric

or

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/obj/REPORT_DEF_OBJECT_ID</pre>

to update existing metric

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

<pre>
{
    "reportDefinition": {
        "content": {
            "grid": {
                "sort": {
                    "columns": [],
                    "rows": []
                },
                "columnWidths": [],
                "columns": [
                    "metricGroup"
                ],
                "metrics": [
                    {
                        "format": "$#,##0",
                        "alias": "",
                        "uri": "/gdc/md/PROJECT_ID/obj/OBJECT_ID"
                    }
                ],
                "rows": []
            },
            "oneNumber": {
                "labels": {}
            },
            "format": "oneNumber",
            "filters": []
        },
        "links": {
            "explain": "/gdc/md/PROJECT_ID/obj/19526/explain"
        },
        "meta": {
            "author": "/gdc/account/profile/USER_ID",
            "uri": "/gdc/md/PROJECT_ID/obj/19526",
            "tags": "",
            "created": "2011-04-02 20:11:43",
            "identifier": "aip3O54Wbyjd",
            "deprecated": "0",
            "summary": "",
            "title": "Report Definition Name",
            "category": "reportDefinition",
            "updated": "2011-04-02 20:11:43",
            "contributor": "/gdc/account/profile/USER_ID"
        }
    }
}
</pre>


##Response

200 OK HTTP Status + URI of new created object / report definition

<pre>
{
"uri":"/gdc/md/PROJECT_ID/obj/NEW_OBJECT_ID"
}
</pre>