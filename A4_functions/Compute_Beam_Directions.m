%Genevieve Hayes
%Dec 2020

function [beam_nvectors] = Compute_Beam_Directions(beam_separation_angle)
%COMPUTE_BEAM_DIRECTIONS Commutes the unit direction vector for each pencil
%beam's centerline
%[beam_nvectors] = Compute_Beam_Directions(beam_separation_angle) where
%beam_separation_angle is the angle between beams and beam_nvectors is a 2D
%array with each row corresponding the the [x,y,z] unit vector directions.

%Start with z unit vector
zunitvector_pad = [0,0,1,1];

%Initialize beam vectors
beam_nvectors = zeros((360/beam_separation_angle)*3,3);

%rotate about x by angle increments
for i = 0:(90/beam_separation_angle-1)
    anglex = (i+1)*beam_separation_angle; %degrees
    [~,R4by4x] = rotationMatrixAboutFrameAxis(1,anglex);
    
    for j = 0:(360/beam_separation_angle-1)
        anglez = j*beam_separation_angle; %degrees
        [~,R4by4z] = rotationMatrixAboutFrameAxis(3,anglez);
        
        %Rotate z unit vector by all combinations of 30 degree rotations in x and z 
        nvector_pad = R4by4z*R4by4x*zunitvector_pad';
        
        beam_nvectors((i*(360/beam_separation_angle))+j+1,:) = nvector_pad(1:3)';
    end
end

%Add first z axis vector to rotated vectors
beam_nvectors = [zunitvector_pad(1:3);beam_nvectors];

end

