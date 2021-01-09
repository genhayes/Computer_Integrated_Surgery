function [] = surgicalNavigationSimulation(Tip_tool, vax_tool, ApatCT, BpatCT, CpatCT, ApatTrack, BpatTrack, CpatTrack, AtoolTrack, BtoolTrack, CtoolTrack, TumCtrCT, TumRadCT, WinCtrCT, WinRadCT, generatePlot)
%SURGICALNAVIGATIONSIMULATION computes the tumour and window locations in
%tracker frame, the tool trajectory in tracker frame, the number of intersections of the
%tool trajectory with the window and tumour and the depth that the drill
%needs to continue to reach the depth of the center of the tumour. If
%generatePlot = 1, a navigation scene is plotted showing the markers, tool
%tip, tool axis vector, tool trajectory, tumour and window.

% Check that the drill markers and patient markers are congruent to those
% used for calibration
[checkCongruentDrill] = checkTrianglesCongruent(AtoolTrack,BtoolTrack,CtoolTrack,AtoolTrack,BtoolTrack,CtoolTrack);
[checkCongruentPatient] = checkTrianglesCongruent(ApatCT,BpatCT,CpatCT,ApatTrack,BpatTrack,CpatTrack);

%Generate frame transformation from CT to tracker frame
[Opathome,e1pathome,e2pathome,e3pathome] = generateOrthonormalFrame(ApatCT,BpatCT,CpatCT);

%Transform window and tumour to tracker frame
[Opat,e1pat,e2pat,e3pat] = generateOrthonormalFrame(ApatTrack,BpatTrack,CpatTrack);
[T_pat2track] = generateFrameTransformationToHome(Opat-Opathome,e1pat,e2pat,e3pat);
WinCtr_track = T_pat2track*[WinCtrCT';1];
WinCtr_track = WinCtr_track(1:3)';
TumCtr_track = T_pat2track*[TumCtrCT';1];
TumCtr_track = TumCtr_track(1:3)';

%Transform tool tip to tracker frame
[Omarkers,e1markers,e2markers,e3markers] = generateOrthonormalFrame(AtoolTrack,BtoolTrack,CtoolTrack);
Otip_track = Omarkers + Tip_tool;
vax_track = e2markers + vax_tool;
vax_track = vax_track./norm(vax_track);

drill_trajectory = -vax_track;
drill_Rad = 0.01;

%Calculate the number of intersections between the drill trajectory and
%tumour
numInt1_Tum = numIntersectionsOfSphereAndCylinder(TumCtr_track,TumRadCT,drill_Rad,Otip_track,drill_trajectory);
%Calculate the number of intersections between the drill trajectory and
%window
numInt1_Win = numIntersectionsOfSphereAndCylinder(WinCtr_track,WinRadCT,drill_Rad,Otip_track,drill_trajectory);

if numInt1_Tum>=1 && numInt1_Win>=1
    d_tip2tum = TumCtr_track - Otip_track;
    d_tip2tum = norm(d_tip2tum);
else
    d_tip2tum = NaN;
end

%Print parameters
fprintf('<strong>Surgical Navigation:</strong>\n')
fprintf('Check that the drill markers are congruent to the calibration drill markers: [')
fprintf(' %g ', checkCongruentDrill);
fprintf(']\n');

fprintf('Check that the patient markers are congruent to the calibration patient markers: [')
fprintf(' %g ', checkCongruentPatient);
fprintf(']\n');

fprintf('The tumour center in tracker frame is: [')
fprintf(' %g ', TumCtr_track);
fprintf(']\n');

fprintf('The window center in tracker frame is: [')
fprintf(' %g ', WinCtr_track);
fprintf(']\n');

fprintf('The location of the tool tip in tracker frame is: [')
fprintf(' %g ', Otip_track);
fprintf(']\n');

fprintf('The direction of the tool axis in tracker frame is: [')
fprintf(' %g ', vax_track);
fprintf(']\n');

fprintf('The trajectory of the tool tip in tracker frame is: [')
fprintf(' %g ', drill_trajectory);
fprintf(']\n');

fprintf('The number of intersections between the drill trajectory and the tumour is: [')
fprintf(' %g ', numInt1_Tum);
fprintf(']\n');

fprintf('The number of intersections between the drill trajectory and the window is: [')
fprintf(' %g ', numInt1_Win);
fprintf(']\n');

fprintf('The drill tip needs to drill [')
fprintf(' %g ', d_tip2tum);
fprintf('] ');
fprintf('further along its trajectory to reach the tumour. \n\n')

%%  Plot in 2D
if generatePlot == 1
    %Build circle plot function
    cplot = @(r,x0,y0,colour) plot(x0 + r*cos(linspace(0,2*pi)),y0 + r*sin(linspace(0,2*pi)),colour);

    figure()
    cplot(TumRadCT,TumCtr_track(1),TumCtr_track(2),'-r')
    labeltumour = {'Tumour'};
    text(TumCtr_track(1)+2, TumCtr_track(2),labeltumour,'VerticalAlignment','top','HorizontalAlignment','left')
    hold on;
    cplot(WinRadCT,WinCtr_track(1),WinCtr_track(2),'-g')
    labelwindow = {'Window'};
    text(WinCtr_track(1)+2, WinCtr_track(2),labelwindow,'VerticalAlignment','top','HorizontalAlignment','left')
    hold on;

    drill_tip = Otip_track(1:2);
    drill_center = Omarkers(1:2);
    %drill_vax = vax_track(1:2).*15                   
    dp = drill_center-drill_tip;                         
    quiver(drill_tip(1),drill_tip(2),dp(1),dp(2),0,'b')

    dp_trajectory = -dp*1.5;                      
    quiver(drill_tip(1),drill_tip(2),dp_trajectory(1),dp_trajectory(2),0,'--c')
    
    %plot tool tip
    plot(Otip_track(1), Otip_track(2),'*b')
    labeltip = {'Tool Tip'};
    text(Otip_track(1)-5, Otip_track(2),labeltip,'VerticalAlignment','top','HorizontalAlignment','left')
    hold on;
    
    %plot markers
    plot(AtoolTrack(1), AtoolTrack(2),'o')
    labelA = {'A'};
    text(AtoolTrack(1), AtoolTrack(2),labelA,'VerticalAlignment','top','HorizontalAlignment','left')
    hold on;
    plot(BtoolTrack(1), BtoolTrack(2),'o')
    labelB = {'B'};
    text(BtoolTrack(1), BtoolTrack(2),labelB,'VerticalAlignment','top','HorizontalAlignment','left')
    hold on;
    plot(CtoolTrack(1), CtoolTrack(2),'o')
    labelC = {'C'};
    text(CtoolTrack(1), CtoolTrack(2),labelC,'VerticalAlignment','top','HorizontalAlignment','left')
    
    xlabel('x');
    ylabel('y');
    xlim([-35 35])
    ylim([-35 35])
    title('Surgical Navigation')
    legend('Tumour', 'Window', 'Drill Axis', 'Drill Trajectory')
end

end

