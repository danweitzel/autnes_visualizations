# AUTNES Analysis

<p align="center">
<img src="figures/generated/alluvial_attrition.pdf" width="250">
</p>

This repository holds code and documentation of visualizations of missingness patterns due to unit and item nonresponse in the Australian National Election Study (AUTNES) panel data.

At the moment this repository holds two scripts:
1. The [autnes_na_prep.R](./scripts/autnes_na_prep.R) script, which prepares the six wave online survey of AUTNES for unit and item nonresponse analysis by implementing an NA treatment and visualizing the missingness patterns. 
2. The [autnes_variable_explore.R](./script/autnes_variable_explore.R) script, which examines the number of response categories in survey variables. A necessary first data examination before I start building the random forest model. 

*More to be released publicly soon.*

TODOS:
1. Scripts need to be updated with proper functions for their analysis. 
2. Multi-mode survey needs to be examined as well.
3. Subset of variables for random forest model needs to be selected and examined. 
4. Random forest model for unit and item nonresponse needs to be trained. 






