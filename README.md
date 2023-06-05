# Reference Algorithm Container for LDCTIQAC2023

This docker image contains a reference implementation that serve as a template for you to implementat your own algorithm for submission at LDCTIQAC2023.
This repository was created by referring to the [MIDOG challenge](https://github.com/DeepPathology/MIDOG_reference_docker#overview).

## Content:
1.Prerequisites

2.An overview of the structure of this example

3.Packing algorithm into a docker container image

4.Buliding container

5.Testing container and gernerating the bundle for uploading your algorithm

6.Creating an algorithm on Grand Challenge and submitting the solution to LDCTIQAC2023 Challenge

## 1.Prerequisites
- Install Docker, [Docker Installation](https://www.docker.com/get-started/)
- Clone this repository:
```bash
git clone https://github.com/JoyceWLee/LDCTIQAG_reference_docker.git
```
-  Install evalutils (provided by grand-challenge):
```bash
pip install evalutils
```
## 2.An overview of the structure of this example
This is an example of the algorithm container that you can use to submit your solution to the challenge. The primary file in the container is `process.py`, which loads the model and generates predictions of image quality scores. The results are saved in the file `/output/image-quality-scores.json` as a list of floating-point numbers. 

For further clarification, an example of a test batch is provided [here.](https://drive.google.com/file/d/1cP5NQis_9vGndm7SpwBWanHt4I4xiFPj/view?usp=sharing)
Please note that this example is provided for illustrative purposes only and does not represent the actual content of the test batch.
While this example consists of the same 100 stacked images, the actual test batch will contain random images with diverse image quality scores.
Using this example, the output file will contain 100 image quality scores, corresponding to a stack of 100 slice images that make up one test batch. For example:
```bash
[
    0.5592130422592163,
    0.5592130422592163,
    0.5592130422592163,
    0.5592130422592163,
    0.5592130422592163,
    0.5592130422592163,
    0.5592130422592163,
    ...
]
```
    
## 3.Packing algorithm into a docker container image
To use this algorithm as a template for submitting your entry to the challenge, follow these steps. First, open the `process.py` file and make the necessary changes marked with `TODO`. When testing your code locally, set `execute_in_docker=False`, but don't forget to switch it back to `execute_in_docker=True` before running the code in the docker container.

If your algorithm requires additional libraries or files, you can modify the `requirements.txt` file and the `Dockerfile` as needed. This will ensure that the required files and folders are copied appropriately. Check out the graphic description of the [MIDOG Challenge](https://github.com/DeepPathology/MIDOG_reference_docker#overview) below.

![midog_exmple](https://user-images.githubusercontent.com/50645935/233499229-cd2c8ffe-afb0-4dbc-b40e-131cd1d7544e.png)

## 4.Buliding container
- To test if all dependencies are met, you should run the `build.sh` to build the docker container. 
## 5.Testing container and gernerating the bundle for uploading your algorithm
- To test your container, you can run `test.sh`. This will run the test image provided in the test folder though your model. It will check them against what you provide in `test/expexted_output.json`. Noted: this will initially not be equal to the demo prediction score in this reference.
- To gerneate the bundle, you need to run the `export.sh` to generate the package of your docker with the extension **tar.gz**, which you can then upload to grand challenge to submit your algorithm.
## 6.Creating an algorithm on Grand Challenge and submitting the solution to LDCTIQAC2023 Challenge
- In order to submit the docker container, you have to add an algorithm for you docker container, [add algorithm](https://ldctiqac2023.grand-challenge.org/evaluation/challenge/algorithms/create/).
- Enter the name and description of the algorithm, and save the algorithm.
- After saving, you can add the docker container by uploading the container and waiting until the container becomes **active**.
- You can submit your docker container to LDCTIQAC2023 Challenge: [here](https://ldctiqac2023.grand-challenge.org/evaluation/challenge/submissions/create/).

