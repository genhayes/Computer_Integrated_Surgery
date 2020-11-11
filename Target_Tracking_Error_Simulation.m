% 10. Target-Tracking-Error-Simulation

function [ failureRate_b,failureRate_w ] = Target_Tracking_Error_Simulation( Err )
    % Calculate transform using original markers
    A = [100;0;0];
    B = [-50;0;86.6];
    C = [-50;0;-86.6];
    
    %[ e1, e2, e3, Oe ] = Orthonormal_Frame( A,B,C );
    %[ Transform ] = Frame_Transformation_To_Home( Oe, e1, e2, e3 );
    
    [ Oe, e1, e2, e3 ] = generateOrthonormalFrame( A,B,C );
    [ Transform ] = generateFrameTransformationToHome( Oe, e1, e2, e3 );
    
    Pb =  [0;0;0;1];            % with pad
    Pw =  [-100;0;0;1];         % with pad
    Location_best = Transform*Pb;
    Location_worst = Transform*Pw;
    
    numFailures_b = 0;
    numFailures_w = 0;
    numObservations = 1000;
    for i=1:numObservations
%         % Translate each marker using the jitter err 
%         [ ua ] = Random_Unit_Vector( 3 );
%         A_jitter = A + Err*ua;
%         [ ub ] = Random_Unit_Vector( 3 );
%         B_jitter = B + Err*ub;
%         [ uc ] = Random_Unit_Vector( 3 );
%         C_jitter = C + Err*uc;
        
        [ ua ] = generateRandomUnitVector( 3 );
        A_jitter = A + Err*ua';
        [ ub ] = generateRandomUnitVector( 3 );
        B_jitter = B + Err*ub';
        [ uc ] = generateRandomUnitVector( 3 );
        C_jitter = C + Err*uc';
        
        % v is the translated stuff
%         [v1,v2,v3,O_jitter] = Orthonormal_Frame(A_jitter,B_jitter,C_jitter);
%         [ Transform_Err ] = Frame_Transformation_To_Home( O_jitter, v1, v2, v3 );
        
        [O_jitter, v1,v2,v3] = generateOrthonormalFrame(A_jitter,B_jitter,C_jitter);
        [ Transform_Err ] = generateFrameTransformationToHome( O_jitter, v1, v2, v3 );
        
        Estimated_Pb = Transform_Err*Pb;
        Estimated_Pw = Transform_Err*Pw;
        
        TRE_b = norm(Location_best - Estimated_Pb);
        TRE_w = norm(Location_worst - Estimated_Pw);
  
        % TRE will be the difference between the point now and what it should be

        if TRE_b >= 4
            numFailures_b = numFailures_b + 1;
        end
        if TRE_w >= 4
            numFailures_w = numFailures_w + 1;
        end        
    end
    failureRate_b = numFailures_b/numObservations;
    failureRate_w = numFailures_w/numObservations;
end