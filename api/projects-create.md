---
title: Project Resources in GoodData
layout: documentation
breadcrumbs:
- name: API Documentation
  url: /api/
stub: api-projects-create
---

# Create Project
<br />
## Description

Create a new project specified by parameters in JSON payload. You need to be authenticated, see
details about the [authentication](api/auth.html).

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/projects/</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to create a new project:

<pre>
{
"project" : {
"content" : {
"guidedNavigation": 1
},
"meta" : {
"title" : "Test Project",
"summary" : "Testing Project",
"projectTemplate" : "TEMPLATE URI"
} }
}
</pre>

##Response

OK - 201 Created + URI of created Project:

<pre>
{
   "uri" : "/gdc/projects/PROJECT_ID_"
}
</pre>

##Code example

<pre>
$ curl --cookie cookies.txt \ --data-binary @- \ --header 'Accept: application/yaml' \ --header 'Content-Type: application/json' \ https://secure.gooddata.com/gdc/projects/ EOR {"project" : {"content" : {"guidedNavigation": 1},
"meta" : {"summary" : "Testing Project","title":"Test"}}}
</pre>

-------

# List all Projects
<br />
## Description

Get the list of existing projects for authenticated user.

##Request

HTTP Request

**GET**  
<pre>https://secure.gooddata.com/gdc/account/profile/PROFILE_ID/projects</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Empty body

##Response

<pre>
{
   "projects" : [
      {
         "project" : {
            "content" : {
               "guidedNavigation" : "1",
               "isPublic" : "0",
               "state" : "ENABLED"
            },
            "links" : {
               "roles" : "/gdc/projects/PROJECT_ID/roles",
               "ldm_thumbnail" : "/gdc/projects/PROJECT_ID/ldm?thumbnail=1",
               "userPermissions" : "/gdc/projects/PROJECT_ID_/users/PROFILE_ID/permissions",
               "userRoles" : "/gdc/projects/PROJECT_ID/users/PROFILE_ID/roles",
               "connectors" : "/gdc/projects/PROJECT_ID/connectors",
               "self" : "/gdc/projects/PROJECT_ID",
               "invitations" : "/gdc/projects/PROJECT_ID/invitations",
               "users" : "/gdc/projects/PROJECT_ID/users",
               "ldm" : "/gdc/projects/PROJECT_ID/ldm",
               "metadata" : "/gdc/md/PROKECT_ID",
               "publicartifacts" : "/gdc/projects/PROJECT_ID/publicartifacts",
               "templates" : "/gdc/md/PROJECT_ID/templates"
            },
            "meta" : {
               "created" : "YYYY-MM-DD HH:MM:SS",
               "summary" : "Project Summary",
               "updated" : "YYYY-MM-DD HH:MM:SS",
               "author" : "/gdc/account/profile/PROFILE_ID",
               "title" : "Your Project Name",
               "contributor" : "/gdc/account/profile/PROFILE_ID"
            }
         }
      } ]
}
</pre>

------

# Export Project
<br />
## Description

Resource for export whole project. You can choose from several options (export with users, export with data).

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/maintenance/export</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to export project:

<pre>
{ "exportProject" : {
     "exportUsers" : "integer",
     "exportData" : "integer"
  }
}
</pre>


##Response

HTTP 200 OK Status

Token + URI of async process status resource for polling in JSON object:

<pre>
{
   "exportArtifact" : {
      "status" : {
         "uri" : "/gdc/md/PROJECT_ID/etltask/TASK_ID"
      },
      "token" : "EXPORT_TOKEN"
   }
}
</pre>

-----

# Import Project
<br />
## Description

Resource for import exported project with stored token.

##Request

HTTP Request

**POST**  
<pre>https://secure.gooddata.com/gdc/md/PROJECT_ID/maintenance/import</pre>

_HTTP Headers_

Content-Type: application/json  
Accept: application/json

##Request Body

Following JSON payload should be sent to import the exported project from the Token:

<pre>
{ 
"importProject" : {
  "token" : "TOKEN_STRING"
  }
}
</pre>


##Response

HTTP 200 OK Status

URI of the async process status resource for polling:

<pre>
{
"uri" : "/gdc/md/PROJECT_ID/etltask/TASK_ID"
}
</pre>

