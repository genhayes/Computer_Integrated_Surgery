% Assignment 1 - Computational Geometry
% Genevieve Hayes
%% Question 1

%test1 - intersection at [1,0,0]
origin_point = [0,0,0];
start_point = [1,-1,0];
x_2unit_vector = [2,0,0];
y_2unit_vector = [0,2,0];

%[test1_Intersection, test1_Error] = intersectionOf2Vectors(origin_point,x_2unit_vector,start_point,y_2unit_vector);
[test1_Intersection, test1_Error] = closestIntersectionOf2Vectors([0,0,0],[0,1,0],[1,0,0],[0,1,0]);
%[test2_Intersection, test2_Error] = closestIntersectionOf2Vectors([0,0,0],[0,1,0],[2,0,0],[1,0,0]);
[test2_Intersection, test2_Error] = closestIntersectionOf2Vectors([0,0,0],[0,2,0],[2,1,0],[1,0,0]);
[test3_Intersection, test3_Error] = closestIntersectionOf2Vectors([0,0,0],[0,2,0],[1,0,0],[0,0,1]);

origin_point = [0,0,0];
start_point = [1,0,0];
x_unit_vector = [1,0,0];

%[test2_Intersection, test2_Error] = intersectionOf2Vectors(origin_point,x_unit_vector,start_point,x_2unit_vector);
%[test2_Intersection, test2_Error] = approximateIntersectionOf2Vectors(origin_point,x_unit_vector,start_point,x_2unit_vector);


%% Question 2

%test1 - intersection at [1,0,0]
origin_point = [0,0,0];
start_point = [2,-1,0];
y_unit_vector = [0,1,0];
y_2unit_vector = [0,2,0];

%[test1_Intersection, test1_Error] = intersectionOf2Vectors(origin_point,x_2unit_vector,start_point,y_2unit_vector);
test1_Int = intersectionOfVectorWithPlane(origin_point,y_unit_vector,start_point,y_2unit_vector);

%% Question 3
% Two intercepts
[t1_numInts, t1_int] = intersectionOfVectorWithEllipsoid([0,-2,0],[0,4,0],1,1,1);

% One intercept
[t2_numInts, t2_int] = intersectionOfVectorWithEllipsoid([-1,-2,0],[0,4,0],1,1,1);

% Zero intercepts
[t3_numInts, t3_int] = intersectionOfVectorWithEllipsoid([-5,-2,0],[0,4,0],1,1,1);

%% Question 4

