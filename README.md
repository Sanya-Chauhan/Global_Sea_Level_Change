# Global Mean Sea Level Change Due to Global Warming
#### Time Series Analysis and Forecasting

<img width="1106" src="https://github.com/Sanya-Chauhan/Global_Sea_Level_Change/assets/116647771/10d594c7-eae8-48de-9fce-bef725bf5c4f">

## Key Concepts
- Stationarity of a Time Series Data Set
- Decomposition of Raw Data Set Using Ratio to Moving Average Method
- Mathematical Curves
- ARIMA Modeling 
- Ljung Box Test
- Forecasting

## Model Workflow
1. **Stationarity Testing:**
  - Visualizing Raw Data & 1st Differences
  - KPSS Test with p-value 0.01 implying rejection of H0 and non-stationarity in data

2. **Data Decomposition:**
  - Used Additive Model
  - Decomposed Components: Trend, Seasonality, Residual Series with Random/White Noise

    <img width="360" height="240" src="https://github.com/Sanya-Chauhan/Global_Sea_Level_Change/assets/116647771/b856e2c1-84ab-4fb4-92fb-c0fe3a9b0581">
    <img width="360" height="240" src="https://github.com/Sanya-Chauhan/Global_Sea_Level_Change/assets/116647771/b9964748-f77a-41d5-bbd6-7e774e0cbf00">

3. **Individual Component Fitting:**
  - Trend: Fitted Cubic Curve (highest adjusted R^2 of 0.991 & least MSE)
  - Seasonality: ACF and PACF Plots
  - Random Noise: ARIMA Modelling, Ljung–Box test for goodness of fit

## Forecasting
<img width="580" height="350" src="https://github.com/Sanya-Chauhan/Global_Sea_Level_Change/assets/116647771/1efbd625-00b0-4ea9-aaa9-482a50059e0a">

## Results and Inference
- The best Fit is AR(1) to forecast seasonality due to geometric decay in the ACF plot and sharp cut-off in the PACF Plot.
- Out of an overall YoY rise of 3.2 ± 0.5 mm, 1.8 ± 0.41 mm is due to Climate Change (~43%).
- The overall rise of 102.5 mm (approx. 4 inches) seen since 1993; the forecasted increase of approx. 109.6 mm till 2025 (i.e., ~ 6.9% rise in change in 4 years).

## Future Scope
- Studying regional impact analysis with the inclusion of isostatic causes.
- Extending the study to support the formulation of natural calamity action plans and better the existing understanding of their occurrences

## For more details:
- [One Page Summary](https://drive.google.com/file/d/1835-V33Aik9isA3ze79zMhQ-2tQpYQqx/view?usp=sharing)
- [Detailed Presentation](https://drive.google.com/file/d/1yu09TEgyrgKdqOIaM_CPhm5E_Exl34yX/view?usp=sharing)
