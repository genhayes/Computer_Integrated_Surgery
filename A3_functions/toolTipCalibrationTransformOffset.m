function [Tip_tool] = toolTipCalibrationTransformOffset(At_track,Bt_track,Ct_track)
%TOOLTIPCALIBRATIONPENROSEMOORE determines the location of the tool tip with respect to
%the tool marker frame based on arrays of marker A, B and C positions using
%the transformation matrix offset.
%[Tip_tool] = toolTipCalibrationPenroseMoore(At_track,Bt_track,Ct_track) where
%At_track, Bt_track, Ct_track are matrices with 3 columns and at least 4 
%rows; the first column with Xs, 2nd column with Ys and 3rd columns with Zs 
%of spherical pivot poses determined by rotating the surgical drill with
%the tool tip at a fixed location. Tip_tool is rounded to 5 decimal places.

%Number of poses
N = length(At_track(:,1));

%Initialize tool basis frame vectors
O_tool = ones(N,3);
e1_tool = ones(N,3);
e2_tool = ones(N,3);
e3_tool = ones(N,3);

T_tool2track = ones(N*4+3,4);
T_track2tool = ones(N*4+3,4);

offset_track2tool = ones(N,3);

for i = 1:N
    %Generate tool frame for each pose
    [O_tool(i,:),e1_tool(i,:),e2_tool(i,:),e3_tool(i,:)] = generateOrthonormalFrame(At_track(i,:)',Bt_track(i,:)',Ct_track(i,:)');
    [T_tool2track(i*4:i*4+3,:)] = generateFrameTransformationToHome(O_tool(i,:),e1_tool(i,:),e2_tool(i,:),e3_tool(i,:));
    T_track2tool(i*4:i*4+3,:) = inv(T_tool2track(i*4:i*4+3,:));
    
    offset_track2tool(i,:) = T_track2tool(i*4:i*4+2,4)';  
end

Tip_tool = mean(offset_track2tool,1);

%define precision
numDecimals = 5; %round to 5 decimal places
f = 10.^numDecimals;
Tip_tool = round(f.*Tip_tool)./f;
end

