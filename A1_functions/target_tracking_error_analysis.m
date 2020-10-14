% Genevieve Hayes
% CISC 330 - A1 Question 10

%% Initialize variables to conduct simulation of target position = [0,0,0]
testLen = 21*10; %Define the number of increments to make for the error magnitude
range = 1:testLen;
ErrMax = 4; %Maximum TRE; any TRE of 4mm or above is deemed a failure
Magnitude_Err = 0; %Initialize the error magnitude
N = 0; %Initialize the total number of TRE calculations
NF = 0; %Initialize the total number of failures
FR = zeros(testLen, 1); %Initialize the failure rate
Errs = zeros(testLen, 1); %Initialize the err magnitude array 


for i = range
    count = 0;
    for count = 1:5 %Repeat each calculation with a given error magnitude 5 times
    Magnitude_Err = 0.05*(i-1); %Increment the error magnitude
    Errs(i) = Magnitude_Err;
    
    %Generate random error vectors
    Err1 = Magnitude_Err*generateRandomUnitVector(3);
    Err2 = Magnitude_Err*generateRandomUnitVector(3);
    Err3 = Magnitude_Err*generateRandomUnitVector(3);
    
    %Apply random errors to marker locations
    A = Err1 +[100,0,0]; 
    B = Err2 +[-50,0,86.6];
    C = Err3 +[-50,0,-86.6];
    [Oe,e1,e2,e3] = generateOrthonormalFrame(A,B,C);

    [T_e2h] = generateFrameTransformationToHome(Oe,e1,e2,e3);

    Pbody = [0,0,0,1]; %Place the target at the origin of the body frame
    Phome = T_e2h*Pbody';
    TRE = norm(Phome(1:3))-norm(Pbody(1:3));

    if abs(TRE) < ErrMax
        WithinRequiredAccuracy = 'Within Required Accuracy \n';
        fprintf('All Good!: TRE = %.1f\n',TRE);
    else 
        WithinRequiredAccuracy = 'NOT Within Required Accuracy \n';
        fprintf('NOT Within Required Accuracy: TRE = %.1f\n',TRE);
        NF = NF+1;
    end

    N = N+1; %Increment total number of trials

    if N == 0 %No failure rate calculation for the first iteration
        FR(i) = 0;
    else
        FR(i) = NF/N; %Calculate failure rate
    end
    count = count + 1;
    end
end

FR_final = NF/N;
fprintf('The failure rate is: %.1f\n',FR_final);

figure
plot(Errs, FR)
title('Analysis Plot: Failure Rate as a function of Err (for Worst Target Point [0,0,0])')
xlabel('Magnitude of Error')
ylabel('Failure Rate (#Failed/Total)')
axis([0 11 0 0.4])

%% Re-initialize variables to conduct simulation of target position = [100,0,0] (Marker Position)
Magnitude_Err = 0; %Initialize the error magnitude
N = 0; %Initialize the total number of TRE calculations
NF = 0; %Initialize the total number of failures
FR = zeros(testLen, 1); %Initialize the failure rate
Errs = zeros(testLen, 1); %Initialize the err magnitude array 


for i = range
    count = 0;
    for count = 1:5 %Repeat each calculation with a given error magnitude 5 times
    Magnitude_Err = 0.05*(i-1);
    Errs(i) = Magnitude_Err;
    
    %Generate random error vectors
    Err1 = Magnitude_Err*generateRandomUnitVector(3);
    Err2 = Magnitude_Err*generateRandomUnitVector(3);
    Err3 = Magnitude_Err*generateRandomUnitVector(3);
    
    %Apply random errors to marker locations
    A = Err1 +[100,0,0];
    B = Err2 +[-50,0,86.6];
    C = Err3 +[-50,0,-86.6];
    [Oe,e1,e2,e3] = generateOrthonormalFrame(A,B,C);

    [T_e2h] = generateFrameTransformationToHome(Oe,e1,e2,e3);

    Pbody = [100,0,0,1]; %Place the target at marker "A" postion
    Phome = T_e2h*Pbody';
    TRE = norm(Phome(1:3))-norm(Pbody(1:3));

    if abs(TRE) < ErrMax
        WithinRequiredAccuracy = 'Within Required Accuracy \n';
        fprintf('All Good!: TRE = %.1f\n',TRE);
    else 
        WithinRequiredAccuracy = 'NOT Within Required Accuracy \n';
        fprintf('NOT Within Required Accuracy: TRE = %.1f\n',TRE);
        NF = NF+1;
    end

    N = N+1; %Increment total number of trials

    if N == 0 %No failure rate calculation for the first iteration
        FR(i) = 0;
    else
        FR(i) = NF/N; %Calculate failure rate
    end
    count = count + 1;
    end
end

FR_final2 = NF/N;
fprintf('The failure rate is: %.1f\n',FR_final);

figure
plot(Errs, FR)
title('Analysis Plot: Failure Rate as a function of Err (for Best Target Point: [100,0,0])')
xlabel('Magnitude of Error')
ylabel('Failure Rate (#Failed/Total)')
axis([0 11 0 0.4])

