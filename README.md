# Image Processing
Digital image processing Algorithms and their application to the real problems.

## Canny Edge Detector

There is Canny Edge Detector implemented from scratch. You can see one of the results below.

| **Image** | **Edges** |
|:---:|:---:|
| <img src="images/canny/camerman.png">| <img src="images/canny/camerman_edges.png">|

## Time detection

If you ever needed a program that would tell you what's the time, today is your lucky day. 

| **Image** | **Detected Needles** | **HH:MM:SS** |
|:---:|:---:|:---:|
|<img src="images/clock/image.jpg" width="50%"> | <img src="images/clock/detected_needles.jpg">|08:17:06|

## Dice detection

If you ever played a game with dice and needed program that would quickly tell you your score, today is your lucky day. 

| **Image** | **Detected Dice** | **Dice Circles** |
|:---:|:---:|:---:|
|<img src="images/dice/original.jpg" width="50%"> | <img src="images/dice/dice.jpg">|<img src="images/dice/red_die.jpg"> <img src="images/dice/blue_die.jpg">|

## What image improvement methods can I find here?

Here are some of the results of methods implemented in this project.

| **Before** | **After** | **Method** |
|:---:|:---:|:---:|
| <img src="images/image_improvement/bristol_before.jpg" width="70%"> | <img src="images/image_improvement/bristol_after.jpg" width="70%">|Histogram Equalization|
| <img src="images/clhe/before.jpg" width="70%"> | <img src="images/clhe/clhe_w_limit.jpg" width="70%">|Clip Limit Histogram Equalization|
| <img src="images/image_improvement/enigma_before.jpg" width="70%"> | <img src="images/image_improvement/enigma_after.jpg" width="70%">|Adaptive Median Filter|
| <img src="images/wiener/before.jpg" width="70%"> | <img src="images/wiener/after.jpg" width="70%">|Wiener Filter|
| <img src="images/non_local_means/before.jpg" width="70%"> | <img src="images/non_local_means/after.jpg" width="70%">|Non-local Means|
| <img src="images/2D_filtering/before.jpg" width="70%"> | <img src="images/2D_filtering/after.jpg" width="70%">|2D Notch Filter|

## How to run the tests?

To run any test simply go to the directory of the project task you want to test, and type 'test' in the Matlab shell. Note that for some tests you have to have Matlab version 2017 and above.

  ```shell
  test
  ```
