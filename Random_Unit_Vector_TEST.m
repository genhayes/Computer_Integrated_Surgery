% 6. Generate-Random-Unit-Vector

Vectors2 = zeros(8,2);
for i=1:size(Vectors2,1)
    Vectors2(i,:) = Random_Unit_Vector(2);
end

Vectors3 = zeros(8,3);
for i=1:size(Vectors3,1)
    Vectors3(i,:) = Random_Unit_Vector(3);
end

DrawUnitCircle ( Vectors2 )
DrawSphere ( [ 0 0 0 ], 1, Vectors3 )

function DrawSphere ( Center, Radius, Points )
    figure;
    disp(Points')
    [ x, y, z ] = sphere;
    surf(x * Radius + Center(1), y * Radius + Center(2), z * Radius + Center(3), ...
        "EdgeColor", "flat", ...
        "EdgeAlpha", 0.5, ...
        "FaceAlpha", 0.15, ...
        "FaceColor", "interp", ...
        "FaceLighting", "none", ...
        "LineStyle", ":");
    colormap gray;
    hold on;
    plot3(Center(1), Center(2), Center(3), 'r.', "MarkerSize", 20);
    for i = 1:size(Points, 1)
        Point = Points(i,:);
        Lines = [ Center ; Point ];
        plot3(Lines(:,1), Lines(:,2), Lines(:,3));
        plot3(Point(1), Point(2), Point(3), "k.", "MarkerSize", 15);
    end 
end

function DrawUnitCircle ( Points )
    theta = linspace(0,2*pi,300); 
    x = cos(theta); 
    y = sin(theta);
    figure; plot(x,y)
    xlabel('x-axis')
    ylabel('y-axis')
    title('The graph of a unit circle.') 
    hold on
    for i = 1:size(Points, 1)
        Point = Points(i,:);
        Lines = [ [ 0 0 ] ; Point ];
        plot(Lines(:,1), Lines(:,2));
        plot(Point(1), Point(2), "k.", "MarkerSize", 15);
    end 
end 

function v = Random_Unit_Vector( dimension )
    v = randn(1,dimension);
    v = v./norm(v);
end