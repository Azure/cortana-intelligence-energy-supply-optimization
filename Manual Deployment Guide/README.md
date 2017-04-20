# Energy Supply Optimization Solution in Cortana Intelligence Suite

## Table of Contents  
- [Abstract](#abstract)  
- [Requirements](#requirements)
- [Architecture](#architecture)
- [Setup Steps](#setup-steps)
- [Validation and Results](#validation-and-results)

## Abstract[RL]
This solution focuses on demand forecasting within the energy sector. Storing energy is not cost-effective, so utilities and power generators need to forecast future power consumption so that they can efficiently balance the supply with the demand. During peak hours, short supply can result in power outages. Conversely, too much supply can result in waste of resources. Advanced demand forecasting techniques detail hourly demand and peak hours for a particular day, allowing an energy provider to optimize the power generation process. This solution using Cortana Intelligence enables energy companies to quickly introduce powerful forecasting technology into their business.

This solution combines several Azure services to provide powerful advantages. Event Hubs collects real-time consumption data. Stream Analytics aggregates the streaming data and makes it available for visualization. Azure SQL stores and transforms the consumption data. Machine Learning implements and executes the forecasting model. Power BI visualizes the real-time energy consumption as well as the forecast results. Finally, Data Factory orchestrates and schedules the entire data flow.


The published [Energy Demand Forecast Solution](https://go.microsoft.com/fwlink/?linkid=831187) provides one-click deployment of an energy demand forecast solution in Cortana Intelligence Suite. Advanced analytics solution implementers, i.e. Data Scientists and Data Engineers, usually need deeper understanding of the template components and architecture in order to use, maintain, and improve the solution. This documentation provides more details of the solution and step-by-step deployment instructions. Going through this manual deployment process will help implementers gain an inside view on how the solution is built and the function of each component.

## Requirements[PS]

You will need the following accounts and software to create this solution:

- Source code and instructions from this GitHub repo

- A [Microsoft Azure subscription](<https://azure.microsoft.com/>)

- A Microsoft Office 365 subscription for Power BI access

- A network connection

- [SQL Server Management Studio](<https://msdn.microsoft.com/en-us/library/mt238290.aspx>), [Visual Studio](<https://www.visualstudio.com/en-us/visual-studio-homepage-vs.aspx>), or another similar tool to access a SQL server database.

- [Microsoft Azure Storage Explorer](<http://storageexplorer.com/>)

- [Power BI Desktop](<https://powerbi.microsoft.com/en-us/desktop>)

It will take about one day to implement this solution if you have all the required software/resources ready to use. 

## Architecture
![](Figures/resourceOptArchitecture.png)

The figure above shows the overall architecture of the Energy Resource Optimization solution.

- The data is simulated from **Azure Web Jobs** and feeds into the **Azure SQL Database**.

- **Azure Batch** service is used to optimize the energy supply of particular region given the inputs received.

- **Azure SQL Database** is used to store the prediction results received from the **Azure Machine Learning** service.

- Finally, **Power BI** is used for results visualization.

This architecture is an example that demonstrates one way of building energy supply optimization solution in Cortana Intelligence Suite. User can modify the architecture and include other Azure services based on different business needs.

## Setup Steps
This section walks the readers through the creation of each of the Cortana Intelligence Suite services in the architecture defined in Figure 1.
As there are usually many interdependent components in a solution, Azure Resource Manager enables you to group all Azure services in one solution into a [resource group](https://azure.microsoft.com/en-us/documentation/articles/resource-group-overview/#resource-groups). Each component in the resource group is called a resource.
We want to use a common name for the different services we are creating. The remainder of this document will use the assumption that the base service name is:

energyopttemplate\[UI\]\[N\]

Where \[UI\] is the users initials and N is a random integer that you choose. Characters must be entered in in lowercase. Several services, such as Azure Storage, require a unique name for the storage account across a region and hence this format should provide the user with a unique identifier.
So for example, Steven X. Smith might use a base service name of *energyopttemplatesxs01*  

**NOTE:** We create most resources in the South Central US region. The resource availability in different regions depends on your subscription. When deploying you own resources, make sure all data storage and compute resources are created in the same region to avoid inter-region data movement. Azure Resource Group don’t have to be in the same region as the other resources. Azure Resource Group is a virtual group that groups all the resources in one solution.

### 1. Create a new Azure Resource Group

  - Navigate to ***portal.azure.com*** and log in to your account

  - On the left tab click ***Resource Groups***

  - In the resource groups page that appears, click ***Add***

  - Provide a name ***energyopttemplate\_resourcegroup***

  - Select a ***location***. Note that resource group is a virtual group that groups all the resources in one solution. The resources don’t have to be in the same location as the resource group itself.

  - Click ***Create***

### 2. Setup Azure Storage account

An Azure Storage account is used by the Azure Machine Learning workspace.

  - Navigate to ***portal.azure.com*** and log in to your account.

  - On the left tab click ***+ (New) > Storage > Storage Account***

  - Set the name to ***energyopttemplate[UI][N]***

  - Change the ***Deployment Model*** to ***Classic***

  - Set the resource group to the resource group we created by selecting the radio button ***Use existing***

  -  Location set to South Central US

  - Click ***Create***

  - Wait for the storage account to be created

Now that the storage account has been created we need to collect some information about it for other services like Azure Data Factory.

  - Navigate to ***portal.azure.com*** and log in to your account

  - On the left tab click Resource Groups

  - Click on the resource group we created earlier ***energyopttemplate_resourcegroup***. If you don’t see the resource group, click ***Refresh***

  - Click on the storage account in Resources

  - In the Settings tab on the right, click ***Access Keys***

  - Copy the PRIMARY CONNECTION STRING and add it to the table below

  - Copy the Primary access key and add it to the table below

    | **Azure Storage Account** |                     |
    |------------------------|---------------------|
    | Storage Account Name       |energyopttemplate\[UI][N]|
    | Connection String      |             |
    | Primary access key     |             ||

### 3. Setup Azure SQL Server and Database

In this step, we will create an Azure SQL Database to store “actual” demand data generated by the data generator and forecasted demand data generated by Azure Machine Learning experiment. The data in Azure SQL Database are consumed by Power BI to visualize optimize results and performance.

#### Create Azure SQL Server and Database

- Navigate to ***portal.azure.com*** and login in to your account

- On the left tab click ***+ (New) > Databases > SQL Database***

- Enter the name ***energyopttemplatedb*** for the database name

- Choose the resource group previously created ***energyopttemplate_resourcegroup***

- Under Server click the arrow and choose ***Create new server***
    - Name : energyopttemplate\[UI][N]

    - Enter in an administrator account name and password and save it to the table below.

    - Choose South Central US as the location to keep the SQL database in the same region as the rest of the services.

    - Click **Select**

- Once returned to the SQL Database tab, click ***Create***

- Wait for the database and server to be created. This may take few minutes.

- From ***portal.azure.com***, click on Resource Groups, then the group for this demo ***energyopttemplate_resourcegroup***.

- In the list of resources, click on the SQL Server that was just created.

- Under ***Settings*** for the new server, click ***Firewall*** and create a rule called ***open*** with the IP range of 0.0.0.0 to 255.255.255.255. This will allow you to access the database from your desktop. Click ***Save.***

    **Note**: This firewall rule is not recommended for production level systems but for this demo is acceptable. You will want to set this rule to the IP range of your secure system.

| **Azure SQL Database** |                     |
|------------------------|---------------------|
| Server Name            |energyopttemplate[UI][N]|
| Database               |energyopttemplatedb|
| User Name              |                     |
| Password               |                     ||


### 4. Create a Batch account 
Azure Batch is a platform service for running large-scale parallel and high-performance computing (HPC) applications efficiently in the cloud. In this solution we will use Azure Batch to run the optimization model.

- Navigate to ***portal.azure.com*** and login in to your account

- Click **New** > **Compute** > **Batch Service**.

- The **New Batch Account** blade is displayed. See the descriptions below of each blade element.
     
  - **Account name**: ***energyopttemplate\[UI][N]***.
   
  - **Subscription**: Select the Subscription in which you have created resoures from step 1, 2 and 3.

  - **Pool allocation mode**: Select **Batch service**.
   
  - **Resource group**: Select **Use existing** and choose the resource group previously created ***energyopttemplate\_resourcegroup***.
   
  - **Location**: Choose South Central US as the location.
   
  - **Storage account** (optional): Click on Storage account. In the newly opened blade, select the Storage account we created in step 2. 

- Click **Create** to create the account.
   
   The portal indicates deployment is in progress. Upon completion, a **Deployments succeeded** notification appears in **Notifications**. Now that the Azure Batch account has been created we need to collect some information about.

- Navigate to ***portal.azure.com*** and log in to your account.

- On the left tab click Resource Groups.

- Click on the resource group we created earlier ***energyopttemplate_resourcegroup***. If you don’t see the resource group, click ***Refresh***.

- Click on the Azure Batch account in Resources.

- Under **Overview**, copy the URL displayed on the top of the new blade and save it in table below .

- Under Settings on left panel, go to **Keys**. Copy **Primary access key** and save it in table below. 


| **Azure SQL Database** |                     |
|------------------------|---------------------|
| Batch Account Name         |energyopttemplate\[UI][N]|
| Batch Primary Access Key   |\<Primary Access Key>|
| Batch Url              |                     ||


### 5. Setup Azure Web Job/Data Generator

In this step, we will create Azure Web App Server to run several Web Jobs including the Data Generator Web Jobs and few others.

#### 1) Create App Service and Service Plan
- Navigate to ***portal.azure.com*** and login in to your account.

- On the left tab click ***+ New > Web + Mobile > Web App***.

- Enter the name ***energyopttemplate\[UI][N]*** for the Web App name.

- Choose the resource group previously created ***energyopttemplate\_resourcegroup***.

- Under App Service plan click the arrow and choose ***Create New***.

    -   Name : energyopttemplate\[UI\]\[N\].

    -   Choose South Central US as the location to keep the Web App in the same region as the rest of the services.

    -   Click ***Ok***.

- On the Web App tab > App Insights, click ***On***.

- Click ***Create***.

- Wait for the Web App to be created.

#### 2) Update App Service Settings

- We need to set up the Application Service settings which our web jobs will utilize.

- From ***portal.azure.com,*** click on ***Resource Groups,*** then the group for this demo ***energyopttemplate\_resourcegroup.***

- In the list of resources, click on the Web App (App Service) that was just created.

- In the Web App (App Service), go to ***Settings > Application Settings***.

- Under ***General settings*** section, find ***Always On*** and turn it to ***On***. This setting is to make sure that the data simulator keeps running.

- Under ***App settings*** you will find two empty columns named ***Key*** and ***Value***.

    -   Enter following key value in the App Settings.

        | **Azure App Service Settings** |             |
        |------------------------|---------------------|
        | Key                    | Value               |
        | DB_SVR             |energyopttemplate[UI][N].database.windows.net|
        | DB_NAME           |energyopttemplatedb     |
        | DB_USR_NAME               | \<SQL Server user name>|
        | DB_PWD           |\<SQL Server password> |
        | BATCH_ACCT_NAME            |\<Batch Account Name from Step 4> |
        | BATCH_KEY            |\<Batch Primary Access Key from Step 4> |
        | BATCH_ACCT_URL           |\<Batch Url from Step 4> |
        | STORAGE_ACCT           |\<Storage Account Name from Step 2> |
        | STORAGE_KEY           |\<Primary access key from Step 2> |
        | BATCH_APP_CONTAINER           |batchappfiles |
        | BATCH_DATA_CONTAINER           |batchdatafiles |
        | INCOMING_MSG         |incomingmessages |
        | INCOMING_DATA         |incomingdatafiles |


- Click ***Save*** on top of the page to save the settings

#### 6) Upload Data Generator Web Job
[RL:- Add description of two Data Generator]
We need to upload the web jobs which will generate the simulated energy data and also a web job to load historic weather/Energy Demand data into SQL Database. We have three web jobs. Web Job **CreateTablesInDB** creates tables, views and stored procedures that will be used by Azure Data Factory. We will more explain more details of the database objects in the Azure Data Factory section as they are closely related. It also loads the historic weather and energy demand data into **DemandHistory5Minutes** and **WeatherHourly**. The WebJob **FiveMinsDataToSQL** simulates energy consumption data and sends it to Azure SQL table **DemandHistory5Minutes** every 5 minutes. It also writes the execution log of the web job into **DemandHistory5Minutes\_SQLLog**, which helps to track failed jobs. Similarly, WebJob **WeatherHourlyDataToSQL** simulates weather data and sends it to Azure SQL table **WeatherHourly** every hour. It also writes corresponding run logs into **WeatherHourly\_SQLLog**.  

- Once you return to the App Service tab save, click on ***WebJobs*** under ***Settings***.

##### 1) Add ExecuteSqlQuery Web Job
- Click ***Add*** on top to upload the PastData job zip and provide following details:

     - Name : ExecuteSqlQuery

      - File Upload : browse to the directory where you downloaded the resource. Go to [*Data Generator*](Data Generator/) and select ***ExecuteSqlQuery.zip***.

      - Type : Triggered

      - Triggers : Manual

      - Click ***Ok***

- Wait till the web job is added, then click refresh

- Once you see the web job ***ExecuteSqlQuery*** in the list, select it and click ***Run*** on the top of that tab

- Wait till the STATUS changes to Completed

##### 2) Add EnergyOptSimulateHourly Web Job
- Click ***Add*** on top to upload the Energy data generator job zip and provide following details:

     - Name : EnergyOptSimulateHourly

      - File Uplaod : browse to the directory where you downloaded the resource. Go to [*Data Generator*](Data Generator/) and select ***energyopt_simulate_hourly.zip***

      - Type : Triggered

      - Triggers : Manual

      - Click ***Ok***

- Wait till the web job is added, then click refresh

- Once you see the web job ***EnergyOptSimulateHourly*** in the list, select it and click ***Run*** on the top of that tab

- Wait till the STATUS changes to Completed

### 7. Setup Power BI
The essential goal of this part is to get the optimization results and visualize it. Power BI can directly connect to an Azure SQL database as its data source, where the prediction results are stored.

> Note:  1) In this step, the prerequisite is to download and install the free software [Power BI desktop](https://powerbi.microsoft.com/desktop). 2) We recommend you start this process 2-3 hours after you finish deploying the ADF pipelines so that you have more data points to visualize.

#### 1) Get the database credentials.

  You can get your database credentials from the previous steps when you setting up the SQL database.

#### 2)	Update the data source of the Power BI file

  -  Make sure you have installed the latest version of [Power BI desktop](https://powerbi.microsoft.com/desktop).

  -	In this GitHub repository, you can download the **'EnergyOptPowerBI.pbix'** file under the folder [*Power BI*](Power BI/) and then open it. **Note:** If you see an error massage, please make sure you have installed the latest version of Power BI Desktop.

  -  Follow the instruction provided [here](Power BI/PowerBIHowTo.pdf) to import the template and create/publish your own PowerBI Dashboard. 


### Check Data in SQL Database
- Launch [SQL Server Management Studio](https://msdn.microsoft.com/en-us/library/mt238290.aspx)(SSMS), Visual Studio, or a similar tool, and connect to the database with the information you recorded in the table below.

    -   NOTE: The server name in most tools will require the full name:  
    energyopttemplate\[UI\]\[N\].database.windows.net,1433

    -   NOTE: Choose SQL Server Authentication

    -   From the dropdown list of Databases on the left panel under Object Explorer, select ***energyopttemplatedb*** that you created on the server

    -   Right click on the selected database and expand the tables

    -   Expand the Table and run queries to get better understanding of data
