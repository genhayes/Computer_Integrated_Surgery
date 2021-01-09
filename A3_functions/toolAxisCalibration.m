%Genevieve Hayes
%Nov 2020

function [vax_tool] = toolAxisCalibration(At_track,Bt_track,Ct_track)
%TOOLAXISCALIBRATION determines the Y axis of the tool with respect to
%the tool marker frame based on arrays of marker A, B and C positions.
%[Tip_tool] = toolTipCalibration(At_track,Bt_track,Ct_track) where
%At_track, Bt_track, Ct_track are matrices with 3 columns and at least 4 
%rows; the first column with Xs, 2nd column with Ys and 3rd columns with Zs 
%of spherical pivot poses determined by rotating the surgical drill only 
%about the Y axis with the tool tip at a fixed location. 
%Tip_tool is rounded to 5 decimal places.

%Number of poses
N = length(At_track(:,1));

%Reconstruct the normals of the A, B, C rotated planes in tracker frame
NormalA = fitNormal(At_track)';
NormalB = fitNormal(Bt_track)';
NormalC = fitNormal(Ct_track)';
Normal_track_avg = mean([NormalA;NormalB;NormalC],1);
Normal_tool = ones(N,3);

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

    %Transform each normal to the tool frame
    Transformed_normal = T_track2tool(i*4:i*4+3,:)*[Normal_track_avg';1];
    Normal_tool(i,:) = Transformed_normal(1:3)';
    Normal_tool(i,:) = Normal_tool(i,:)./norm(Normal_tool(i,:));
end

Normal_tool_avg = mean(Normal_tool,1);
Normal_tool_avg(2) = abs(Normal_tool_avg(2)); %Take the positive normal direction
vax_tool = Normal_tool_avg; 

%define precision
numDecimals = 5; %round to 5 decimal places
f = 10.^numDecimals;
vax_tool = round(f.*vax_tool)./f;

end

