---
title: Adding User to Project Programmatically
excerpt: The new CL tool command AddUsersToProject
layout: post
---

# {{ page.title }}
_by ZD ([@zsvoboda](http://twitter.com/#!zsvoboda))_

The [CL Tool 1.2.35](https://github.com/gooddata/GoodData-CL/downloads) adds a new <code>AddUsersToProject</code> command that allows you to programmatically add an existing user (previously created by the <code>CreateUser</code> command). No confirmation e-mails are required. The user who is adding new users must be the admin in the project where the new users are added. Moreover the user must be the domain admin. Let us know at <a href="mailto:support@gooddata.com">support@gooddata.com</a> if you need your own domain.

Once your account is associated with the domain, you can simply run the command from a CL Tool script:

<code>CreateUser(domain="MYDOMAIN", username="admin@domain.com", password="secret", firstName="John", lastName="Doe", company="John.Doe@acme.com", ssoProvider="SALESFORCE", usersFile="users.txt", append="true");</code> 

<code>AddUsersToProject(usersFile="users.txt", role="DASHBOARD ONLY");</code> 

Each new user created by the <code>CreateUser</code> command is identified by an URI that can be accumulated in the <code>usersFile</code>. The <code>usersFile</code> can be overwritten (<code>append="false"</code>) or appended (<code>append="true"</code>).

The users represented by the URIs in the <code>usersFile</code> can be added to an existing project using the <code>AddUsersToProject</code> command. This command requires a project context (_CreateProject_, _OpenProject_, _UseProject_ above). Then it wants the <code>usersFile</code> that contains a user URI on each line and the <code>role</code> parameter that specifies the role (_admin_, _editor_, _dashboard only_) that all users will have in the project. 

As always the <code>AddUsersToProject</code> command invokes corresponding REST API. You can always check out the API invocation in the [CL tool source code](https://github.com/gooddata/GoodData-CL/blob/master/backend/src/main/java/com/gooddata/integration/rest/GdcRESTApiWrapper.java).

Let us know what you think!