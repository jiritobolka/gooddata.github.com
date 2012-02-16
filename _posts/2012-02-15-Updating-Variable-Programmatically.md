---
title: Updating the Variable Using REST API
excerpt: Tutorial - how to update the variable value.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Do you use variables in your analytical projects quite often? If so, you surely need to update them from time to time. That means you'll definitely be interested in how to update the variable values programmatically. As in other use cases, our Platform is fully covered by REST API, so this can also be done using API resources. 

## Variable API

As mentioned before, we'll use our REST API with several API calls and payloads. By following the steps below, you'll be able to update variable values. A variable value can be a numeric value or a filter. A numeric variable type is simple and contains only a single value. If you create a filter variable, you will need to select an attribute value that'll define the filter. Just before we start the first API call, I would like to describe the concept of variable API. If you are not sure what the variable is, see the following [documentation](https://secure.gooddata.com/docs/html/reference.guide.data.variables.html).

Remember that variables were formerly called prompts, so while using GoodData API, you might see both terms being used. Every variable is represented by a prompt object that can be associated with one or multiple prompt answers. A prompt answer is a specific variable value associated with the user or the project. 

As you know, variables can be used in reports or metrics. In our example, we have the variable - Department - and we want to update a user specific value.

<p>
<center><img src="{{ site.root }}/images/posts/filterVariable.png" alt="Filter Variable"></center>
</p>

## Step 1 - Get the list of variables/prompts: 

As mentioned earlier, variables were formerly known as prompts. So, if you want to get list of all variables in the project, you will use GET call as specified below:

GET -> `https://secure.gooddata.com/gdc/md/PROJECT_ID/query/prompts`

the answer should look something like this:

<pre>
{
    "query": {
        "entries": [
            {
                "link": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/256",
                "author": "/gdc/account/profile/19765",
                "tags": "",
                "created": "2012-01-11 10:25:45",
                "deprecated": "0",
                "summary": "",
                "title": "Department",
                "category": "prompt",
                "updated": "2012-01-11 10:25:45",
                "contributor": "/gdc/account/profile/19765"
            },
            {
                ...
                ...
            }
        ],
        "meta": {
            "summary": "Metadata Query Resources for project obv8xyny3dygpb10t2rpai4tjw5nfcif",
            "title": "List of prompts",
            "category": "query"
        }
    }
}
</pre>

## Step 2 - Find variable ID

To update the variable value, you need to know what the variable item ID is because you'll need it in the next step. Grab the prompt URI from previous step (that uri inside the link tag) and use it to search the variable item ID in the following resource:

POST -> `https://secure.gooddata.com/gdc/md/PROJECT_ID/variables/search`

with following payload:

<pre>
{
    "variablesSearch": {
        "variables": [
            "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/256"
        ],
        "context": [
            
        ]
    }
}
</pre>

The API will give you the following JSON with all variable answers:

<pre>
{
    "variables": [
        {
            ...

            },
            {
            "uri": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/variables/item/4",
            "prompt": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/256",
            "related": "/gdc/projects/obv8xyny3dygpb10t2rpai4tjw5nfcif",
            "level": "project",
            "objects": [],
           "expression": "TRUE",
            "type": "filter"
        },
        {
            ...
            ...
            ...
            },
            {
            "uri": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/variables/item/8",
            "prompt": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/256",
            "related": "/gdc/account/profile/30672",
            "level": "user",
            "objects": [
                {
                    "category": "attributeElement",
                    "title": "HQ Marketing",
                    "attributeUri": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11",
                    "uri": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11/elements?id=3"
                },
                {
                    "link": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11",
                    "author": "/gdc/account/profile/19765",
                    "tags": "",
                    "created": "2012-01-23 10:11:25",
                    "deprecated": "0",
                    "summary": "",
                    "title": "Department",
                    "category": "attribute",
                    "updated": "2012-01-23 10:12:28",
                    "contributor": "/gdc/account/profile/19765"
                }
            ],
            
            "expression": "[/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11] IN ([/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11/elements?id=3])",
            "type": "filter"
            }
    ]
}
</pre>

The first part is the default variable answer and the rest of the JSON represents the user-specific variable answers. As you can see the default answer is "ALL" because the objects array is empty. It means the filter contains all attribute values. 

The expression value is what describes which attribute value belongs to the specific user. The user uri is a value of the related field.

## Step 3 - Updating the Variable value

This is the key part. From the previous step, we've found the item ID. In our example, we would like to update the Variable value that is identified by item ID = 8. By POSTing following JSON, you'll update the variable to the new value. See the HTTP request:

POST -> `https://secure.gooddata.com/gdc/md/PROJECT_ID/variables/item/8`

<pre>
{ 
 "variable": { 
 "expression": "[/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11] IN ([/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11/elements?id=5], [/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11/elements?id=3], [/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/11/elements?id=7])", 
 "level": "user", 
 "type": "scalar", 
 "prompt": "/gdc/md/obv8xyny3dygpb10t2rpai4tjw5nfcif/obj/256", 
 "related": "/gdc/account/profile/30672" 
} 
}
</pre>

The structure tells us that we'll update the variable with the value that is defined by the expression. The expression is the part where you need to put the new variable value. In this case, you'll set the user related variable to the attribute values that have 

ID = 5,3 and 7.

As you can see, you are able to set more variable options. The level specifies if the variable is set for the whole project or for a specific user. Type could have two values - scalar or filter. As you probably know, scalar is the constant number and filter is the variable that is defined by specific attribute value.

Well, we've successfully updated the filter variable value. Let us know how it works for you!

