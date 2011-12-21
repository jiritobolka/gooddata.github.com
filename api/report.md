---
title: Report API resources
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: report
---

# List of Reports
<br />
## Description

This resource gives you a list of all reports that are in given project.

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/query/reports</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Empty

##Response

200 OK HTTP Status + list of report

<pre>
{
    "query": {
        "entries": [
            {
                "link": "/gdc/md/PROJECT_ID/obj/OBJECT_ID",
                "author": "/gdc/account/profile/USER_ID",
                "tags": "",
                "created": "2011-11-23 15:34:18",
                "deprecated": "0",
                "summary": "",
                "title": "Report Title",
                "category": "report",
                "updated": "2011-11-23 15:41:44",
                "contributor": "/gdc/account/profile/USER_ID"
            }],
        "meta": {
            "summary": "Metadata Query Resources for project 'PROJECT_ID'",
            "title": "List of reports",
            "category": "query"
        }
    }
}	
</pre>
------

# Execute Report
<br />
## Description

Using this resource you can call xtab executor to compute give report definition.
##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/xtab2/executor3</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to execute Report Definition:

<pre>
{
    "report_req": {
        "reportDefinition": "/gdc/md/PROJECT_ID/obj/OBJECT_ID"
    }
}
</pre>

##Response

201 Created HTTP Status + Report Result JSON from which you can get the result URI:

<pre>
{
    "reportResult2": {
        ...
        ...
        ...
        "meta": {
            "author": "/gdc/account/profile/USER_ID",
            "uri": "/gdc/md/PROJECT_ID/obj/RESULT_OBJECT_ID",
            "tags": "",
            "created": "2011-12-20 15:23:20",
            "identifier": "IDENTIFIER",
            "deprecated": "0",
            "summary": "",
            "title": "TITLE",
            "category": "reportResult2",
            "updated": "2011-12-20 15:23:20",
            "contributor": "/gdc/account/profile/USER_ID"
        }
    }
}
</pre>

------

# Export Report
<br />
## Description

Export Report resource allows you to export Report to specified format such as CSV, PDF, XLS and PNG.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/exporter/executor</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to export given Report:

<pre>
{
    "result_req": {
        "report":"/gdc/md/PROJECT_ID/obj/OBJECT_ID",
        "format":"csv"
    }
}
</pre>

**report** = Report Result URI returned by previous Execute Report resource  
**format** = Export format (PDF | CSV | PNG | XLS)

##Response

201 OK HTTP Status + Export result resource URI, that you can GET to download exported report:

<pre>
{
"uri":"/gdc/exporter/result/PROJECT_ID/RESULT_ID"
}
</pre>