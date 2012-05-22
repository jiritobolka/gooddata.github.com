---
title: User Provisioning
layout: documentation
stub: docs-provisioning
---

# {{ page.title }}

<br />
## What is User Provisioning

User provisioning is functionality that allows specific user to create/update/delete new users and to provision them into the GoodData Project. See the picture below to get high level overview.

<p>
<center><img src="{{ site.root }}/images/docs/user-management.png" alt="User Management" class="no-border"></center>
</p>

## Domains

In GoodData, domain is not part of a project. Domain is user space specially created for partners. As a GoodData customer/partner, having your own domain means that you have special permissions. You are able to add, edit and delete users in your domain and also provision these users directly into the GoodData projects. Every customer (if having domain) has one domain and one domain admin account. This account is used for all end users.

Once you have your own domain, you can add or delete users inside your Domain. You can provision these users into GoodData Project, change their role etc. Only domain admin user can provision other users to projects.

Domain needs to be created manually, you can request the creation sending email to **support@gooddata.com**

## Creating new user 

To create new user in GoodData you need to have a domain created. You can have your own domain and maintain users in it even if you don't have the SSO implemented. Once you have your domain, you can use the [User Provisioning API]({{ site.root }}/docs/api/user.html). Only domain admins can add users to the project.

## Adding User to Project

Users with project admin permissions can provision users that are already in the domain to the Project. You can again use the REST API for this feature. See the [API Reference]({{ site.root }}/docs/api/user.html).
