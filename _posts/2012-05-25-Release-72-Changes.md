---
title: Release 72 Report API Changes
excerpt: Report API Changes in upcoming Release.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Since the Release 72, we are going to change our Report Definition API. If you are using this API in your custom apps and integrations, you would need to redesign your scripts. Current projects will be converted during the Release 72 but it will be done only once so you need to change your scripts because it won't be compatible in the future (after R72). 

In following example you'll see what kind of changes are coming up to the GoodData Platform. Anyway, thanks to these changes you will be able to sort by grand-totals and sub-totals in reports.

<p>
<center><img src="{{ site.root }}/images/posts/grand-subtotals.png" alt="Report with Grand and Sub Totals"></center>
</p>


<pre>
'reportDefinition' => {
    'content' => {
        'grid' => {
            'sort' => {
                'columns' => [],
                'rows' => [ {
                    'metricSort' => {
                        'direction' => 'desc',
                        'sortPath' => [ 1, 1 ],
                    }
                } ]
            },
            'columns' => [ {
                'attribute' => {
                    'uri' => '/gdc/md/FoodMartDemo/obj/3001'
                }       
            },      
            'metricGroup'
            ],      
            'metrics' => [ {
                'uri' => '/gdc/md/FoodMartDemo/obj/8330'
            }, {    
                'uri' => '/gdc/md/FoodMartDemo/obj/8331'
            } ],    
            'rows' => [ {
                'attribute' => {
                    'uri' => '/gdc/md/FoodMartDemo/obj/148'
                }       
            } ]     
        },      
    }
}
</pre>

This is the “old” approach. ReportDefinition with metric sort (using [ INT ] as a sort-path). We are sorting rows, so the path is through the columns header – first "1" in the sortPath is an attribute element id, second "1" means the second metric (first metric index is 0).

The “new” API changes the sorting path definition. See the example below.

<pre>
'reportDefinition' => {
    'content' => {
        'grid' => {
            'sort' => {
                'columns' => [],
                'rows' => [ {
                    'metricSort' => {
                        'direction' => 'desc', 
                        'locators' => [ {
                            'attributeLocator' => {
                                'uri' => '/gdc/md/FoodMartDemo/obj/3001',
                                'element' => 1
                            }       
                        }, {    
                            'metricLocator' => {
                                'uri' => '/gdc/md/FoodMartDemo/obj/8331'
                            }       
                        } ]     
                    }       
                } ]     
            },      
            'columns' => [ {
                'attribute' => {
                    'uri' => '/gdc/md/FoodMartDemo/obj/3001'
                }       
            },      
            'metricGroup'
            ],
            'metrics' => [ {
                'uri' => '/gdc/md/FoodMartDemo/obj/8330'
            }, {
                'uri' => '/gdc/md/FoodMartDemo/obj/8331'
            } ],
            'rows' => [ {
                'attribute' => {
                    'uri' => '/gdc/md/FoodMartDemo/obj/148'
                }
            } ]
        }
    },
}
</pre>

Let us know if you have any questions regarding our APIs etc. 