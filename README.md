This repository contains a prototype of a license plate recognition system. It uses the
HOG descriptors of potential license plate images as coordinates for a k-nearest
neighbors (knn) classifier that was trained on license-plate and non-license-plate
images.

The system works by splitting an input image, which is presumed to be of the rear part
of a car, into sub-images of 300x64 pixels. It is assumed that one of the sub-images
represent the license plate of the vehicle, and the HOG-descriptor classifier is used to
select it. [Here](https://www.vide.bar/blog/license-plate-recognition-system/) you can
find a more detailed explanation of what this means.

The system was developed and tested using [a dataset from the Department of Electronics,
Microelectronics, Computer and Intelligent Systems of the University of Zagreb ](
https://www.zemris.fer.hr/projects/LicensePlates/english/results.shtml), which contains
over 500 images of the rear views of various vehicles under various lighting and
weather conditions.

Here is a sample of how the system behaves:

![rear part of a car with it's license plate surrounded by a red rectangle](
result_LPR_1.png)

![rear part of another car with it's license plate surrounded by a red rectangle](
result_LPR_2.png)

# Implementation overview

The implementation is carried out in Matlab using the [Computer Vision
Toolbox](https://es.mathworks.com/products/computer-vision.html), the [Image Processing
Toolbox](https://es.mathworks.com/products/image.html), and the [Statistics and Machine
Learning Toolbox](https://es.mathworks.com/products/statistics.html). Here is a brief
description of the files included in this repository:

- [`generate_training_images.m`](generate_training_images.m) is used to generate the
  non-license-plate training images for the classifier. This is done by taking the
  training-dataset images and cropping them into random 300x64 sub-images. These
  sub-images are then manually checked to remove the ones that contain portions of the
  license plates. The license-plate training images are gathered by simply cropping the
  plate out of the images of the training dataset. The training dataset consists of the
  images in the [`data/training/complete_images/`](data/training/complete_images/)
  directory, the randomly-cropped sub-images are in
  [`data/training/cropped_sections/`](data/training/cropped_sections/), and the training
  images for the classifier are in [`data/training/plates/`](data/training/plates/) and
  [`data/training/non_plates/`](data/training/non_plates/).

- [`get_hog_features.m`](get_hog_features.m) computes the HOG descriptors of the
  training images and stores them in a binary data file: `hog_features.mat`.

- [`build_classifier.m`](build_classifier.m) builds the classifier object and saves it
  into another binary data file: `classifier.mat`. It also tests the classifier using 8
  images, 2 of license plates and 6 of non-license-plate objects.

- [`main.m`](main.m) loads the classifier and uses it to identify the license plates of
  the vehicles in the test images.
