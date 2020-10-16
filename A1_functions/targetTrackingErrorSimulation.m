% Genevieve Hayes
% CISC 330 - A1 Question 10

function [ failureRate_best,failureRate_worst ] = Target_Tracking_Error_Simulation(Magnitude_Err)
%TARGETTRACKINGERRORSIMULATION Summary of this function goes here
%   Detailed explanation goes here

    % Actual marker positions
    A = [100;0;0];
    B = [-50;0;86.6];
    C = [-50;0;-86.6];
    
    %[ e1, e2, e3, Oe ] = Orthonormal_Frame( A,B,C );
    %[ Transform ] = Frame_Transformation_To_Home( Oe, e1, e2, e3 );
    
    [ Oe, e1, e2, e3 ] = generateOrthonormalFrame( A,B,C );
    [ Transform ] = generateFrameTransformationToHome( Oe, e1, e2, e3 );
    
    Pbest =  [0;0;0;1];            % Best target point with padding
    Pworst =  [-100;0;0;1];         % Worst target point with padding
    Location_best = Transform*Pbest;
    Location_worst = Transform*Pworst;
    
    numFailures_best = 0;
    numFailures_worst = 0;
    numObservations = 1000;
    for i=1:numObservations
%         % Translate each marker using the jitter err 
%         [ ua ] = Random_Unit_Vector( 3 );
%         A_jitter = A + Err*ua;
%         [ ub ] = Random_Unit_Vector( 3 );
%         B_jitter = B + Err*ub;
%         [ uc ] = Random_Unit_Vector( 3 );
%         C_jitter = C + Err*uc;
        
        Err1 = Magnitude_Err*generateRandomUnitVector(3)';
        Err2 = Magnitude_Err*generateRandomUnitVector(3)';
        Err3 = Magnitude_Err*generateRandomUnitVector(3)';
        
        A_jitter = A + Err1;
        B_jitter = B + Err2;
        C_jitter = C + Err3;
        
        % v is the translated stuff
%         [v1,v2,v3,O_jitter] = Orthonormal_Frame(A_jitter,B_jitter,C_jitter);
%         [ Transform_Err ] = Frame_Transformation_To_Home( O_jitter, v1, v2, v3 );
        
        [O_jitter, e1_jitter,e2_jitter,e3_jitter] = generateOrthonormalFrame(A_jitter,B_jitter,C_jitter);
        [ Transform_jitter ] = generateFrameTransformationToHome(O_jitter, e1_jitter,e2_jitter,e3_jitter);
        
        Estimated_Pbest = Transform_jitter*Pbest;
        Estimated_Pworst = Transform_jitter*Pworst;
        
        %Calculate the TRE: the difference between the actual target location in home frame 
        %and the jittered observation of the target transformed to the home
        %frame
        TRE_best = norm(Location_best - Estimated_Pbest);
        TRE_worst = norm(Location_worst - Estimated_Pworst);

        if TRE_best >= 4
            numFailures_best = numFailures_best + 1;
        end
        if TRE_worst >= 4
            numFailures_worst = numFailures_worst + 1;
        end        
    end
    failureRate_best = numFailures_best/numObservations;
    failureRate_worst = numFailures_worst/numObservations;
end

