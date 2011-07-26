---
title: Creating Analytical Project with MAQL DDL
excerpt: This article quickly describes the relationship between the GoodData MAQL DDL, LDM, PDM, and DLI. 
layout: post
---

# {{ page.title }}
_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Today we will show you the relationship between the GoodData Logical Data Model (LDM), Physical Data Model (PDM) and MAQL DDL language. MAQL DDL is GoodData proprietary data definition language. We will outline the basic MAQL DDL concepts in this article.

The **LDM** (Logical Data Model) is necessary for creating your reports. It consists of attributes and facts that GoodData users add to their reports. 

The **PDM** (Physical Data Model) is used for the data storage and query. It is de-facto a DBMS schema (tables, columns, primary/foreign keys etc.).

The **DLI** (Data Loading Interface) is used for loading data to the GoodData projects.

LDM describes the logical structure of organization's data in terms like datasets, attributes and facts (check out this [documentation](http://developer.gooddata.com/api/maql-ddl.html) for more info). Most analytical tools and platforms will force you to develop both LDM and PDM that are perfectly aligned. Unlike the average tools, GoodData interface with user only via the LDM. The corresponding PDM and DLI are automatically generated from the LDM. The LDM model is created and modified via the MAQL DDL language statements, that are kind of similar to the SQL DDL (Data Definition Language).

**NOTE**: We'll use the "Employee" dataset example to show you the relationship between the LDM, PDM and DLI. A similar dataset is part of the [HR demo](http://developer.gooddata.com/gooddata-cl/examples/hr/).

Lets start with a simple LDM model that you can see on the figure below. As you can see, the LDM contains one fact and two attributes in a hierarchy (department and employee).

<p>
<center><img src="{{ site.root }}/images/posts/ldm-model.png" alt="Logical Data Model"></center>
</p>

As we have mentioned above, we'll use the MAQL DDL language to define the LDM. The rest (PDM and DLI) will be generated automatically via the SYNCHRONIZE MAQL DDL command.

The PDM is standard DBMS schema with tables, columns, primary and foreign keys. A LDM `ATTRIBUTE` is represented by a database table with primary key and couple text columns (one for each `LABEL`) in the PDM. A LDM `FACT` is mapped to a column in a PDM fact table. The figure below outlines the PDM that has been automatically generated from the LDM above.

<p>
<center><img src="{{ site.root }}/images/posts/pdm-model.png" alt="Physical Data Model"></center>
</p>

The last piece of the puzzle is the DLI that is necessary for data loading. GoodData platform loads data in self-describing packages. The data package is a ZIP archive that contains the data (delimited file) and a manifest that describes how the data map to the project's LDM and PDM. The figure below shows the data file only. As you can see this is de-normalized (flattened `d_employee_department` and `f_employee` PDM tables) version of the PDM.

<p>
<center><img src="{{ site.root }}/images/posts/data-template.png" alt="Data Template"></center>
</p>

Now, we'll inspect the MAQL DDL statements that create the LDM model above. We'll create the Employee dataset with the Department and Employee attributes and the Salary fact.

**Creating the Employee dataset**

First, we have to create the Employee dataset. Here is the corresponding MAQL statement:

`CREATE DATASET {dataset.employee} VISUAL(TITLE "Employee");`

That creates the Employee dataset.

**Creating the Salary fact**

`CREATE FACT {fact.employee.salary} VISUAL(TITLE "Salary") AS {f_employee.f_salary};`

`ALTER DATASET {dataset.employee} ADD {fact.employee.salary};`

The first statement creates new `Salary` fact (LDM) and the corresponding `{f_salary}` column in the `f_employee` table (PDM). Remember that the fact is represented as a database column.

**NOTE:** All PDM tables, columns, keys etc. are automatically generated after calling the `SYNCHRONIZE` MAQL DDL command that is usually the last command of a MAQL DDL script.  

**Creating the Employee attribute**

`CREATE ATTRIBUTE {attr.employee.id} VISUAL(TITLE "Employee") AS KEYS {f_employee.id} FULLSET;`

`ALTER ATTRIBUTE {attr.employee.id} ADD LABELS {label.employee.ssn} VISUAL(TITLE "SSN") AS {f_employee.nm_ssn};`

`ALTER ATTRIBUTE {attr.employee.id} ADD LABELS {label.employee.name} VISUAL(TITLE "Name") AS {f_employee.nm_name};`

`ALTER DATASET {dataset.employee} ADD {attr.employee.id};`

The first command line creates the LDM attribute named Employee. The LDM attribute maps to a PDM table that has the primary key `{f_employee.id}` (FULLSET). We can also add the foreign key, but we are not going to do it so right now. Stay tuned, we will show it later. As mentioned above, the attribute is defined as a PDM table. The attribute itself is the auto-generated ID `f_employee.id`.

The second and the third row add labels to the Employee attribute. As you've guessed already, labels are text representations of the attribute. For example, the Employee attribute has two: the SSN and the Name. Later you'll be able to choose which label is more suitable for your report. Both labels and ID map to the columns in PDM table (`{id}`, `{nm_ssn_}` and `{nm_name}`). You'll see these names later in the DLI.

**Creating the Department attribute**

Now, we will repeat the exercise and create the Department attribute. The only difference is that we'll create the foreign key to the `f_employee` table now. Note that the first MAQL DDL statement contains two keys. The first one `d_employee_department.id` is the primary key and the second one `f_employee.department_id` is the foreign key that ties the `d_employee_department` table to the `f_employee` table.

`CREATE ATTRIBUTE {attr.employee.department} VISUAL(TITLE "Department") AS KEYS {d_employee_department.id} FULLSET, {f_employee.department_id};`

`ALTER ATTRIBUTE {attr.employee.department} ADD LABELS {label.employee.department.name} VISUAL(TITLE "Department") AS {d_employee_department.nm_department};`

`ALTER DATASET {dataset.employee} ADD {attr.employee.department};`

In the second line of the script, we again added the label to the Department attribute. Label is defined as `nm_department` column in the `{d_employee_department}` table. 

Finally we add the Department attribute to the Employee dataset.

**Generating / Synchronizing PDM and DLI**

This is the magic statement that generates the PDM and the DLI.

`SYNCHRONIZE {dataset.employee};`

**NOTE:** Remember that SYNCHRONIZE command will erase all data and require to load it back.

The figure below describes the relationship between the MAQL DDL, LDM, PDM and DLI.

<p>
<center><img src="{{ site.root }}/images/posts/maql-generating.png" alt="Logical Data Model"></center>
</p>

**Loading data**

We have called the SYNCHRONIZE command and we've ended up with an empty GoodData project. The last step is to populate it with some useful data. We can use the DLI REST API to do it. The DLI API is a combination of a private WebDav storage where we upload the self-describing data package and a simple asynchronous call (`/etl/pull`) that starts the data loading process. You find more in the [DLI documentation](http://developer.gooddata.com/api/#data).

The self-describing data package is a ZIP archive, that contains the data file with predefined columns and a simple manifest that describes the mapping between the data file and the project's PDM. The data package template reside on this URL:

`https://secure.gooddata.com/gdc/md/<your-project-number>/ldm/singleloadinterface/dataset.<your-dataset-name>/template`

You can simply download the template, unzip it, populate the data file with your data (you'll need to preserve the header row and the column sequence), re-pack it, upload it to the DLI API's WebDav location, and call the `etl/pull` API to start the asynchronous data loading process. That's all about the MAQL DDL, PDM, DLI and LDM for today. See you next time!
