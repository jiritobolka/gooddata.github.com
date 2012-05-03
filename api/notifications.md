---
title: Notifications
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-notifications
---

# Channel Setup
<br />
## Description

The resource for setting up new Channel for Subscription.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/account/profile/PROFILE_ID/channelConfigurations</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create a new Salesforce Chatter channel:

<pre>
{
   "channelConfiguration":{
      "configuration":{
         "sfdcChatterConfiguration":{
            "username":"your@email",
            "password":"passwordSecurityToken"
         }
      },
      "meta":{
         "title":"SFDC Channel"
      }
   }
}
</pre>

To create Twillio as a channel use following JSON payload:

<pre>
{
   "channelConfiguration":{
      "configuration":{
         "twilioSmsConfiguration":{
            "username":"username",
            "password":"AUTH TOKEN",
            "from":"+14086457515",
            "to":"+420724000000"
         }
      },
      "meta":{
         "title":"Twilio Title"
      }
   }
}
</pre>

To create Email as a channel use following JSON payload:

<pre>
{
    "channelConfiguration": {
        "configuration": {
            "emailConfiguration": {
                "to": "user@email.com"
            }
        },
        "meta": {
            "title": "Email Channel"
        }
    }
}
</pre>

##Response

201 Created HTTP Status + URI + description of created channel configuration:

<pre>
{
    "channelConfiguration": {
        "configuration": {
            "sfdcChatterConfiguration": {
                "username": "USERNAME@DOMAIN.COM"
            }
        },
        "meta": {
            "title": "Channel Name",
            "author": "/gdc/account/profile/PROFILE_ID_",
            "category": "channelConfiguration",
            "updated": "2011-12-20 13:43:17",
            "created": "2011-12-20 13:43:17",
            "uri": "/gdc/account/profile/PROFILE_ID/channelConfigurations/CHANNEL_ID"
        }
    }
}
</pre>

-----

# Subscription Setup
<br />
## Description

Resource for creating new Subscription based on specific JEXL expression.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/projects/PROJECT_ID/users/USER_ID/subscriptions</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create new Subscription (example):

<pre>
{
   "subscription":{
      "triggers":[
         {
            "timerEvent":{
               "cronExpression":"0 0/5 * * * *"
            }
         }
      ],
      "condition":{
         "condition":{
            "expression":"f:executeMetric('METRIC_URI') &lt 16"
         }
      },
      "message":{
         "template":{
            "expression":"Average Chatter posts per Opportunity has fallen to ${f:executeMetric('METRIC_URI')} ..."
         }
      },
      "channels":[
         "CHANNEL_URI"
      ],
      "meta":{
         "title":"Avg Posts per Oppty &lt 16"
      }
   }
}
</pre>


##Response

201 Created HTTP Status + URI and details of created subscription:

<pre>
{
    "subscription": {
        "triggers": [
            {
                "timerEvent": {
                    "cronExpression": "0 0/5 * * * *"
                }
            }
        ],
        "condition": {
            "condition": {
                "expression": "f:executeMetric('/gdc/md/PROJECT_ID/obj/OBJECT_ID') &lt 0.99"
            }
        },
        "message": {
            "template": {
                "expression": "Custom message % ${f:executeMetric('/gdc/md/PROJECT_ID/obj/OBJECT_ID')} ..."
            }
        },
        "channels": [
            "/gdc/account/profile/USER_ID/channelConfigurations/CHANNEL_ID"
        ],
        "meta": {
            "title": "TEST%",
            "author": "/gdc/account/profile/USER_ID",
            "category": "subscription",
            "updated": "2011-12-20 13:59:23",
            "created": "2011-12-20 13:59:23",
            "uri": "/gdc/projects/PROJECT_ID_/users/USER_ID_/subscriptions/SUBSCRIPTION_ID"
        }
    }
}
</pre>