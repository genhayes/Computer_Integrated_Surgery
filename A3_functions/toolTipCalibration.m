%Genevieve Hayes
%Nov 2020

function [Tip_tool] = toolTipCalibration(At_track,Bt_track,Ct_track)
%TOOLTIPCALIBRATION determines the location of the tool tip with respect to
%the tool marker frame based on arrays of marker A, B and C positions.
%[Tip_tool] = toolTipCalibration(At_track,Bt_track,Ct_track) where
%At_track, Bt_track, Ct_track are matrices with 3 columns and at least 4 
%rows; the first column with Xs, 2nd column with Ys and 3rd columns with Zs 
%of spherical pivot poses determined by rotating the surgical drill with
%the tool tip at a fixed location. Tip_tool is rounded to 5 decimal places.

%Number of poses
N = length(At_track(:,1));

%Reconstruct the center locations in tracker frame
[Center_A,~] = reconstructSphereFromPoints(At_track);
[Center_B,~] = reconstructSphereFromPoints(Bt_track);
[Center_C,~] = reconstructSphereFromPoints(Ct_track);
Center_track_avg = mean([Center_A;Center_B;Center_C],1);
Center_tool = ones(N,3);

%Initialize tool basis frame vectors
O_tool = ones(N,3);
e1_tool = ones(N,3);
e2_tool = ones(N,3);
e3_tool = ones(N,3);

T_tool2track = ones(N*4+3,4);
T_track2tool = ones(N*4+3,4);

for i = 1:N
    %Generate tool frame for each pose
    [O_tool(i,:),e1_tool(i,:),e2_tool(i,:),e3_tool(i,:)] = generateOrthonormalFrame(At_track(i,:)',Bt_track(i,:)',Ct_track(i,:)');
    [T_tool2track(i*4:i*4+3,:)] = generateFrameTransformationToHome(O_tool(i,:),e1_tool(i,:),e2_tool(i,:),e3_tool(i,:));
    T_track2tool(i*4:i*4+3,:) = inv(T_tool2track(i*4:i*4+3,:));

    Transformed_center = T_track2tool(i*4:i*4+3,:)*[Center_track_avg';1];
    Center_tool(i,:) = Transformed_center(1:3)';
end

Center_tool_avg = mean(Center_tool,1);
Tip_tool = Center_tool_avg;

%define precision
numDecimals = 5; %round to 5 decimal places
f = 10.^numDecimals;
Tip_tool = round(f.*Tip_tool)./f;

end

