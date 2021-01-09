%Genevieve Hayes
%Nov 16, 2020

%Referenced from Dan Couture on MathWorks.com:
%https://www.mathworks.com/matlabcentral/fileexchange/37775-plane-fitting-and-normal-calculation

function n = fitNormal(data)
%FITNORMAL fits a plane to the set of vectors.
%For a passed list of points in (x,y,z) cartesian coordinates,
%find the plane that best fits the data, the unit vector
%normal to that plane with an initial point at the average
%of the x, y, and z values.
% n = fitNormal(data) where data is matrix composed of of N sets of (x,y,z) 
% coordinates with dimensions Nx3 to which a plane is fit. n is a unit 
% vector that is normal to the fit plane.

	for i = 1:3
		X = data;
		X(:,i) = 1;
		
		X_m = X' * X;
		if det(X_m) == 0
			can_solve(i) = 0;
			continue
		end
		can_solve(i) = 1;
		
		% Construct and normalize the normal vector
		coeff = (X_m)^-1 * X' * data(:,i);
		c_neg = -coeff;
		c_neg(i) = 1;
		coeff(i) = 1;
		n(:,i) = c_neg / norm(coeff);
		
	end
	
	if sum(can_solve) == 0
		error('Planar fit to the data caused a singular matrix.')
		return
	end
	
	% Calculating residuals for each fit
	center = mean(data);
	off_center = [data(:,1)-center(1) data(:,2)-center(2) data(:,3)-center(3)];
	for i = 1:3
		if can_solve(i) == 0
			residual_sum(i) = NaN;
			continue
		end
		
		residuals = off_center * n(:,i);
		residual_sum(i) = sum(residuals .* residuals);
		
	end
	
	% Take the lowest residual index
	best_fit = find(residual_sum == min(residual_sum));
	% Use the first index found
	n = n(:,best_fit(1));
	
end
