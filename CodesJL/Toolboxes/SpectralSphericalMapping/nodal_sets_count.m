function [posneg,VertConn]=nodal_sets_count(FV,V,ii1,ii2,VertConn,alpha)
if nargin<5
    VertConn=vertices_connectivity(FV);
end
if nargin<6
    alpha=10;
end
for ii=ii1:ii2
    texture=ones(size(V,1),1);
    M=max(V(:,ii)); 
    %M=0;
    texture(find(V(:,ii)<M/alpha))=0;
    nbr=connex_comp_mesh(FV,VertConn,texture);
    posneg(ii,1)=nbr;
    
    texture=ones(size(V,1),1);
    M=min(V(:,ii));
    texture(find(V(:,ii)>M/alpha))=0;
    nbr=connex_comp_mesh(FV,VertConn,texture);
    posneg(ii,2)=nbr;
    %ii
end