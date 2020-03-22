## Sensor Fusion Self-Driving Car Course - Radar Target Generation and Detection

Practice for Handling Radar sensed data, In aspect of self-driving car.

### Project Status:

![issue_badge](https://img.shields.io/badge/build-Passing-green) ![issue_badge](https://img.shields.io/badge/UdacityRubric-Passing-green)

<img width="786" alt="layout" src="https://user-images.githubusercontent.com/12381733/76136852-6f218b00-6079-11ea-8812-a887735af8a5.png">

## Dependencies for Running Locally
*  Matlab & Additional Toolboxes : You'll gonna need few Matlab Toolboxes those are in below.

<img width="491" alt="toolboxes" src="https://user-images.githubusercontent.com/12381733/77243651-e0ebfe00-6c4f-11ea-82ba-b35ca38b9345.png">

---

### Project Overview 

**SFND_Radar_Target_Generation_and_Detection.m**

- Configure the FMCW waveform based on the system requirements.
- Define the range and velocity of target and simulate its displacement.
- For the same simulation loop process the transmit and receive signal to determine the beat signal
- Perform Range FFT on the received signal to determine the Range
- Towards the end, perform the CFAR processing on the output of 2nd FFT to display the target.


## Main Workflow

### 1. Implementation steps for the 2D CFAR process

The false alarm issue can be resolved by implementing the constant false alarm rate. CFAR varies the detection threshold based on the vehicle surroundings. The CFAR technique estimates the level of interference in radar range and doppler cells “Training Cells” on either or both the side of the “Cell Under Test”. The estimate is then used to decide if the target is in the Cell Under Test (CUT).

Here's the steps for CFAR algorithm

<img width="814" alt="2d CFAR" src="https://user-images.githubusercontent.com/12381733/76136968-f02d5200-607a-11ea-8f38-77ee15438610.png">

1. Define CFAR Block such as picture above
2. Loop over all cells in the range and doppler dimensions, starting and ending at indices which leave appropriate margins 
3. Apply summation to all the values in the training cell position (Since the unit of RDM value (dB) doesn't allow ordinary summation, Convert the training cell values from decibels (dB) to power by using `db2pow` function)
4. Calculate the mean noise level among the training cells
5. Convert the result of average again by using `pow2db` function. And then, add the offset to set the dynamic threshold
6. Apply those threshold to every RDM values. Ignore values those smaller than threshold.
7. Store those compared values in a binary array of the same dimensions as RDM

```
for i=Tw+Gw+1:width-Tw-Gw
    for j=Th+Gh+1:height-Th-Gh
        outer_sum = 0;
        inner_sum = 0;
        for k=i-Tw-Gw:i+Tw+Gw
            for l=j-Th-Gh:j+Th+Gh
                outer_sum = outer_sum + db2pow(RDM(k,l));
            end
        end
        for k=i-Gw:i+Gw
            for l=j-Gh:j+Gh
                inner_sum = inner_sum + db2pow(RDM(k,l));
            end
        end
        noise_level = outer_sum - inner_sum;
        noise_level = noise_level / ( training_cell_num );
        noise_level = pow2db(noise_level);
        th = noise_level + offset;
      
        if RDM(i,j) > th
            CFAR(i,j) = 1;
        end
        noise_level = 0;
    end
end
```

> code output 
<img width="516" alt="final" src="https://user-images.githubusercontent.com/12381733/76136841-43060a00-6079-11ea-98b9-f6f7f23375dd.png">

### 2. Selection of training cells, guard cells, and offset

- Find proper value for Training Cell width/height & Guard Cell width/height & offset
- Too large offset will even suppress target signal. Too small cell size will allows few noises.

> By several tries, I found those profitable values.

```
% size of traning cell
Tw = 12;
Th = 5;

%size of guard cell
Gw = 4;
Gh = 3;

% offset the threshold by SNR value in dB
offset = 10;
```

### 3. Steps taken to suppress the non-thresholded cells at the edges

```
CFAR = zeros(size(RDM));
```

Assigned new Matrix that has the same size of `RDM` array.
Then I set the indexed position to 1, only if the threshold is exceeded by CUT.

---

### Reference

* [Radar Tutorial](https://www.radartutorial.eu/index.en.html)
