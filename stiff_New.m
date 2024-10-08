function [K] = stiff_New(m,n,connect,k_vector)
%*************************************************************************
%
%           /====|    |=====|     |===|     |=====|    |=====|
%          |             |          |       |          |
%           \===\        |          |       |===|      |===|
%                |       |          |       |          |
%          |====/       |=|       |===|     |          |          _ NEW
%
%*************************************************************************
%   STIFFNESS MATRIX for a linear elastic - brittle m x n nacre system
%
%       Input: m = number of (zig-zag) rows (elements)
%              n = number of (zig-zag) columns (elements)
%              connect = connectivity matrix (num._of_ele by 2)
%              elas = elastic modulus
%              e_area = element cross-section area
%              e_len = element length
%
%       Output: K = Global Stiffness Matrix
%
%       Warning: 1. m,n MUST be EVEN numbers!
%                2. This code works only with LINEAR ELASTIC material!
%                3. This stiffness matrix is for the INITIAL step ONLY!
%
%   Wen Luo
%   5/16/2017
%   Houlin Xu
%   2/4/2024 modify K matrix to be sparse matrix for HPC
%*************************************************************************
%*************************************************************************
%   total number of nodes
tot_num_n = ( n + 1 ) * m / 2 + n / 2;
%   total number of elements
tot_num_e = m * n;
%   modulus multiplier

%   initialize global stiffness matrix K
%    K = zeros(tot_num_n);
%   initialize the index
i = zeros(4*tot_num_e,1);
j = zeros(4*tot_num_e,1);
s = zeros(4*tot_num_e,1);
index = 0;

%   local stiffness
%   [k0 -k0
%    -k0 k0]
%   element loop


for ii = 1:tot_num_e
        k0 = k_vector(ii) *[1 -1;-1, 1];
        for ti = 1:2
            for tj = 1:2
                index = index+1;
                i(index) = connect(ii,ti);
                j(index) = connect(ii,tj);
                s(index) = k0(ti,tj);
            end
        end
end
    K = sparse(i,j,s,tot_num_n,tot_num_n);
end

