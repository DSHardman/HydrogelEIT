% Copying code from SH sensor project

x = positions(:,1);
y = positions(:,2);

ypred = sim(results.Network, [responses(:,:)].');

% % convert predictions from normalized to mm
% xfactor = 130/(max(ypred(1,:)) - min(ypred(1,:)));
% xoffset = -xfactor*min(ypred(1,:));
% yfactor = 60/(max(ypred(2,:)) - min(ypred(2,:)));
% yoffset = -yfactor*min(ypred(2,:));
% 
% ypred(1,:) = ypred(1,:)*xfactor + xoffset;
% ypred(2,:) = ypred(2,:)*yfactor + yoffset;

z=rssq((ypred(1:2,:)'-positions(:,1:2))');

mean(z)
max(z)
maxpermitted = 0.04;
z = min(z, maxpermitted); % error cannot exceed corner-to-corner square size

scatter(positions(:,1), positions(:,2), 40, z, 'filled')

% use interpolated contour maps
% interpolant = scatteredInterpolant(x,y,double(z).');
% [xx,yy] = meshgrid(linspace(0,0.13,100), linspace(0,0.06,100));
% error_interp = interpolant(xx,yy);
% contourf(xx,yy,error_interp, 'LineColor', 'none');
% 
% axis('equal')
% colormap('hot')
% caxis([0 maxpermitted])
% %caxis([min(z) max(z)]);
% colorbar()
% %set(gca, 'Visible', 'off');
% xlabel('x (m)');
% ylabel('y (m)');
% title('Capped localisation error (mm)')