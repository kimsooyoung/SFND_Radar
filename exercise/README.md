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

---

### Doppler Estimation

---

Calculate the velocity of the targets using Doppler Effect with given factors (doppler frequency shifts, FMCW frequency)

---

### Fast Fourier Transform Exercise

<img width="400" alt="FFT" src="https://user-images.githubusercontent.com/12381733/77251013-27ad1880-6c8f-11ea-857d-f6c608797d06.png">

This project uses a Fourier transform to find the frequency components of a signal buried in noise. 

#### Here's few steps for 1st stage FFT

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

---

### 2D Fast Fourier Transform Exercise

The output of Range Doppler response represents an image with Range on one axis and Doppler on the other. This image is called as `Range Doppler Map (RDM)` These maps are often used as user interface to understand the perception of the targets.

<img width="400" alt="2D_FFT" src="https://user-images.githubusercontent.com/12381733/77251288-e453a980-6c90-11ea-85bc-05aba71b8078.png">

#### Here's few steps for 2D stage FFT

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

### 1D CFAR Exercise

<img width="400" alt="1D_CFAR" align="left" src="https://user-images.githubusercontent.com/12381733/77251944-c1c38f80-6c94-11ea-94fa-962138c09355.png">
<img width="400" alt="1D_CFAR2" align="center" src="https://user-images.githubusercontent.com/12381733/77251952-c8520700-6c94-11ea-93d6-ea3877f5d13b.png">


Implement 1D CFAR using lagging cells on the given noise and target scenario.

You must first get used to the terms before dig into `CA-CFAR` exercises.

**T** : _Number of Training Cells_

**G** : _Number of Guard Cells_

**N** : _Total number of Cells_

#### And, Here's few steps for CFAR implementation

1. Define the number of training cells and guard cells
2. Start sliding the window one cell at a time across the complete `FFT 1D` array. Total window size should be: `2(T+G)+CUT`
3. For each step, sum the signal (noise) within all the leading or lagging training cells
4. Average the sum to determine the noise threshold
5. Using an appropriate offset value scale the threshold
6. Now, measure the signal in the `CUT`, which is `T+G+1` from the window starting point
7. Compare the signal measured in 5 against the threshold measured in 4
8. If the level of signal measured in `CUT` is smaller than the threshold measured, then assign 0 value to the signal within `CUT`.

---

### 2D CFAR Exercise

<img width="765" alt="2D_CFAR" src="https://user-images.githubusercontent.com/12381733/77252294-34813a80-6c96-11ea-9cc2-9824f7c1b4c3.png">

The following steps can be used to implement `2D-CFAR` in `MATLAB`

1. Determine the number of Training cells for each dimension Tr and Td. Similarly, pick the number of guard cells `Gr` and `Gd`.

2. Slide the Cell Under Test (CUT) across the complete cell matrix

3. Select the grid that includes the training, guard and test cells. `Grid Size = (2Tr+2Gr+1)(2Td+2Gd+1).`

4. The total number of cells in the guard region and cell under test. `(2Gr+1)(2Gd+1).`

5. This gives the Training Cells : `(2Tr+2Gr+1)(2Td+2Gd+1) - (2Gr+1)(2Gd+1)`

6. Measure and average the noise across all the training cells. This gives the threshold

7. Add the offset (if in signal strength in `dB`) to the threshold to keep the false alarm to the minimum.

8. Determine the signal level at the Cell Under Test.

9. If the `CUT` signal level is greater than the Threshold, assign a value of 1, else equate it to zero.

10. Since the cell under test are not located at the edges, due to the training cells occupying the edges, we suppress the edges to zero. Any cell value that is neither 1 nor a 0, assign it a zero.


---

### Reference

* [MatWorks - 2D FFT](https://kr.mathworks.com/help/matlab/ref/fft2.html)
* [MatWorks - Constant False Alarm Rate (CFAR) Detection](https://kr.mathworks.com/help/phased/examples/constant-false-alarm-rate-cfar-detection.html)
* [Radar Tutorial](https://www.radartutorial.eu/index.en.html)
* [Udacity Sensor Fusion Nanodegree](https://www.udacity.com/course/sensor-fusion-engineer-nanodegree--nd313)

