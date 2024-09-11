function [K] = stiff_Update_s_new(i_fail,K_old,n,m,connect,stiff_old,stiff_new)
%*************************************************************************
%
%           /====|    |=====|     |===|     |=====|    |=====|
%          |             |          |       |          |
%           \===\        |          |       |===|      |===|
%                |       |          |       |          |
%          |====/       |=|       |===|     |          |        _UPDATE
%
%*************************************************************************
%   update STIFFNESS MATRIX for m x n nacre system with SOFTENING
%                                                      ^^^^^^^^^^^
%       Input: i_fail = index of newly failed element
%              K_old = old stiffness matrix
%              connect = connectivity matrix (num._of_ele by 2)
%              stiff_old = old link stiffness to be replaced
%              stiff_new = new link stiffness to update
%
%       Output: K = New Global Stiffness Matrix
%
%       Warning: 1. m,n MUST be EVEN numbers!
%                2. This code works only with LINEAR ELASTIC material!
%
%   Wen Luo
%   8/22/2017
%*************************************************************************
%*************************************************************************
%   total number of nodes
    tot_num_n = ( n + 1 ) * m / 2 + n / 2;
%   make index, there is only one failed link
    i = zeros(4,1);
    j = zeros(4,1);
    s = zeros(4,1);
    index = 0;
    k0_new = [1 -1;-1 1]*(- stiff_old + stiff_new);
    for ti = 1:2
        for tj = 1:2
            index = index+1;
            i(index) = connect(i_fail,ti);
            j(index) = connect(i_fail,tj);
            s(index) = k0_new(ti,tj);
        end
    end

    K = K_old + sparse(i,j,s,tot_num_n,tot_num_n);
    % K = K_old;
    % % node number 1 of Ke (element stiffness)
    % n1 = connect(i_fail,1);
    % % node number 2 of Ke
    % n2 = connect(i_fail,2);
    % % update Ke: k0 * [1,-1;-1,1]
    % K(n1,n1) = K(n1,n1) - stiff_old + stiff_new;
    % K(n1,n2) = K(n1,n2) + stiff_old - stiff_new;
    % K(n2,n1) = K(n2,n1) + stiff_old - stiff_new;
    % K(n2,n2) = K(n2,n2) - stiff_old + stiff_new;
end