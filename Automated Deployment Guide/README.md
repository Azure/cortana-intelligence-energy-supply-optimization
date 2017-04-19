# Energy Supply Optimization Solution

This folder contains the post-deployment instructions for the deployable Energy Supply Optimization solution in the Cortana Intelligence Gallery. To start a new solution deployment, visit the gallery page [here]().

<Guide type="PostDeploymentGuidance" url="https://github.com/Azure/cortana-intelligence-energy-supply-optimization/blob/master/Automated%20Deployment%20Guide/Post%20Deployment%20Instructions.md"/>

## <a name="Summary"></a>Summary[RL]
<Guide type="Summary">
Accurately forecasting spikes in demand for products and services can give a company a competitive advantage. The better the forecasting, the more they can scale as demand increases, and the less they risk holding onto unneeded inventory. Use cases include predicting demand for a product in a retail/online store, forecasting hospital visits, and anticipating power consumption.

This solution focuses on Supply Optimization within the energy sector. Storing energy is not cost-effective, so utilities and power generators need to forecast future power consumption so that they can efficiently balance the supply with the demand. During peak hours, short supply can result in power outages. Conversely, too much supply can result in waste of resources. Advanced demand forecasting techniques detail hourly demand and peak hours for a particular day, allowing an energy provider to optimize the power generation process. This solution using Cortana Intelligence enables energy companies to quickly introduce powerful forecasting technology into their business.
</Guide>

## <a name="Description"></a>Description[RL]

#### Estimated Provisioning Time: <Guide type="EstimatedTime">20 Minutes</Guide>
<Guide type="Description">
In this solution, we introduce new components developed upon the energy forecast solution suite. These new components implement a numerical optimization framework for determining optimal energy purchases in the eleven regions under New York state Independent System Operator administration, optimal inter-region transmissions in the twenty inter-regional interfaces, and optimal import/export power from/to Quebec, New England, PJM, and Ontario. The framework aims to minimizing the total cost in purchasing the energy from within and outside of New York state, and takes the forecasted regional demands as the targeted need to fulfill. We demonstrate the operationalized solution to a customized linear programming, hosted as a Batch Execution Service automated by Data Factory on schedule. 

This solution provides essential increments to the energy forecast solution suite, by incorporating the functionality of optimizing supply and distribution, so that the insights ingested by machine learning are directly brought to the frontier of operational planning and business decision making. 

## Solution Diagram
![Solution Diagram](https://github.com/Azure/cortana-intelligence-energy-supply-optimization/blob/master/Automated%20Deployment%20Guide/Figures/architecture.png)

## Technical details and workflow
1.	The sample data is streamed by newly deployed **Azure Web Jobs**.

2.	This synthetic data feeds into the **Azure SQL**, that will be used in the rest of the solution flow.

3.	The **Azure Machine Learning** service is used to optimize the energy supply of particular region given the inputs received.

4.	**Azure SQL Database** is used to store the optimization results received from the **Azure Machine Learning** service. These results are then consumed in the **Power BI** dashboard.

5. **Azure Data Factory** handles orchestration, and scheduling of the hourly model retraining.

6.	Finally, **Power BI** is used for results visualization.
</Guide>

#### Disclaimer

©2017 Microsoft Corporation. All rights reserved.  This information is provided "as-is" and may change without notice. Microsoft makes no warranties, express or implied, with respect to the information provided here.  Third party data was used to generate the solution.  You are responsible for respecting the rights of others, including procuring and complying with relevant licenses in order to create similar datasets.