# Energy Supply Optimization Solution

This document is focusing on the post deployment instructions for the automated deployment through [Cortana Intelligence Solutions](https://gallery.cortanaintelligence.com/solutions). The source code of the solution as well as manual deployment instructions can be found [here](https://github.com/Azure/cortana-intelligence-resource-optimization/tree/master/Manual%20Deployment%20Guide).

# Architecture
The architecture diagram shows various Azure services that are deployed by [Energy Supply Optimization Solution]() using [Cortana Intelligence Solutions](https://gallery.cortanaintelligence.com/solutions), and how they are connected to each other in the end to end solution.

![Solution Diagram](Figures/resourceOptArchitecture.png)


1.	The sample data is streamed by newly deployed **Azure Web Jobs**.

2.	This synthetic data feeds into the **Azure SQL**, that will be used in the rest of the solution flow.

3.	The **Azure Machine Learning** service is used to optimize the energy supply of particular region given the inputs received.

4.	**Azure SQL Database** is used to store the optimization results received from the **Azure Machine Learning** service. These results are then consumed in the **Power BI** dashboard.

5. **Azure Data Factory** handles orchestration, and scheduling of the hourly model retraining.

6.	Finally, **Power BI** is used for results visualization.

All the resources listed above besides Power BI are already deployed in your subscription. The following instructions will guide you on how to monitor things that you have deployed and create visualizations in Power BI.

# Post Deployment Instructions
Once the solution is deployed to the subscription, you can see the services deployed by clicking the resource group name on the final deployment screen in the CIS.

This will show all the resources under this resource groups on [Azure management portal](https://portal.azure.com/).

After successful deployment, the entire solution is automatically started on cloud. You can monitor the progress from the following resources.

## **Monitor progress**

#### Web Jobs
6 Azure Web jobs are created during the deployment. You can monitor the web jobs by clicking the link on your deployment page.
* One-time running web jobs are used to start certain Azure services.
  * CreateTablesInDB: Create required tables in Azure SQL.
  * GalleryToMLSvc: Creates energy supply optimization ML experiment and publish it as ML WebService.
  * StartPipelines: Starts the Azure Data Factory pipelines.
* Continuous running web jobs are used as data generator.
  * EnergyOptSimulateHourly: [RL].
  * EnergyOptSimulateDaily: [RL].

#### Azure Data Factory

Azure Data Factory is used to schedule machine learning model. You can monitor the data pipelines by clicking the link on your deployment page.

*Note: The Web Jobs need time to finish the first run. It is normal to see errors in your Azure Data Factory pipelines right after you deployed the solution.*

#### Azure SQL Database

Azure SQL database is used to save the data and forecast results. You can use the SQL server and database name showing on the last page of deployment with the username and password that you set up in the beginning of your deployment to log in your database and check the results.

#### Azure Machine Learning Web Service

You can view your forecasting model on machine learning experiment by navigating to your Machine Learning Workspace. The machine learning model is deployed as Azure Web Service to be scheduled every hour for retraining by the Azure Data Factory. You can view your the web service API manual by clicking the link on your deployment page.

## **Visualization**
Power BI dashboard can be used to visualize the real-time energy consumption data as well as the updated energy forecast results. The following instructions will guide you to build a dashboard to visualize data from database and from real-time data stream.


### Visualize Energy Data from Database

The essential goal of this part is to get the optimization results and visualize it. Power BI can directly connect to an Azure SQL database as its data source, where the prediction results are stored.

> Note:  1) In this step, the prerequisite is to download and install the free software [Power BI desktop](https://powerbi.microsoft.com/desktop). 2) We recommend you start this process 2-3 hours after you finish deploying the ADF pipelines so that you have more data points to visualize.

#### 1) Get the database credentials.

  You can get your database credentials from the previous steps when you setting up the SQL database.

#### 2)	Update the data source of the Power BI file

  -  Make sure you have installed the latest version of [Power BI desktop](https://powerbi.microsoft.com/desktop).

  -	In this GitHub repository, you can download the **'EnergyOptPowerBI.pbix'** file under the folder [*Power BI*](Power BI/) and then open it. **Note:** If you see an error massage, please make sure you have installed the latest version of Power BI Desktop.

  -  Follow the instruction provided [here](Power BI/PowerBIHowTo.pdf) to import the template and create/publish your own PowerBI Dashboard. 


## **Customization**
You can reuse the source code in the [Manual Deployment Guide](https://github.com/Azure/cortana-intelligence-energy-supply-optimization/tree/master/Manual%20Deployment%20Guide) to customize the solution for your data and business needs.
