# Sensor Fusion Self-Driving Car Course - Radar Exercises

Those are small exercise implemented before Programming Assignment

### Project Status:

![issue_badge](https://img.shields.io/badge/build-Passing-green) ![issue_badge](https://img.shields.io/badge/UdacityRubric-Passing-green)


## Dependencies for Running Locally
*  Matlab & Additional Toolboxes : You'll gonna need few Matlab Toolboxes those are in below.

<img width="491" alt="toolboxes" src="https://user-images.githubusercontent.com/12381733/77243651-e0ebfe00-6c4f-11ea-82ba-b35ca38b9345.png">

---

### Project Overview 

---

### Radar Range Equation

Using the Radar Range equation we can design the radar transmitter, receiver, and antenna to have the desired power, gain and noise performance to meet the range requirements.

A long range radar designed to cover 300m range and detect a target with smaller cross section would need higher transmit power and more antenna gain as compared to a short range radar designed to cover just 50m for similar target. 

A target with higher cross section can be detected at a longer range as compared to a target with smaller cross section.

<img width="810" alt="radar_equation" src="https://user-images.githubusercontent.com/12381733/77243730-8acb8a80-6c50-11ea-93ab-8157f4a56f20.png">

#### 

---

### Range Estimation

<img width="806" alt="range_estimation" src="https://user-images.githubusercontent.com/12381733/77243770-25c46480-6c51-11ea-9d5a-4b7322879c07.png">

Calculate the trip time and the Range from Radar to Objects with given factors (FMCW waveform factor, Beat Frequency, Radar maximum range, Radar Range resolution)

<img width="780" alt="range_equation_2" src="https://user-images.githubusercontent.com/12381733/77243883-6f617f00-6c52-11ea-813a-23ef281fec2a.png">


### Doppler Estimation

Calculate the velocity of the targets using Doppler Effect with given factors (doppler frequency shifts, FMCW frequency)

### Fast Fourier Transform Exercise

<img width="672" alt="FFT" src="https://user-images.githubusercontent.com/12381733/77251013-27ad1880-6c8f-11ea-857d-f6c608797d06.png">

This project uses a Fourier transform to find the frequency components of a signal buried in noise. 

**Here's few steps for 1st stage FFT **

1. Define a signal. In this case (amplitude = A, frequency = f)

```matlab
signal = A*cos(2*pi*f*t)
```

2. Run the fft for the signal using MATLAB fft function for dimension of samples N.

```matlab
signal_fft = fft(signal,N);
```

3. The output of FFT processing of a signal is a complex number `(a+jb)`. Since, we just care about the magnitude we take the absolute value `(sqrt(a^2+b^2))` of the complex number.

```matlab
signal_fft = abs(signal_fft);
```

4. FFT output generates a mirror image of the signal. But we are only interested in the positive half of signal length L, since it is the replica of negative half and has all the information we need.

```matlab
signal_fft  = signal_fft(1:L/2-1)       
```

5. Plot this output against frequency.

### 2D Fast Fourier Transform Exercise

The output of Range Doppler response represents an image with Range on one axis and Doppler on the other. This image is called as `Range Doppler Map (RDM)` These maps are often used as user interface to understand the perception of the targets.

<img width="672" alt="2D_FFT" src="https://user-images.githubusercontent.com/12381733/77251288-e453a980-6c90-11ea-85bc-05aba71b8078.png">

**Here's few steps for 2D stage FFT **

1. Take a 2D signal matrix

2. In the case of Radar signal processing. Convert the signal in MxN matrix, where M is the size of Range FFT samples and N is the size of Doppler FFT samples

```matlab
signal  = reshape(signal, [M, N]);
```

3. Run the 2D FFT across both the dimensions.
```matlab
signal_fft = fft2(signal, M, N);
```

4. Shift zero-frequency terms to the center of the array
```matlab
signal_fft = fftshift(signal_fft);
```

5. Take the absolute value
```matlab
signal_fft = abs(signal_fft);
```

6. Here since it is a 2D output, it can be plotted as an image. Hence, we use the imagesc function
```matlab
imagesc(signal_fft);
```

---

### Reference

* [MatWorks - 2D FFT](https://kr.mathworks.com/help/matlab/ref/fft2.html)
* [Radar Tutorial](https://www.radartutorial.eu/index.en.html)
* [Udacity Sensor Fusion Nanodegree](https://www.udacity.com/course/sensor-fusion-engineer-nanodegree--nd313)

