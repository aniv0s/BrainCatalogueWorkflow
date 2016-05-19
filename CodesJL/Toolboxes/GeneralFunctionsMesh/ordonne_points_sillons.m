function [nindices]=ordonne_points_sillons(VertConn,indices,coordonnees)
% R�ordonne les indices suppos�s appartenir � une ligne connexe
% La premi�re extr�mit� correspond au max de coordonnees sur les indices
% A TRAITER : cas de deux ou plusieurs lignes

% Trouve une extr�mit�

extremite=[];
for ii=1:length(indices)
    voisins=VertConn{indices(ii)};
    cpt=0;
    for k=1:length(voisins)
        if ismember(voisins(k),indices)
            cpt=cpt+1;
        end
    end
    if cpt>2
        disp('erreur')
    else
        if cpt==1
            extremite=[indices(ii) extremite];
        end
    end
end

% Parcours la ligne depuis une extr�mit�

if length(extremite)==2
    [v,ind]=max(coordonnees(extremite));
    courant=extremite(ind);
    liste=[];

    for ii=1:length(indices)
        voisins_courant=VertConn{courant};
        prochain=intersect(voisins_courant,indices); % petit bug peut �tre �gal � trois ! cas d'un triangle
        prochain=setdiff(prochain,liste);
        liste=[courant liste];
        if length(prochain)>=2
            longueur_prochain=zeros(length(prochain),1);
            for k=1:length(prochain)
                suivants=VertConn{prochain(k)};
                suivants=intersect(suivants,indices);
                suivants=setdiff(suivants,liste);
                longueur_prochain(k)=length(suivants);
            end
            [v,ind]=min(longueur_prochain);
            courant=prochain(ind);
        else
            courant=prochain;
        end
    end

    nindices=liste;
else
    liste=[];
    [v,ind]=max(coordonnees(extremite));
    courant=extremite(ind);
    extremite=setdiff(extremite,courant);
    for ii=1:length(indices)
        voisins_courant=VertConn{courant};
        prochain=intersect(voisins_courant,indices); % petit bug peut �tre �gal � trois ! cas d'un triangle
        prochain=setdiff(prochain,liste);
        liste=[courant liste];
        if length(prochain)>=2
            longueur_prochain=zeros(length(prochain),1);
            for k=1:length(prochain)
                suivants=VertConn{prochain(k)};
                suivants=intersect(suivants,indices);
                suivants=setdiff(suivants,liste);
                longueur_prochain(k)=length(suivants);
            end
            [v,ind]=min(longueur_prochain);
            courant=prochain(ind);
        else
            courant=prochain;
        end
        extremite=setdiff(extremite,liste(1));
        if isempty(extremite)
            break;
        end
        if isempty(courant)
            [v,ind]=max(coordonnees(extremite));
            courant=extremite(ind);
        end
        
    end
    nindices=liste;
end