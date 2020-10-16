%q10 test

Err_limit = 10;
for error = 0: 0.5 : Err_limit
    i = 2*error + 1;
    failureRate_b(i, 1) = error;
    failureRate_w(i, 1) = error;
    [failureRate_b(i,2), failureRate_w(i,2)] = targetTrackingErrorSimulation(error);
end

figure; hold on;
title('Failure Rates as a function of the Jitter Error Magnitude')
ylabel('Failure Rate')
xlabel('Error Magnitude (mm)')
plot(failureRate_b(:,1),failureRate_b(:, 2), 'g')
plot(failureRate_w(:,1),failureRate_w(:, 2), 'r')
legend('Best Target Position (0,0,0)', 'Worst Target Position (-100,0,0)')
