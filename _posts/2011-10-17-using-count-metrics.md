---
title: How to use COUNT in metrics
excerpt: The article describes how to use the COUNT in metrics.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

New to GoodData? Do you want to start creating some effective dashboards with your reports, then you'll need to know how to create metrics. As mentioned earlier, in most cases, metrics are aggregated facts. However, sometimes you need to count non fact elements which are called attributes. Check out the following model, here I'll explain how to create a `COUNT` metric.

<p>
<center><img src="{{ site.root }}/images/posts/count_model.png" alt="Count Data Model"></center>
</p>

The COUNT metric can be used with one or two arguments. Let’s see how it works in some common use cases.

## Counting a number of salaries

Based on our model, Imagine that you are faced with the following scenario: you would like to create a simple metric that counts the number of salaries that had been paid. In this example, you'll count the distinct values of an attribute (non-countable field). Therefore, you'll need to use `SELECT COUNT(Salary ID)` as the metric definition in order to get the results you are looking for. This metric itself is not so useful but we can show the COUNT concept using it.

<p>
<center><img src="{{ site.root }}/images/posts/number_of_salary_metric.png" alt="Count Data Model"></center>
</p>

If you look on our model, you see that the `Salary ID` is not connected to other attributes and you are not able to slice and dice the metric that is defined as `COUNT(Salary ID)`. Try to define a report with this metric now. You see that other attributes (Employee,...) are greyed out (see the screenshot below). The `COUNT` here focuses solely on the Attribute and always returns the same number.

<p>
<center><img src="{{ site.root }}/images/posts/undrillable.png" alt="Undrillable"></center>
</p>

## Counting Employees that were paid

Now let’s say you want to do something a bit different. Let’s say that you want to `COUNT` number of Employees that were paid a salary. Then you will need to explain what you want to count. If you put an Employee together with a Salary in a report to count the number of employees with salary, then this is the time when you would need to use the second `COUNT` function parameter.

<p>
<center><img src="{{ site.root }}/images/posts/employee_with_salary.png" alt="Count Data Model"></center>
</p>

The Records of Salary attribute is needed to count the number of Employees that were paid a Salary. The metric syntax is `COUNT(Employee, Records of Salary)` as shown above.

You have two options how to create this type of metric. The first option is to add new metric from report dialog. Here, select the `COUNT` operation, then choose any attribute and the count metric with two arguments is created. If the attribute that you want to compute is connected to more than one dataset, you have also specify, which dataset you want to compute.

The second option is to use the Advanced Metric Editor to create this metric. Click the “advanced” link in the WHAT dialog menu, then follow the Custom metric link, make sure you name your metric (e.g. # Employees with Salary) and insert the metric definition: 

`SELECT COUNT(Employee,Records of Salary)`

## Advanced examples

And the last but not least, we would like to show you some more advanced tips that you can use with the COUNT metric to improve your reporting. Keeping in mind our model, we would like to know how many employees from the store management were paid a salary greater than $5,000. 

You can create a COUNT metric with a filter to find it out.

`SELECT COUNT(Employee,Records of Salary) WHERE Department = Store Management AND Salary < 5000`  
`SELECT COUNT(Employee,Records of Salary) WHERE Department = Human Resources AND Salary < 7500`  

etc...

Again, you'll need to use the Advanced Metric Editor to create these metrics.

Happy counting!


