---
title: Using API for Schedule Report email distribution
excerpt: The article gives you a step by step tutorial on how to schedule Report email distribution.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Have you ever been asked to distribute selected Reports via email? Read the following example where we will explain you how to automate this process using the GoodData API.

To create new scheduled email that will be used for sending selected Reports to selected Users, use following request with a JSON payload:

**POST** : `https://secure.gooddata.com/gdc/md/PROJECT_ID/obj`  
headers: Content-Type: application/json, Accept: application/json

Body:

<pre>
{
    "scheduledMail": {
        "meta": {
            "title": "Scheduled report",
            "summary": "Daily at 12:00pm PT",
            "tags": "",
            "deprecated": 0
        },
        "content": {
            "when": {
                "recurrency": "0:0:0:1*12:0:0",
                "startDate": "2012-06-05",
                "timeZone": "America/Los_Angeles"
            },
            "to": [
                "email@company.com"
            ],
            "subject": "Scheduled report",
            "body": "Hey, I'm sending you new Reports!",
            "attachments": [
                {
                    "reportAttachment": {
                        "uri": "/gdc/md/PROJECT_ID/obj/1520",
                        "formats": [
                            "pdf",
                            "xls"
                        ]
                    }
                }
            ]
        }
    }
}
</pre>

To describe the JSON fields:

**meta:** This part is self-describing and is the same as in other resources  
**when:** This part contains following three fields  
**recurrency:** cron Expression that specifies interval of email  
**startDate:** defines when the email sending starts  
**timeZone:** defines timezone  
**to:** An array of Email receivers  
**subject:** Subject of the Email  
**body:** Body of the Email that will be scheduled  
**attachments:** This part contains all attachments (i.e. Reports)  
**reportAttachment:** Report attachment definition  
**uri:** URI of attached Report  
**format:** Format in which the Report will be sent (pdf, csv, inline, html)  

As a response, you will GET the Object URI

Response:

<pre>
{"uri":"/gdc/md/PROJECT_ID/obj/58057"}
</pre>

See the screenshot of the REST Client set up for this request:

<p>
<center><img src="{{ site.root }}/images/posts/create-scheduledmails.png" alt="Creating new schedule email object" width="600"></center>
</p>

Now, let's see the Project metadata query API resource. Send the GET request to the `/gdc/md/PROJECT_ID/query/scheduledmails/` as a result, you will get the list of `scheduledmails` objects. That means the emails that are scheduled with selected reports.

List all Scheduled report:

**GET** : `https://secure.gooddata.com/gdc/md/PROJECT_ID/query/scheduledmails/`  
headers: Content-Type: application/json, Accept: application/json

See the example response:

<pre>
{
    "query": {
        "entries": [
            {
                "link": "/gdc/md/PROJECT_ID/obj/58056",
                "author": "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d",
                "tags": "",
                "created": "2012-06-05 14:58:42",
                "deprecated": "0",
                "summary": "Daily at 12:00pm PT",
                "title": "Scheduled report",
                "category": "scheduledMail",
                "updated": "2012-06-05 14:58:42",
                "contributor": "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d"
            }
        ],
        "meta": {
            "summary": "Metadata Query Resources for project 'PROJECT_ID'",
            "title": "List of scheduledmails",
            "category": "query"
        }
    }
}
</pre>

For illustration, See the Request using the REST Client for Firefox:

<p>
<center><img src="{{ site.root }}/images/posts/list-scheduledmails.png" alt="List all scheduled emails" width="600"></center>
</p>

List the object that is Scheduled report:

**GET** : `https://secure.gooddata.com/gdc/md/PROJECT_ID/obj/58056`  
headers: Content-Type: application/json, Accept: application/json

Response:

<pre>
{
   "scheduledMail" : {
      "content" : {
         "body" : "Hey, I'm sending you new Reports!",
         "when" : {
            "timeZone" : "America/Los_Angeles",
            "recurrency" : "0:0:0:1*12:0:0",
            "startDate" : "2012-06-05"
         },
         "attachments" : [
            {
               "reportAttachment" : {
                  "formats" : [
                     "pdf",
                     "xls"
                  ],
                  "uri" : "/gdc/md/PROJECT_ID/obj/1520"
               }
            }
         ],
         "to" : [
            "jiri.tobolka@gooddata.com"
         ],
         "subject" : "Scheduled report"
      },
      "meta" : {
         "author" : "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d",
         "uri" : "/gdc/md/PROJECT_ID/obj/58056",
         "tags" : "",
         "created" : "2012-06-05 14:58:42",
         "identifier" : "aagDkHVGd7g0",
         "deprecated" : "0",
         "summary" : "Daily at 12:00pm PT",
         "title" : "Scheduled report",
         "category" : "scheduledMail",
         "updated" : "2012-06-05 14:58:42",
         "contributor" : "/gdc/account/profile/2f35048619b7b0ff03f408d2c4b6390d"
      }
   }
}
</pre>

In REST Client:

<p>
<center><img src="{{ site.root }}/images/posts/list-scheduledmail-detail.png" alt="Get the scheduled report object details" width="600"></center>
</p>

To **UPDATE** the scheduledMail object, you have to send POST request with the body to the specific object resource. The body will be the updated result from the GET response above. Well, emails will be sent regularly in a specified time and within a specified period! How does it work for you?

We are constantly making our APIs better, for example you will be able to send all Dashboard via email using the same API.