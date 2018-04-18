function mimgandcells(ops, data, active)

%Rewritten by: Carly Rose Willing

%----NOTE----%
%Before this script can be run, data must be registered
%ops is the regops file from the registered plane
%data is the F*.mat or F*_proc.mat file for the registered plane
%active = 1 if you only want to look at active cells, active = 0 if you
%want to look at all cells.


dat2 = data;
ops = ops{1};
if active == 1
    index = find(vertcat(dat2.stat(:).iscell));
    dat2.stat = dat2.stat(index);
else 
    for i = 1:length(data.stat)
        dat2.stat(i).iscell = logical(1);
    end 
end
    

%----Initialization Stuff (DON'T TOUCH)----%
stat = [];
xL = [];
yL = [];
clear mimg;

%----Loads Mean Image----%
for iplane = 1:ops.nplanes
    mimg{iplane} = dat2.ops.mimg1(dat2.ops.yrange, dat2.ops.xrange);
    stat = cat(2, stat, dat2.stat);
    yL(iplane) = numel(dat2.ops.yrange);
    xL(iplane) = numel(dat2.ops.xrange);
end


%----Compute ROI Outlines----%
clear img;
ij = 1;
clf; %clears figure

%Following loop computes ROI outlines for each plane individually and
%returns corresponding overlays.
for iplane = 1:ops.nplanes
    mimg{iplane} = mimg{iplane} - min(mimg{iplane}(:));
    mimg{iplane} = mimg{iplane} / max(mimg{iplane}(:));
    
    %Background of Mean Image
    img{iplane} = repmat(mimg{iplane}*2,1,1,3);
    img{iplane} = rgb2hsv(img{iplane});
    img{iplane} = reshape(img{iplane},[],3);
    
    colormap('gray');
    hold all;
    while stat(ij).iplane == iplane 
        if stat(ij).iscell
            %Finds pixels that are exterior to the cell 
            idist  = sqrt(bsxfun(@minus, stat(ij).xpix', stat(ij).xpix).^2 + ...
                bsxfun(@minus, stat(ij).ypix', stat(ij).ypix).^2);
            idist  = idist - diag(NaN*diag(idist));
            extpix = sum(idist <= sqrt(2)) <= 6;
            xext = stat(ij).xpix(extpix);
            yext = stat(ij).ypix(extpix);
                
            %Colors the exterior pixels
            ipix = sub2ind([yL(iplane) xL(iplane)], yext, xext);
            img{iplane}(ipix, 1) = rand;
            img{iplane}(ipix, 2) = 1;
            img{iplane}(ipix, 3) = 1;
            
            
        end
        
        ij = ij+1;
        
        if ij > numel(stat)
            break;
        end
    end
    
end

%%
clf;
set(gcf,'color','w');

%Plot of one plane with circled ROIs
iplane = 1; %Specify which plane 

imgj = img{iplane};
imagesc(hsv2rgb(reshape(imgj,yL(iplane),xL(iplane),3)))
if active == 1
    title('Mean Image with Active Cells');
else
    title('Mean Image with All Cells');
end 
axis off;
axis square;

    
    
  
