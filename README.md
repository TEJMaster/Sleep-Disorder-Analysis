## Decoding Sleep Disorders Through Self-Reported Patterns
This repository hosts the project "Decoding Sleep Disorders Through Self-Reported Patterns", which examines the relationship between reported sleep patterns and the self-reported incidence of sleep troubles. Utilizing data from the National Health and Nutrition Examination Survey (NHANES) for the years 2017 to March 2020, this study analyzes variables related to sleep duration, snoring frequency, daytime sleepiness, and reported sleep troubles. The aim is to identify potential predictors of sleep disorders and contribute to the understanding of sleep health in the population.

Throughout this project, findings from the analysis are expected to provide valuable insights into the factors associated with sleep troubles, which could inform healthcare practices and public health policies. Advanced statistical techniques, including logistic regression, are employed to model the relationship between sleep behaviors and the likelihood of reporting sleep troubles to a doctor.

### LLM Usage
In the creation of this project, OpenAI's ChatGPT was utilized to assist in the formulation of research questions, data analysis, and interpretation of results. The complete conversation with ChatGPT can be found in `other/llm/chat_with_chatGPT.txt`, detailing the contributions of ChatGPT to this project.

### Repository Structure
The repository is organized to ensure ease of access and reproducibility:

- `data/`: Contains the dataset used in the project. The raw NHANES sleep data, P_SLQ.XPT, is located in `data/raw_data`. The cleaned dataset is stored in `data/analysis_data`.
- `models/`: Stores the logistic regression model developed for this study.
- `other/`: Holds miscellaneous components used in project creation, such as LLM usage records and additional notes.
- `paper/`: Contains the research paper and related documents, including the introduction, data description, and analysis results.
- `scripts/`: Includes R scripts used for data cleaning, analysis, and visualization in the project.

By providing a comprehensive and structured repository, this project aims to contribute to the ongoing research on sleep health and facilitate future studies in this important area.
