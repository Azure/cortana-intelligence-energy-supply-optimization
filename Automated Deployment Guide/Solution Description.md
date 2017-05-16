# The Mathematical Model and Solution

## The Mathematical Model

The energy resource optimization problem boils down to a mixed integer-linear programming (MILP) problem, one of the most widely used mathematical optimization models in industry. Given a time horizon over which the model aims to optimize, the model accepts the forecasted demand, forecasted self-scheduled generation, and forecasted prices (costs) for substation inward load, substation outward sale, battery generation, batter charge, demand response generation, as well as dispatchable generation. The model must also consider various physical and business constraints to which each type of the resources must comply. The model then computes the amounts of the substation load or sale, battery generation or charge, demand response generation, and dispatchable generation that yields the minimum cost in fulfilling the demand. Overall, the model contains a mixed integer-linear objective function, and a number of integer-linear constraints, whose exact amount is determined by the amounts of the resources.

## The Solution to the Model

The MILP is solved by an open-source solver CBC, which may be replaced by other appropriate open-source or proprietary software too. To ease the transformation of the mathematical model into the foramt that the solver accepts, an open-source interface software PYOMO is employed. PYOMO enables the user to code the objectve and constraints in an "what-you-see-is-what-you-get" manner in python language, and automatically translates the python code into the format that CBC optimizer can consume. In the optimization job script "der_optimization_task.py", look for the main procedure DEROPTMODEL(), in which the MILP is described in python lanaguge and PYOMO syntax.

The job script, together with the solver cbc.exe, as well as PYOMO installer, are replicated onto each node of the Azure Patch pool of Data Science Virtual Machines when input data and message are detected. The nodes will then run the optimization jobs in parallel.
