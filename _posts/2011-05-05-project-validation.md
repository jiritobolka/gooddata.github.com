---
title: Project Validation
excerpt: Validate your projects before you deliver them to your users.
layout: post
---

# {{ page.title }}
_by ZD ([@zsvoboda](http://twitter.com/#!zsvoboda))_

The project validation API checks a GoodData project for the most common errors:

* Referential integrity issues. For example an employee dataset references some non-existent record in the department dataset.
* Missing attribute values check tries to find an attribute values that are used in report or metric filters and that are no longer present in the data.
* Ambiguous or Transitive references between datasets. Report computation results are unpredictable when a report is computed in project where there are multiple ways how to traverse the project's LDM from an attribute A to an attribute B. 

The project validation API can be invoked at the following URL

<pre><code>https://secure.gooddata.com/gdc/&lt;your-project-id&gt;/validate</code></pre>

The logged user must be associated with the _admin_ role to be able to invoke the API.