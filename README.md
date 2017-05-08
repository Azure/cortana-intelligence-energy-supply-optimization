Energy Resource Optimization- A Cortana Intelligence Solution How-To Guide
==========================================================================

[RL edit begins]An energy grid consists of energy consumers, as well as various
types of energy supplying, trading, and storage components: Substations accepts
power load or exports excessive power; Batteries may discharge energy or store
it for future use; Windfarms and solar panels (self-scheduled generators),
micro-turbines (dispatchable generators), and demand response bids can all be
engaged to satisfying the demand from the consumers within the grid. The costs
of soliciting different types of resources vary, while the capacities and the
physical characteristics of each resource type limits the dispatch of the
resource. Given all these constraints, a central challenge the smart grid
operator must face, is how much energy each type of the resources should commit
over a time frame, so that the forecasted energy demand from the grid are
satisfied.

This solution shows how to create an Azure-based smart solution, leveraging
external open-source tools, that determines the optimal energy unit commitments
from various types of energy resources for an energy grid. The goal is to
minimize the overall cost incurred by these commitments while satisfying the
energy demand. This solution demonstrates the ability of Azure to accommodating
external tools, such as [Pyomo](http://www.pyomo.org/) and
[CBC](https://projects.coin-or.org/Cbc), to solve large-scale numerical
optimization problems such as mixed integer-linear programming, parallelizing
multiple optimization tasks over an Azure Batch of Azure Virtual Machines.

The process described above is operationalized and deployed in the Cortana
Intelligence Suite. This solution will enable companies to ingest resource
specification data and predicted future demand, and obtain optimal resource
commitment recommendations on a regular basis. As a result, the solution drives
opportunities for improved cost for the grid under consideration.

For a discussion of the analytical approach used in this solution, see the
[Solution
Description](https://github.com/Azure/cortana-intelligence-price-optimization/blob/master/Manual%20Deployment%20Guide/Solution%20Description.md)
in the Manual Deployment Guide. [RL edit finishes]

Solution Architecture
---------------------

In this session, we provide more details about how the above analytical approach
is operationalized in Cortana Intelligence. The following chart describes the
solution architecture.

![Architecture Diagram](media/970e8fbaf0bd60afc9a65338b8cc20cd.shtml)

Architecture Diagram

### What’s Under the Hood

Raw simulated transactional data are pushed into Azure Data Lake Storage, whence
the Spark Jobs run on HDInsight Cluster will take the raw data as inputs and:

1.  Turn the unstructured raw data into structured data and aggregate the
    individual transactions into weekly sales data.

2.  Train demand forecasting model on the aggregated sales data.

3.  Run the optimization algorithm and return the optimal prices for all
    products in all competing groups.

The final results are visualized in Power BI Dashboard. The whole process is
scheduled weekly, with data movement and scheduling managed by Azure Data
Factory.

### About Implementation on Spark

A parallel version of the price optimization algorithm is implemented on Spark.
Utilizing `RDD.map()`, the independent price optimization problems for products
in different competing group can be solved in parallel, reducing runtime.

Solution Dashboard
------------------

The snapshot below shows the Power BI dashboard that visualizes the results of
demand forecasting and price optimization solution.

![Dashboard](media/39ecdcf9b2e18f48111182bd4298498d.shtml)

Dashboard

The dashboard contains four parts: 1. **Price Elasticity**: shows the
relationship between sales and price, and using the filters on the right, you
can select to view the results for a specific store, department or product. 2.
**Demand Forecasting**: shows the results and performance of the demand
forecasting model. 3. **Price Optimization** shows the profit gain realized by
using the recommended optimal price, as well as corresponding changes in sales
volume and price that resulted in the profit gain. 4. **Execution Time** shows
the time decomposition of different computational stages, allowing the user to
monitor the runtime.

Getting Started
---------------

This solution template contains materials to help both technical and business
audiences understand our demand forecasting and price optimization solution
built on [Cortana
Intelligence](https://www.microsoft.com/en-us/server-cloud/cortana-intelligence-suite/Overview.aspx).

Business Audiences
------------------

In this repository you will find a folder labeled [Solution Overview for
Business
Audiences](https://github.com/Azure/cortana-intelligence-price-optimization/tree/master/Solution%20Overview%20for%20Business%20Audiences).
This folder contains: - Walking Deck: In-depth exploration of the solution for
business audiences

For more information on how to tailor Cortana Intelligence to your needs,
[connect with one of our partners](http://aka.ms/CISFindPartner).

Technical Audiences
-------------------

See the [Manual Deployment
Guide](https://github.com/Azure/cortana-intelligence-price-optimization/blob/master/Manual%20Deployment%20Guide)
folder for a full set of instructions on how to deploy the end-to-end pipeline,
including a step-by-step walkthrough and files containing all the scripts that
you’ll need to deploy resources. **For technical problems or questions about
deploying this solution, please post in the issues tab of the repository.**
