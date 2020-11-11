% % test q7

% % test 1
% Expected
e1 = [1,0,0];
e2 = [0,1,0];
e3 = [0,0,1];
Oe = [0.33,0.33,0];
% Output
[ v1, v2, v3, Ov ] = Orthonormal_Frame( [0,0,0],[1,0,0],[0,1,0] );
disp('Expected:  in order e1,e2,e3,Oe');
disp(e1);
disp(e2);
disp(e3);
disp(Oe);
disp('Calculated: in order v1,v2,v3,Ov');
disp(v1);
disp(v2);
disp(v3);
disp(Ov);


% % test 2: collinear
% Expected
e1 = [1,0,0];
Oe = [0.66,0,0];
% Output
[ v1, v2, v3, Ov ] = Orthonormal_Frame( [0,0,0],[1,0,0],[1,0,0] );
disp('Expected:  in order e1,e2,e3,Oe');
disp(e1);
disp(e2);
disp(e3);
disp(Oe);
disp('Calculated: in order v1,v2,v3,Ov');
disp(v1);
disp(v2);
disp(v3);
disp(Ov);


% % test 3
% Expected
e1 = [0,0,1];
e2 = [0,-1,0];
e3 = [1,0,0];
Oe = [1,0.66,0.66];
% Output
[ v1, v2, v3, Ov ] = Orthonormal_Frame( [1,1,0],[1,1,1],[1,0,1] );
disp('Expected:  in order e1,e2,e3,Oe');
disp(e1);
disp(e2);
disp(e3);
disp(Oe);
disp('Calculated: in order v1,v2,v3,Ov');
disp(v1);
disp(v2);
disp(v3);
disp(Ov);