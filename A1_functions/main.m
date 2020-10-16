% Genevieve Hayes
% CISC 330 - A1

% The methods, sketched and test descriptions are described in detail in
% the A1_README_GH.docx. 

%% Question 1
% Runs all defined unit tests for this function
Q1results = runtests('test_closestIntersectionOf2Vectors.m')

%% Question 2
% Runs all defined unit tests for this function
Q2results = runtests('test_intersectionOfVectorWithPlane.m')

%% Question 3
% Runs all defined unit tests for this function
Q3results = runtests('test_intersectionOfVectorWithEllipsoid.m')

%% Question 4
% Runs all defined unit tests for this function
Q4results = runtests('test_numIntersectionsOfSphereAndCylinder.m')

%% Question 5
% Runs all defined unit tests for this function
Q5results = runtests('test_reconstructSphereFromPoints.m')

%% Question 6
% Runs all defined unit tests for this function
Q6results = runtests('test_generateRandomUnitVector.m')

%% Question 7
% Runs all defined unit tests for this function
Q7results = runtests('test_generateOrthonormalFrame.m')

%% Question 8
% Runs all defined unit tests for this function
Q8results = runtests('test_rotationMatrixAboutFrameAxis.m')

%% Question 9
% Runs all defined unit tests for this function
Q9results = runtests('test_generateFrameTransformationToHome.m')

%% Question 10
target_tracking_error_incrementing % Runs the simulations that increments the magnitude of the error vectors and exits of the maximum error is reached - this is done for 2 target locations
targetTrackingErrorSimulationAnalysis % Runs the simulation that increments the magnitude of the error vectors and generates failure rate analysis for 2 target locations
