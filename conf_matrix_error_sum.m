% ugh
function sums =  conf_matrix_error_sum(A)
 sums = (A(1,2) + A(1,3) + ...
         A(2,1) + A(2,3) + ...
         A(3,1) + A(3,2));

end