# Brain Volume, Mental State Examination, and Education Attainment as Possible Diagnostic Predictors for Alzheimer's Disease

## Project Summary:

Alzheimer’s disease is a debilitating condition associated with neuroinflammation and advanced age. According to a 2022 CDC report, the prevalence of diagnosed dementia among adults aged 65 and older is 1.7% ([Kramarow, 2024](https://pubmed.ncbi.nlm.nih.gov/38912900/)). This rate increases with age and decreases with higher educational attainment, suggesting that the condition may disproportionately impact senior citizens in disadvantaged and marginalized communities, as educational attainment is moderately to strongly correlated with Socioeconomic Status (SES) ([Sirin, 2005](https://journals.sagepub.com/doi/10.3102/00346543075003417); [Steptoe & Zaninotto, 2020](https://www.pnas.org/doi/10.1073/pnas.1915741117); [Cheng et al., 2025](https://www.sciencedirect.com/science/article/pii/S1569490925000140?via%3Dihub)).  

Currently, no single test can definitively confirm the onset of Alzheimer’s Disease (AD) except through post-mortem brain analysis. However, early detection of AD is improving with advanced clinical evaluations, including medical history, cognitive testing, brain imaging, and biomarker tests. To better understand how these diagnostic features aid in Alzheimer’s detection, this data analysis develops a machine learning model (K-Nearest Neighbors Classification) using the variables (1) total brain volume, (2) Mini-Mental State Examination score, and (3) educational attainment to examine their predictive accuracy in dementia diagnosis. 

## Data Usage: **OASIS-2 Dataset**
This project uses the **OASIS-2 Longitudinal Dementia Dataset**, which is freely available to the public for study and analysis.
The dataset is sourced from the [Open Access Series of Imaging Studies (OASIS)](http://www.oasis-brains.org/). 

> **Please cite the dataset according to the original authors**:

- Marcus, D. S., Fotenos, A. F., Csernansky, J. G., Morris, J. C., & Buckner, R. L. (2009). Open Access Series of Imaging Studies (OASIS): Longitudinal MRI Data in Nondemented and Demented Older Adults. Journal of Cognitive Neuroscience.

## Reproducibility--Running the Analysis in a Containerized R Environment:

## Dependencies:

## Licences

<p xmlns:cc="http://creativecommons.org/ns#" >The analysis reports in this repository are licensed under <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)    <img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1" alt=""></a></p>

The code base in this repository (e.g., R scripts, Makefile) is licensed separately under the [MIT License](https://github.com/yvinc/AlzheimerKNN-Diag/blob/main/LICENSE-MIT.md) unless otherwise specified.
