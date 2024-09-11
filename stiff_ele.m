function [k_vector] = stiff_ele(m,n,elas,e_area,e_len)
%*************************************************************************

%   modulus multiplier

%   local stiffness
%   [k0 -k0
%    -k0 k0]
%   element loop
k_vector_0 = elas * e_area / e_len * ones(m,n);
option = 2;
switch option
    case 1
        x = 1:m;
        invdiviation=1;
        distribution = exp(-invdiviation*(x-(m)/2).^2);
        
        % because the element number is vertical and the matlab indexing is column
        % based, we take transpose
        k_vector = transpose(k_vector_0.* repmat(distribution',1,n));
    case 2
        distribution2 = 0.5*ones(m,n);
        distribution2(m/2,:) = 1;
        k_vector = transpose(k_vector_0.*distribution2);
end

end
