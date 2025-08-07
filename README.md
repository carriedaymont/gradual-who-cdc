# gradual-who-cdc
**Description**: Growth charts that gradually transition from WHO to CDC values from 2 to 5 years. Files available for download: printable charts and tables as well as data tables, code and further instructions for implementation.

**Background**: When evaluating growth in children, the CDC recommends switching between the WHO 2006 Growth Standards and the 2000 CDC Growth Reference at 2 years of age. There is a significant discontinuity between these growth charts at this age. We created growth charts that make the transition from WHO to CDC gradually and smoothly from 2 to 5 years.

**Please refer to the publication below for more information. Please cite this publication whenever using these charts in your work**<br />
Daymont et al., Pediatrics, 2025  (citation details to come when available)

This repository contains:

**Printable percentile charts**<br />
-These are available in a single PDF named percentile-charts-print-gradual.<br />
-They are available for 3 overlapping age groups: 0-36 months, 1-6 years, and 2-20 years.<br />
-As noted in the publication, you will see a small jump in the length/height and BMI charts at 2 years. Before 2 years, the charts are based on length, and after 2 years they are based on height. Two-year-olds are 0.7-0.8 cm longer than they are tall. <br />

**Printable data tables**<br />
-This is a PDF named table-print-gradual<br />
-Selected percentiles are available by month for 2-5 years, the ages for which the gradual charts differ from both the WHO and CDC charts.<br />

**Data tables, code, and instructions for analysis and EHR integration**<br />
-The data tables are compressed .csv files. The file names are datatable-gradual-months and datatable-gradual-days. <br />
-See separate documents titled further-info-gradual-[date] and equation-gradual.pdf for further information about the tables, code, and implementation.<br />
-A short R function and Stata do-file are provided that will create gradual z-scores from WHO and CDC z-scores.<br />

The files are available for download and may be used in clinical care and research, including integration into EHRs. 

If you have additional questions about the growth charts, equation, or how to use these files or the growth charts, or if you notice any issues with the files, please email me at cdaymont@pennstatehealth.psu.edu.  
