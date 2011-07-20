---
title: MAQL and its relation with PDM and LDM
excerpt: How MAQL works with PDM and LDM in GoodData
layout: post
---

# {{ page.title }}
_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Today we will show you the relationship between Logical Data Model (LDM), Physical Data Model (PDM) and MAQL DDL language. MAQL is proprietary data definition language. Follow this article to learn more about MAQL.

LDM describes the logical structure of organization's data in terms like datasets, attributes and facts (check out this [documentation](http://developer.gooddata.com/api/maql-ddl.html) for more info). Most analytical tools and platforms will force you to develop both LDM and PDM that are perfectly aligned. Unlike the average tools, GoodData interface with user only via the LDM. Corresponding PDM is automatically generated whenever the LDM changes. The LDM model is created and modified via the MAQL DDL language statements, that are similar to SQL DDL (Data Definition Language).

(**NOTE**: We will work with "Employee" dataset in following example. Similar dataset is also part of [HR demo](http://developer.gooddata.com/gooddata-cl/examples/hr/).)

We will show you an example of corresponding LDM, PDM and interface for loading the data. You see the LDM model on the first picture below. As you can see, LDM is dataset with one fact and two attributes.

<p>
<center><img src="{{ site.root }}/images/posts/ldm-model.png" alt="Logical Data Model"></center>
</p>

Physical Data Model is standard DBMS schema with tables, columns, primary and foreign keys. Every ATTRIBUTE is represented by a table with keys (PK and FK) and every FACT by a column in database table. Look at following example. 

<p>
<center><img src="{{ site.root }}/images/posts/pdm-model.png" alt="Physical Data Model"></center>
</p>

When you define LDM model with MAQL, corresponding PDM and Data Loading template are generated automatically. Data Loading template is shown on the figure below. It's CSV file with prepared header line. Data are shown here in de-normalized form. You can add data to this file and upload them. We will show you how it works later. 

<p>
<center><img src="{{ site.root }}/images/posts/data-template.png" alt="Data Template"></center>
</p>

Now, let me describe what MAQL DDL statements are required for creation of the LDM model outlined in the figures above. As you can see we want to create Employee dataset with attributes (Department, Employee) and fact (Salary).

**Creating the dataset**

First, we have to create the Employee dataset. Here is the corresponding MAQL statement:

`CREATE DATASET {dataset.employee} VISUAL(TITLE "Employee");`

This command creates dataset named Employee in Logical Data Model.

**Creating salary fact, in MAQL**

`CREATE FACT {fact.employee.salary} VISUAL(TITLE "Salary") AS {f_employee.f_salary};`

`ALTER DATASET {dataset.employee} ADD {fact.employee.salary};`

First statement creates new fact `Salary` (LDM) and the `{f_salary}` column in table `f_employee` (PDM). Remember that fact is represented as column in table (PDM).

(**NOTE:** PDM - database tables, columns, keys etc. are automatically generated after `SYNCHRONIZE` command is called at the end of MAQL statements.)  

**Creating attribute employee**

`CREATE ATTRIBUTE {attr.employee.id} VISUAL(TITLE "Employee") AS KEYS {f_employee.id} FULLSET;`

`ALTER ATTRIBUTE {attr.employee.id} ADD LABELS {label.employee.ssn} VISUAL(TITLE "SSN") AS {f_employee.nm_ssn};`

`ALTER ATTRIBUTE {attr.employee.id} ADD LABELS {label.employee.name} VISUAL(TITLE "Name") AS {f_employee.nm_name};`

`ALTER DATASET {dataset.employee} ADD {attr.employee.id};`

The first command line creates the LDM attribute named "Employee". The LDM attribute maps to a PDM table that has the primary key `{f_employee.id}` (FULLSET). We can also add the foreign key, but not now. We will show it later. As mentioned above, attribute is defined as database table with unique ID.

The second and the third row add labels to the "Employee" attribute. Let me describe what labels are. Labels are text representation of the same semantic value. Employee attribute is defined by "ID". There are two text representations of the attribute "SSN" and "Name" (You can choose from them when you create reports in GoodData UI). Both labels and ID map to the columns in PDM table (`{id}`, `{nm_ssn_}` and `{nm_name}`). You can also see the same names in the Data Loading Interface.

**Creating attribute department**

`CREATE ATTRIBUTE {attr.employee.department} VISUAL(TITLE "Department") AS KEYS {d_employee_department.id} FULLSET, {f_employee.department_id};`

`ALTER ATTRIBUTE {attr.employee.department} ADD LABELS {label.employee.department.name} VISUAL(TITLE "Department") AS {d_employee_department.nm_department};`

`ALTER DATASET {dataset.employee} ADD {attr.employee.department};`

Again, commands in the first line create the "Department" attribute. Here is the moment when we will define foreign key to connect the tabels. Statement `AS KEYS {d_employee_department.id} FULLSET` defines Primary key in `{d_employee_department}` database table. The `{f_employee.department_id}` is column in the `{f_employee}` table and provides connection between two database tables (foreign key).

In the second line of the script, we added label to "Department" attribute. Label is defined as `nm_department` column in the `{d_employee_department}` table. 

Finally we add the "Department" attribute to the "Employee" dataset.

**Generating / Synchronizing PDM**

`SYNCHRONIZE {dataset.employee};`

When you finish the LDM definition, you need to apply changes to PDM and to the Data Loading Interfaces. This is not done immediately. You have to call the `SYNCHRONIZE` command whenever LDM changes have impact to PDM. That means `SYNCHRONIZE` command reflects changes from logical to physical model.

(**NOTE:** Remember, that calling SYNCHRONIZE will change your physical storage and empty all data and require to load it back.)

Here is the result of what we created with MAQL statements above:

<p>
<center><img src="{{ site.root }}/images/posts/maql-generating.png" alt="Logical Data Model"></center>
</p>

**Loading data**

Now we have LDM and corresponding PDM tables prepared. We would like to upload the data to the GoodData project. We'll use so called Data Loading Interface (DLI) API for transferring the data.

The DLI API is a combination of a private WebDav storage where we upload the data and a simple asynchronous call that starts the data loading process. You can also check out the [DLI documentation](http://developer.gooddata.com/api/#data).

The data are wrapped in a self-describing package, that contains the data file and simple manifest that describes the mapping between data file and PDM. You can download and check out the package from following URL:

`https://secure.gooddata.com/gdc/md/<your-project-number>/ldm/singleloadinterface/dataset.<your-dataset-name>/template`

So, that is about MAQL, PDM and LDM relationship. See you next time!