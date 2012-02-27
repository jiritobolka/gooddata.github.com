---
title: Metric API resources
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-metric
---

# List of Metrics
<br />
## Description

This resource gives you a list of all metrics that are in given project.

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/query/metrics</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Empty

##Response

200 OK HTTP Status + list of existing metrics

<pre>
{
    "query": {
        "entries": [
            {
                "link": "/gdc/md/PROJECT_ID/obj/METRIC_OBJECT_ID",
                "author": "/gdc/account/profile/USER_ID",
                "tags": "",
                "created": "2011-12-12 13:06:02",
                "deprecated": "0",
                "summary": "",
                "title": "Name of the metric",
                "category": "metric",
                "updated": "2011-12-12 13:09:03",
                "contributor": "/gdc/account/profile/19765"
            },
            {
                "link": "/gdc/md/PROJECT_ID/obj/METRIC_OBJECT_ID",
                "author": "/gdc/account/profile/USER_ID",
                "tags": "",
                "created": "2011-09-22 15:53:27",
                "deprecated": "0",
                "summary": "",
                "category": "metric",
                "title": "Name of the metric",
                "updated": "2011-12-12 13:06:00",
                "contributor": "/gdc/account/profile/19765"
            },
            {
                "link": "/gdc/md/PROJECT_ID/obj/METRIC_OBJECT_ID",
                "author": "/gdc/account/profile/USER_ID",
                "tags": "",
                "created": "2011-10-10 16:43:45",
                "deprecated": "0",
                "summary": "",
                "category": "metric",
                "title": "Name of the metric",
                "updated": "2012-02-20 16:23:09",
                "contributor": "/gdc/account/profile/USER_ID"
            }
        ],
        "meta": {
            "summary": "Metadata Query Resources for project 'PROJECT_ID'",
            "title": "List of metrics",
            "category": "query"
        }
    }
}
</pre>
------

# Retrieve Individual Metric 
<br />
## Description

Using this resource you can retrieve individual metric definition. That you can update, change expression or any other object definition and then use the next step, Create/Modify Metric.

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/obj/METRIC_ID</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

No body is required to send.

##Response

200 OK HTTP Status + JSON Metric definition:

<pre>
{
    "metric": {
        "content": {
            "folders": [
                "/gdc/md/PROJECT_ID/obj/330"
            ],
            "objects": [
                {
                    "link": "/gdc/md/PROJECT_ID/obj/233",
                    "author": "/gdc/account/profile/USER_ID",
                    "tags": "",
                    "created": "2011-09-22 15:47:41",
                    "deprecated": "0",
                    "summary": "",
                    "title": "Payment",
                    "category": "fact",
                    "updated": "2011-09-22 15:47:41",
                    "contributor": "/gdc/account/profile/USER_ID"
                },
                {
                    "link": "/gdc/md/PROJECT_ID/obj/145",
                    "author": "/gdc/account/profile/USER_ID",
                    "tags": "date quarter year",
                    "created": "2011-09-22 15:47:35",
                    "deprecated": "0",
                    "summary": "Generic Quarter (Q1-Q4)",
                    "title": "Quarter (Payment)",
                    "category": "attribute",
                    "updated": "2011-09-22 15:47:39",
                    "contributor": "/gdc/account/profile/USER_ID"
                }
            ],
            "format": "#,##0.00",
            "tree": {
                "content": [
                    {
                        "content": [
                            {
                                "value": "SUM",
                                "content": [
                                    {
                                        "value": "/gdc/md/PROJECT_ID/obj/233",
                                        "position": {
                                            "column": 12,
                                            "line": 2
                                        },
                                        "type": "fact object"
                                    }
                                ],
                                "position": {
                                    "column": 8,
                                    "line": 2
                                },
                                "type": "function"
                            }
                        ],
                        "position": {
                            "column": 8,
                            "line": 2
                        },
                        "type": "expression"
                    },
                    {
                        "content": [
                            {
                                "content": [
                                    {
                                        "value": "/gdc/md/PROJECT_ID/obj/145",
                                        "position": {
                                            "column": 70,
                                            "line": 2
                                        },
                                        "type": "attribute object"
                                    },
                                    {
                                        "value": "Previous",
                                        "position": {
                                            "column": 122,
                                            "line": 2
                                        },
                                        "type": "identifier"
                                    }
                                ],
                                "position": {
                                    "column": 121,
                                    "line": 2
                                },
                                "type": "="
                            }
                        ],
                        "position": {
                            "column": 64,
                            "line": 2
                        },
                        "type": "where"
                    }
                ],
                "position": {
                    "column": 1,
                    "line": 2
                },
                "type": "metric"
            },
            "expression": "SELECT SUM([/gdc/md/PROJECT_ID/obj/233]) WHERE [/gdc/md/PROJECT_ID/obj/145] ={Previous}"
        },
        "meta": {
            "author": "/gdc/account/profile/USER_ID",
            "uri": "/gdc/md/PROJECT_ID/obj/331",
            "tags": "",
            "created": "2011-10-10 16:43:45",
            "identifier": "agF6gXSZeEK9",
            "deprecated": "0",
            "summary": "",
            "title": "Metrika",
            "category": "metric",
            "updated": "2012-02-20 16:23:09",
            "contributor": "/gdc/account/profile/USER_ID"
        }
    }
}
</pre>

------

# Create/Update Metric
<br />
## Description

Use this to create new metric or modify existing metric definition. You have to POST a metric definition to the resources below.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/obj</pre>

to create new metric

or

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/obj/METRIC_OBJECT_ID</pre>

to update existing metric

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

<pre>
{
    "metric": {
        "content": {
            "folders": [
                "/gdc/md/PROJECT_ID/obj/330"
            ],
            "objects": [
                {
                    "link": "/gdc/md/PROJECT_ID/obj/233",
                    "author": "/gdc/account/profile/USER_ID",
                    "tags": "",
                    "created": "2011-09-22 15:47:41",
                    "deprecated": "0",
                    "summary": "",
                    "title": "Payment",
                    "category": "fact",
                    "updated": "2011-09-22 15:47:41",
                    "contributor": "/gdc/account/profile/USER_ID"
                },
                {
                    "link": "/gdc/md/PROJECT_ID/obj/145",
                    "author": "/gdc/account/profile/USER_ID",
                    "tags": "date quarter year",
                    "created": "2011-09-22 15:47:35",
                    "deprecated": "0",
                    "summary": "Generic Quarter (Q1-Q4)",
                    "title": "Quarter (Payment)",
                    "category": "attribute",
                    "updated": "2011-09-22 15:47:39",
                    "contributor": "/gdc/account/profile/USER_ID"
                }
            ],
            "format": "#,##0.00",
            "tree": {
                "content": [
                    {
                        "content": [
                            {
                                "value": "SUM",
                                "content": [
                                    {
                                        "value": "/gdc/md/PROJECT_ID/obj/233",
                                        "position": {
                                            "column": 12,
                                            "line": 2
                                        },
                                        "type": "fact object"
                                    }
                                ],
                                "position": {
                                    "column": 8,
                                    "line": 2
                                },
                                "type": "function"
                            }
                        ],
                        "position": {
                            "column": 8,
                            "line": 2
                        },
                        "type": "expression"
                    },
                    {
                        "content": [
                            {
                                "content": [
                                    {
                                        "value": "/gdc/md/PROJECT_ID/obj/145",
                                        "position": {
                                            "column": 70,
                                            "line": 2
                                        },
                                        "type": "attribute object"
                                    },
                                    {
                                        "value": "This",
                                        "position": {
                                            "column": 122,
                                            "line": 2
                                        },
                                        "type": "identifier"
                                    }
                                ],
                                "position": {
                                    "column": 121,
                                    "line": 2
                                },
                                "type": "="
                            }
                        ],
                        "position": {
                            "column": 64,
                            "line": 2
                        },
                        "type": "where"
                    }
                ],
                "position": {
                    "column": 1,
                    "line": 2
                },
                "type": "metric"
            },
            "expression": "SELECT SUM([/gdc/md/PROJECT_ID/obj/233]) WHERE [/gdc/md/PROJECT_ID/obj/145] ={This}"
        },
        "meta": {
            "author": "/gdc/account/profile/USER_ID",
            "uri": "/gdc/md/PROJECT_ID/obj/331",
            "tags": "",
            "created": "2011-10-10 16:43:45",
            "identifier": "agF6gXSZeEK9",
            "deprecated": "0",
            "summary": "",
            "title": "Metric Name",
            "category": "metric",
            "updated": "2012-02-20 16:23:09",
            "contributor": "/gdc/account/profile/USER_ID"
        }
    }
}
</pre>


##Response

200 OK HTTP Status + URI of new created object

<pre>
{
"uri":"/gdc/md/PROJECT_ID/obj/NEW_OBJECT_ID"
}
</pre>
