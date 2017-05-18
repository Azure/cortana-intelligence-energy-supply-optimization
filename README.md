# Energy Resource Optimization- A Cortana Intelligence Solution How-To Guide

An energy grid consists of energy consumers, as well as various types of energy supplying, trading, and storage components: Substations accepts power load or exports excessive power; Batteries may discharge energy or store it for future use; Windfarms and solar panels (self-scheduled generators), micro-turbines (dispatchable generators), and demand response bids can all be engaged to satisfying the demand from the consumers within the grid. The costs of soliciting different types of resources vary, while the capacities and the physical characteristics of each resource type limits the dispatch of the resource. Given all these constraints, a central challenge the smart grid operator must face, is how much energy each type of the resources should commit over a time frame, so that the forecasted energy demand from the grid are satisfied.

This solution shows how to create an Azure-based smart solution, leveraging external open-source tools, that determines the optimal energy unit commitments from various types of energy resources for an energy grid. The goal is to minimize the overall cost incurred by these commitments while satisfying the energy demand. This solution demonstrates the ability of Azure to accommodating external tools, such as [Pyomo](http://www.pyomo.org/) and [CBC](https://projects.coin-or.org/Cbc), to solve large-scale numerical optimization problems such as mixed integer-linear programming, parallelizing multiple optimization tasks over an Azure Batch of Azure Virtual Machines.

The process described above is operationalized and deployed in the Cortana Intelligence Suite. This solution will enable companies to ingest resource specification data and predicted future demand, and obtain optimal resource commitment recommendations on a regular basis. As a result, the solution drives opportunities for improved cost for the grid under consideration.

For a discussion of the analytical approach used in this solution, see the [Solution Description](https://github.com/Azure/cortana-intelligence-resource-optimization/blob/master/Automated%20Deployment%20Guide/Solution%20Description.md) in the Manual Deployment Guide.

## Solution Architecture


In this session, we provide more details about how the above analytical approach is operationalized in Cortana Intelligence. The following chart describes the solution architecture.

![Architecture Diagram](Manual%20Deployment%20Guide/Figures/resourceOptArchitecture.png)


### What’s Under the Hood

Simulated demand forecast, price forecast, and specifications of various typesof energy resources are produced hourly and pushed into Azure Blob Storage with a message added to Azure Storage Queue. A continuously running Webjob hosted on Azure Function monitors the queue. Upon receiving the message, the Webjob activates a Azure Batch of Data Science Virtual Machines, each of which obtains simulated data from one substation, as well as the PYOMO code and the solver pre-stored in Azure Blob Storage. The pool of VMs execute the optimization in parallel, and push the results into Azure SQL Database before they shut down. The results in the database are visualized by PowerBI.

## Solution Dashboard

The snapshot below shows the Power BI dashboard that visualizes the results of
the energy resource optimization solution.

![Dashboard](Manual%20Deployment%20Guide/Figures/PowerBI-11.png)


The dashboard contains two tabs. The first tab shows the inputs to the optimization, including load forecast for each substation, price forecasts for different types of resources, as well as the wind-farm and solar generation forecast. The second tab shows the results of the optimization, including the optimal substation load, optimal substation sale, optimal generation for demand responses and dispatchables (micro-turbines), battery charge or discharge, as well as a comparison of costs between the optimal solution and a baseline
solution.

## Getting Started

This solution template contains materials to help both technical and business audiences understand our energy resource optimization solution built on [Cortana Intelligence](https://www.microsoft.com/en-us/server-cloud/cortana-intelligence-suite/Overview.aspx).

## Business Audiences

In this repository you will find a folder labeled [Solution Overview for Business Audiences](https://github.com/Azure/cortana-intelligence-resource-optimization/tree/master/Solution%20Overview%20for%20Business%20Audiences).
This folder contains: - Walking Deck: In-depth exploration of the solution for business audiences

For more information on how to tailor Cortana Intelligence to your needs, [connect with one of our partners](http://aka.ms/CISFindPartner).

## Technical Audiences


See the [Manual Deployment Guide](https://github.com/Azure/cortana-intelligence-resource-optimization/tree/master/Manual%20Deployment%20Guide) folder for a full set of instructions on how to deploy the end-to-end pipeline, including a step-by-step walkthrough and files containing all the scripts that you’ll need to deploy resources. **For technical problems or questions about deploying this solution, please post in the issues tab of the repository.**
