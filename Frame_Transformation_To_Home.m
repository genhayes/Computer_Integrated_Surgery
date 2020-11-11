% 9. Frame-Transformation-to-Home
% Part 3 ppt, slide 30 and 31, and Part 3 ppt, slide 2
% first 4 bullets, just populate it into matlab, the real work of it is the
% testing, create test cases, easy for translation, hard for rotation
% (create a rotation matrix you know the answer of, recreate situations you
% can see through, 90 degrees on the Z axis to create ground truth cases)

function [ Transform ] = Frame_Transformation_To_Home( Ov,v1,v2,v3 )
    Oh = [0;0;0];
    h1 = [1;0;0];
    h2 = [0;1;0];
    h3 = [0;0;1];
    Translate = [1,0,0,-Ov(1);0,1,0,-Ov(2);0,0,1,-Ov(3);0,0,0,1];
    Rotate = [v1 v2 v3]'               %compute rotation matrix
    Rotate = [Rotate, [ 0 ; 0 ; 0 ]];
    Rotate = [ Rotate ; 0 0 0 1 ];      % Homogenous Rotation Matrix
    Transform = Rotate*Translate;       %combine to form transformation matrix
end

