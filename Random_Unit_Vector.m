% 6. Generate-Random-Unit-Vector
% code is self explanatory

function v = Random_Unit_Vector( dimension )
    v = randn(dimension,1);
    v = v./norm(v);
end