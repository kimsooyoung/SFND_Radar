# SFND_Radar - Radar Target Generation and Detection

## Project layout - SFND_Radar_Target_Generation_and_Detection.m

- Configure the FMCW waveform based on the system requirements.
- Define the range and velocity of target and simulate its displacement.
- For the same simulation loop process the transmit and receive signal to determine the beat signal
- Perform Range FFT on the received signal to determine the Range
- Towards the end, perform the CFAR processing on the output of 2nd FFT to display the target.

<img width="786" alt="layout" src="https://user-images.githubusercontent.com/12381733/76136852-6f218b00-6079-11ea-8812-a887735af8a5.png">

## Project Review

### 1. Implementation steps for the 2D CFAR process

The 2D constant false alarm rate (CFAR), when applied to the results of the 2D FFT, uses a dynamic threshold set by the noise level in the vicinity of the cell under test (CUT). The key steps are as follows:
- Loop over all cells in the range and doppler dimensions, starting and ending at indices which leave appropriate margins
- Slice the training cells (and exclude the guard cells) surrounding the CUT
- Convert the training cell values from decibels (dB) to power, to linearize
- Find the mean noise level among the training cells
- Convert this average value back from power to dB
- Add the offset (in dB) to set the dynamic threshold
- Apply the threshold and store the result in a binary array of the same dimensions as the range doppler map (RDM)

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

### 2. Selection of training cells, guard cells, and offset

The values below were hand selected. I chose a rectangular window with the major dimension along the range cells. This produced better filtered results from the given RDM. Choosing the right value for `offset` was key to isolating the simulated target and avoiding false positives. Finally, I precalculated the `N_training` value to avoid a performance hit in the nested loop.
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
In my 2D CFAR implementation, only CUT locations with sufficient margins to contain the entire window are considered. I start with an empty array of zeros, equivalent in size to the `RDM` array. I then set the indexed locations to one if and only if the threshold is exceeded by the CUT.
