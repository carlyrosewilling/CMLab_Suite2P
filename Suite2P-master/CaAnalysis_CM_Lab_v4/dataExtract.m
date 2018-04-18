function data = dataExtract(varargin)


if nargin == 3
    data = ROI_Extract(varargin{1},varargin{2},varargin{3});
elseif nargin == 0
    data = ROI_Extract();
elseif nargin>2 || nargin ==1
    error('Incorrect number of inputs')
else
    
end


numCells = length(data.ROIs);
numFrames = length(data.video(1,1,:));
% fluo = zeros(numFrames,numCells);
% for i = 1:numCells
%     [R,C] = ind2sub(size(data.zproj),data.ROIs{i});
%     temp = data.video(R,C,:);
%     fluo(:,i) = mean(temp(logical(repmat(eye(length(data.ROIs{1})),[1,1,numFrames]))));
% end
% 


tic
fluo = zeros(numFrames,numCells);
for i = 1:numCells
    for ii = 1:numFrames
        frameDat = data.video(:,:,ii);
        fluo(ii,i) = mean(frameDat(data.ROIs{i}));
    end
end
toc
data.fluo = fluo;

end