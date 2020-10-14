% Genevieve Hayes
% CISC 330 - A1 Question 9

function [T_e2h] = generateFrameTransformationToHome(Oe,e1,e2,e3)
%GENERATEFRAMETRANSFORMATIONTOHOME generated the transformation matrix that
%transforms a point in an orthonormal e-basis, Pe to the home frame such
%that Ph = T_e2h*Pe where Ph and Pe column vectors are padded with a 1 at
%the end and T_e2h is a 4x4 transformation matrix.
%   [T_e2h] = generateFrameTransformationToHome(Oe,e1,e2,e3) where Oe is
%   the center of the e-basis and e1, e2, e3 are the orthonormal basis
%   vectors. T_e2h is a 4x4 transformation matrix.

Translation_matrix_e2h = [1 0 0 Oe(1);0 1 0 Oe(2);0 0 1 Oe(3);0 0 0 1];
Rotation_matrix_e2h = [e1(1) e2(1) e3(1) 0;e1(2) e2(2) e3(2) 0;e1(3) e2(3) e3(3) 0;0 0 0 1];

% Ph = Rot_etoh*Trans_etoh*Pe
T_e2h = Rotation_matrix_e2h*Translation_matrix_e2h;

end

