# Multi-Temporal-Classification-of-satellite-images

The aim of the project is to do pixel based classification of satellite images into different classes [Buildings, Open-Land, Vegetation, Water-Bodies]. However, using a single image to classify the pixels yields unsatisfactory results mainly due to inseparability of the classes which depends upon the time when image was captured. The spectral signatures of the classes vary with time. For e.g. vegetation changes color as it grows. Open lands become occupied by grass after the monsoon. This variation in the spectral images can be leveraged to achieve better classification using multiple images of the same region taken over at times.

Bayesian Model Averaging is one of the widely-used approaches when it comes to combining the results of different models not just based on majority vote but also on how reliable and good the model is. BMA assigns weights to each of the models based on their performance on the training data and the expected performance on the test data. It then uses all the four models with their respective training data and corresponding images to get the prediction of a single pixel. After multiplying the raw probability output of each model with its weight the highest posterior probability class label is assigned.

Description of the Data:
Number of images: 4
Image resolution: 30m*30m.
Number of bands: 8 [Ultra Blue, Blue, Green, Red, Near Infrared(NIR), SWNIR_1, SWNIR_2, Cirrus]
Number of Training samples: 184 per image.
Hold out data for testing final results: 45 samples.
Total number of pixels to classify the complete image: 3,000,000
Number of Attributes: 10 [X-coordinate, Y-coordinate, Class, and the 8 bands]
Attribute Types: Continuous attributes except the class label.
Class Label factors: 1: Building, 2: Open Land, 3: Vegetation, 4: Water Bodies.

In this project in the data exploration phase we found that band 8 [Cirrus] is not useful in distinguishing between any of the classes and hence is omitted from the training data. Further the per class distribution of the color bands follow a fairly normal distribution and hence we have decided to use the Maximum Likelihood Classifier. From domain expert, we have obtained the information that the bands are in fact independent of each other and hence Naive Bayes classifier can be used. The results are in the Images folder.

From the preliminary classification results we have established the baseline accuracy to compare our further results. It is 86%. The proposed implementation of the Bayesian Model Averaging has been completed and it has achieved higher accuracy than the baseline. It is currently 91.80%.

Future Plan:
1. We have proposed on a different weighting scheme for Bayesian Model Averaging and working towards checking the whether it is mathematically sound. In general, our proposal is to give weights per class per model considering the model's performance over a particular class only. We expect that this weight calculation and assignment scheme should harness the power of each model in areas where it performs best. Motivation behind this proposal: We observed that some models overall performance is low but the quite well when it comes to prediction specific classes and we wish to leverage this.

Challenges:
We have observed that the training data has class labels constant throughout all the images. However, this is not necessarily true as some points in the region have changed from open land to vegetation, some changed from vegetation to buildings and so on. Due to this non constant class labels we are having conflicting results with high confidence where one predict class A and another predict class B. Essentially, both are correct and the difference in their confidence is not significant. Hence, whenever we have such conflicts instead of assigning those points as class labels, we mark them as a fifth class called changed. And thus, we will end up doing change detection based on multi-temporal images too.

Detailed Progress reports of the project can be found in the Reports folder.
RScripts folder contains all the R code created and used to perform data processing, model fitting, cross-validation and Bayesian Model Averaging.
