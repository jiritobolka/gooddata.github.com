---
layout: documentation
stub: cloud-connect-sf-reader
---

# SalesForce Reader 

<img src="{{ site.root }}/docs/cloud-connect/images/sf-reader.png" style="border:none;float:right;margin:15px 0 0 5px;"/>
SF Reader downloads data from a single [SalesForce](http://www.salesforce.com/) dataset. The component requires SalesForce connection consisting of the login, password and security token to connect to the SalesForce account. Dataset, its fields and some conditional clause is defined by [SOQL](http://www.salesforce.com/us/developer/docs/api/Content/sforce_api_calls_soql_select.htm)

Downloaded records are sent to the only output port of the reader. The components provides the possibility of setting the number of automatic retry attempts and pauses between them.

## Example
<br />

<img src="{{ site.root }}/docs/cloud-connect/images/sf-reader-example.png" style="border:none;"/>

Metadata extracted from SF using the same query.

## Attributes, Settings & Codes

Salesforce connection - select one of pre-set SF connections
SOQL query - select clause to SF
Mandatory fields - fields should correspond to columns in the query
Max. retry attempts - maximal number of connections retry attempts
Pause between retries [secs] - delay between two retry attempts

## Inputs & Outputs

Port Type	Number	Required	Description	Metadata
Output	0	yes	for data records	corresponding with columns in the SOQL

<a href="#" class="greenButton">Example Download</a>