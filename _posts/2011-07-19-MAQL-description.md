---
title: MAQL and its relation with PDM and LDM
excerpt: How MAQL works with PDM and LDM in GoodData
layout: post
---

# {{ page.title }}
_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Today we will show you the relationship between Logical Data Model (LDM), Physical Data Model (PDM) and MAQL DDL language. MAQL is proprietary data definition language and you can learn how it works from the following example. 

LDM describes the logical structure of organization's data in terms like datasets, attributes and facts (check out this [documentation](http://developer.gooddata.com/api/maql-ddl.html) for more info). Most analytical tools and platforms will force you to develop both LDM and PDM that are perfectly aligned. Unlike the average tools, GoodData interface with user only via the LDM. Corresponding PDM is automatically generated whenever the LDM changes. The LDM model is created and modified via the MAQL DDL language statements, that are similar to SQL DDL (Data Definition Language).

(**NOTE**: We will work with "Employee" dataset in following example. Similar dataset is also part of [HR demo](http://developer.gooddata.com/api/maql-ddl.html).)

Here is Logical Data Model

<p>
<center><img src="{{ site.root }}/images/posts/ldm-model.png" alt="Logical Data Model"></center>
</p>

Physical Data Model

<p>
<center><img src="{{ site.root }}/images/posts/pdm-model.png" alt="Physical Data Model"></center>
</p>

and finally template for uploading data

<p>
<center><img src="{{ site.root }}/images/posts/data-template.png" alt="Data Template"></center>
</p>

**Creating model with MAQL**

Now, let me describe what MAQL DDL statements are required for creation of the LDM model outlined in the figure above. As you can see we want to create Employee dataset with attributes (Department, Employee) and fact (Salary).

1. First, we have to create the Employee dataset. Here is the corresponding MAQL statement:

`CREATE DATASET {dataset.employee} VISUAL(TITLE "Employee");`

This command creates dataset named Employee in Logical Data Model.

2. Creating salary fact, in MAQL:

`CREATE FACT {fact.employee.salary} VISUAL(TITLE "Salary") AS {f_employee.f_salary};`

`ALTER DATASET {dataset.employee} ADD {fact.employee.salary};`

First statement creates new fact `Salary` (LDM) and the `{f_salary}` column in table `f_employee` (PDM). Fact is represented as column in table (PDM).

(**NOTE:** PDM - database tables, columns, keys etc. are automatically generated after `SYNCHRONIZE` command is called at the end of MAQL statements.)  

3. Creating attribute employee:

`CREATE ATTRIBUTE {attr.employee.id} VISUAL(TITLE "Employee") AS KEYS {f_employee.id} FULLSET;`

`ALTER ATTRIBUTE {attr.employee.id} ADD LABELS {label.employee.ssn} VISUAL(TITLE "SSN") AS {f_employee.nm_ssn};`

`ALTER ATTRIBUTE {attr.employee.id} ADD LABELS {label.employee.name} VISUAL(TITLE "Name") AS {f_employee.nm_name};`

`ALTER DATASET {dataset.employee} ADD {attr.employee.id};`

The first line commands create the LDM attribute named "Employee". The `AS KEYS {f_employee.id} FULLSET` statement defines how attribute will be defined in PDM. Attributes are defined as database tables with unique ID's for every row in the table (SQL primary key = FULLSET) 

The second and the third row add labels to the "Employee" attribute. Let me describe what labels are. Labels are text representation of the same semantic value. In this example Employee attribute is represented as "ID", but also as "SSN" and "Name" (You can choose from them when you create reports in GoodData UI). Labels are defined as columns in PDM tables (`{nm_ssn_}` and `{nm_name}`) and also generated into the header of data loading template `CSV` file. We will take a look on how data loading works later. 

4. Creating attribute department:

`CREATE ATTRIBUTE {attr.employee.department} VISUAL(TITLE "Department") AS KEYS {d_employee_department.id} FULLSET, {f_employee.department_id};`

`ALTER ATTRIBUTE {attr.employee.department} ADD LABELS {label.employee.department.name} VISUAL(TITLE "Department") AS {d_employee_department.nm_department};`

`ALTER DATASET {dataset.employee} ADD {attr.employee.department};`

Again, commands in the first row create the "Department" attribute. Statement `AS KEYS {d_employee_department.id} FULLSET` defines Primary key in `{d_employee_department}` database table. `{f_employee.department_id}` is column in `{f_employee}` table and provides connection between two database tables (foreign key).

In second row, we added label to "Department" attribute. Label is defined as `nm_department` column in `{d_employee_department}` table. 

Finally we add the "Department" attribute to the "Employee" dataset.

5. Generating / Synchronizing PDM:

`SYNCHRONIZE {dataset.employee};`

Whenever you want to apply the LDM changes to PDM and to the Data Loading Interfaces you have to call the `SYNCHRONIZE` command. That means when you call SYNCHRONIZE for the first time, SQL tables are created (altered after next `SYNCHRONIZE` call). SYNCHRONIZE command runs SQL transaction, so you have to prepare complete model before run it.

(**NOTE:** Remember, that calling SYNCHRONIZE will change your physical storage and empty all data and require to load it back.)

Here is the result of what we created with MAQL statements above:

<p>
<center><img src="{{ site.root }}/images/posts/maql-generating.png" alt="Logical Data Model"></center>
</p>

**Loading data**

When you call `SYNCHRONIZE` as described above, MAQL generates the PDM model (or make changes to it) and the Data Loading Interface (DLI). DLI consists of multiple parts and you can download and unpack your's project DLI template on following URL:

`https://secure.gooddata.com/gdc/md/<your-project-number>/ldm/singleloadinterface/dataset.<your-dataset-name>/template`

Template package contains `CSV` file and `manifest` file. `CSV` file is template with header line and you can add your data to columns (remember that order of columns is critical). When you fill your data into `CSV` file, package it with `manifest` file to the ZIP archive, you can send this archive via `WebDav` to GoodData and your data is uploaded. You can also check out the [DLI documentation](http://developer.gooddata.com/api/#data).

`Manifest` file provides connection between PDM, LDM and CSV data file and defines how to load columns into database. You can review manifest file on following URL:

`https://secure.gooddata.com/gdc/md/<your-project-number>/ldm/singleloadinterface/dataset.<your-dataset-name>/manifest`

So, that is about MAQL, PDM and LDM relationship. See you next time!