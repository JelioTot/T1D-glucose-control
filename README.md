# T1D-glucose-control

The main.m runs the Q learning algorithm and prints out an example day, which also saves the model to Qvalues.mat
inputting the model Qvalues.mat into the function days90_test will run a HbA1c test on the model to get an average glucose level which needs to be put into a HbA1c converter on the NHS website.
