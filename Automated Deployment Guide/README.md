# Energy Resource Optimization Solution

This folder contains the deployment instructions for the Energy Resource Optimization solution in the Cortana Intelligence Gallery. To start a new solution deployment, visit the gallery page.

## Summary
<Guide type="Summary">
In an energy grid, energy consumers are engaged with various types of energy supplying, trading, and storage components such as substations, batteries, windfarms and solar panels, micro-turbines, as well as demand response bids, to meet their respective demands and minimize the cost of energy commitment. To do so, the grid operator must determine how much energy each type of the resources should commit over a time frame, given the prices of soliciting different types of resources and the capacities and the physical characteristics of them.

This solution is built upon Cortana Intelligence Suite and external open-source tools, and it computes the optimal energy unit commitments from various types of energy resources. This solution demonstrates the ability of Cortana Intelligence Suite to accommodating external tools, to solve parallelized numerical optimization problems over an Azure Batch of Azure Virtual Machines. 
</Guide>

## Prerequisites
<Guide type="Prerequisites">
The Subscription and selected region in that subscription should have 1 Azure Batch account available
</Guide>

#### Estimated Provisioning Time:<Guide type="EstimatedTime">15 Minutes</Guide>

## Description
<Guide type="Description">




An energy grid consists of energy consumers, as well as various types of energy supplying, trading, and storage components: Substations accepts power load or exports excessive power; Batteries may discharge energy or store it for future use; Windfarms and solar panel (self-scheduled generators), micro-turbines (dispatchable generators), and demand response bids can all be engaged to satisfying the demand from the consumers within the grid. The costs of soliciting different types of resources vary, while the capacities and the physical characteristics of each resource type limit the dispatch of the resource. Given all these constraints, a central challenge the smart grid operator must face, is how much energy each type of the resources should commit over a time frame, so that the forecasted energy demand from the grid are satisfied.

This solution provides an Azure-based smart solution, leveraging external open-source tools, that determines the optimal energy unit commitments from various types of energy resources for an energy grid. The goal is to minimize the overall cost incurred by these commitments while satisfying the energy demand. This solution demonstrates the ability of Azure to accommodating external tools, such as [Pyomo](http://www.pyomo.org/) and [CBC](https://projects.coin-or.org/Cbc), to solve large-scale numerical optimization problems such as mixed integer-linear programming, parallelizing multiple optimization tasks over an Azure Batch of Azure Virtual Machines. Other involved products include Azure Blob Storage, Azure Queue Storage, Azure Web App, Azure SQL Database, as well as Power BI.

## Solution Diagram

![Solution Diagram](https://github.com/Azure/cortana-intelligence-resource-optimization/blob/master/Manual%20Deployment%20Guide/Figures/resourceOptArchitecture.png)

</Guide>

## Technical details and workflow

1.  The sample data is streamed by newly deployed **Azure Web Jobs**. The web job uses resource related data from Azure SQL to generate the simulated data.

2.  This simulated data feeds into the **Azure Storage** and writes message in storage queue, that will be used in the rest of the solution flow.

3.  Another **Web Job** monitors the storage queue and initiate an Azure Batch job once message in queue is available.

4.  The **Azure Batch** service together with **Data Science Virtual Machines** is used to optimize the energy supply from a particular resource type given the inputs received.

4.  **Azure SQL Database** is used to store the optimization results received from the **Azure Batch** service. These results are then consumed in the **Power BI** dashboard.

6.  Finally, **Power BI** is used for results visualization.

#### Disclaimer

©2017 Microsoft Corporation. All rights reserved. This information is provided "as-is" and may change without notice. Microsoft makes no warranties, express or implied, with respect to the information provided here. Third party data was used to generate the solution. You are responsible for respecting the rights of others, including procuring and complying with relevant licenses in order to create similar datasets.
