function [Tip_tool] = toolTipCalibrationPosePlanes(At_track,Bt_track,Ct_track)
%TOOLTIPCALIBRATIONPOSEPLANES determines the location of the tool tip with respect to
%the tool marker frame based on arrays of marker A, B and C positions by
%calculating the intersection of normal vectors to the planes formed by 
%each pose's 3 markers.
%[Tip_tool] = toolTipCalibrationPosePlanes(At_track,Bt_track,Ct_track) where
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

A = ones(N-1,3);
n = ones(N-1,1);
An = ones(N-1,3);
Center_tool = ones(N,3);

for i = 1:N-1  
    %Generate tool frame for each pose
    [O_tool(i,:),e1_tool(i,:),e2_tool(i,:),e3_tool(i,:)] = generateOrthonormalFrame(At_track(i,:)',Bt_track(i,:)',Ct_track(i,:)');
    
    A(i,:) = (O_tool(i,:) - O_tool(i+1,:))/2;
    n(i) = norm(O_tool(i,:) - O_tool(i+1,:));
    An(i,:) = A(i,:).*n(i); 
end

%Calculate the tool tip point in tool frame
Ptrack = pinv(n)*(An)./(N);

for i = 1:N-1
    %Generate tool frame for each pose
    [O_tool(i,:),e1_tool(i,:),e2_tool(i,:),e3_tool(i,:)] = generateOrthonormalFrame(At_track(i,:)',Bt_track(i,:)',Ct_track(i,:)');
    
    %Generate transform from tracker frame to tool frame for each pose
    [T_tool2track(i*4:i*4+3,:)] = generateFrameTransformationToHome(O_tool(i,:),e1_tool(i,:),e2_tool(i,:),e3_tool(i,:));
    T_track2tool(i*4:i*4+3,:) = inv(T_tool2track(i*4:i*4+3,:));
    
    %Transform tip from tracker fram to tool frame
    Transformed_center = T_track2tool(i*4:i*4+3,:)*[Ptrack';1];
    Center_tool(i,:) = Transformed_center(1:3)';
end

Center_tool_avg = mean(Center_tool,1);
Tip_tool = Center_tool_avg;

%define precision
numDecimals = 5; %round to 5 decimal places
f = 10.^numDecimals;
Tip_tool = round(f.*Tip_tool)./f;


end

