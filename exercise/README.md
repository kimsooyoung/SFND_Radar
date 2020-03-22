html header: <script type="text/javascript"  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# Sensor Fusion Self-Driving Car Course - Radar Exercises

Those are small exercise implemented before Programming Assignment

### Project Status:

![issue_badge](https://img.shields.io/badge/build-Passing-green) ![issue_badge](https://img.shields.io/badge/UdacityRubric-Passing-green)


## Dependencies for Running Locally
*  Matlab & Additional Toolboxes : You'll gonna need few Matlab Toolboxes those are in below.

<img width="491" alt="toolboxes" src="https://user-images.githubusercontent.com/12381733/77243651-e0ebfe00-6c4f-11ea-82ba-b35ca38b9345.png">

---

### Project Overview 

#### Radar Range Equation

Using the Radar Range equation we can design the radar transmitter, receiver, and antenna to have the desired power, gain and noise performance to meet the range requirements.

A long range radar designed to cover 300m range and detect a target with smaller cross section would need higher transmit power and more antenna gain as compared to a short range radar designed to cover just 50m for similar target. 

A target with higher cross section can be detected at a longer range as compared to a target with smaller cross section.

<img width="810" alt="radar_equation" src="https://user-images.githubusercontent.com/12381733/77243730-8acb8a80-6c50-11ea-93ab-8157f4a56f20.png">

#### 

---

#### Range Estimation

<img width="806" alt="range_estimation" src="https://user-images.githubusercontent.com/12381733/77243770-25c46480-6c51-11ea-9d5a-4b7322879c07.png">

The FMCW waveform has the characteristic that the frequency varies linearly with time. If radar can determine the delta between the received frequency and hardware’s continuously ramping frequency then it can calculate the trip time and hence the range. We further divide Range estimate by 2, since the frequency delta corresponds to two way trip.

It is important to understand that if a target is stationary then a transmitted frequency and received frequency are the same. But, the ramping frequency within the hardware is continuously changing with time. So, when we take the delta (beat frequency) between the received and ramping frequency we get the trip time.

